# 可替換外部服務 hooks

這些是行為契約，不是已實作 API。先探索宿主真正可用的工具與授權，再映射到對應服務；不要依文件名稱虛構工具。每個 hook 可為 disabled、manual、connected、error，預設 manual。需要時遵循該宿主的服務技能。

## 初次使用：選擇與連線檢查

這是首次使用本學習系統自動執行的入門流程，不以使用者輸入 setup 或要求串接服務為前提。在初次回覆中，和學習需求一起提出簡短的可複選問題；不要只問籠統的「需要其他功能嗎」。例如：

> 你希望加入哪些學習流程？可複選：① 每日教材寄 Email；② 複習／上課提醒；③ 每週學習報告寄送；④ 雲端保存學習紀錄；⑤ 日曆排課；⑥ 外部字卡；⑦ 其他自動化。也可以選「只在對話學習」或「稍後決定」。

已提供的需求直接沿用，只補問尚未決定的項目。各種寄送／提醒流程分開選擇；同意每日 Email 不等於同意週報或其他通知。選「稍後決定」或未回答時保留待確認，不啟用外部流程、不反覆催問，也不阻擋對話學習。

1. 對選取的流程補齊用途、服務供應商、目標（收件人／資料夾／日曆／卡組）、觸發時機、時區與允許的操作。排程預設值是建議，不能直接當作已授權時段。自動寄信需同時設定 mail 與 automations；自動化還需能讀取學習紀錄與假日狀態。不要因選一個流程而默默啟用其他外部服務。
2. 探索目前宿主的 connector／plugin／工具，用服務狀態或最小唯讀查詢確認帳號、目標資源及操作權限。安裝 skill、看到工具名稱、使用者說曾連線、舊 profile 的 connected 都不是本次驗證。唯讀查詢成功也不代表具備寄信或寫入權限；無法查證的能力記為 unverified，不用測試寄信、建事件或刪檔來探測。
3. 缺少連線時，明確說「此流程尚未啟用，請在目前應用程式的連接器／外掛設定中連接所選服務，並開啟此流程需要的權限」。列出所需能力，例如寄送郵件、指定資料夾讀寫、指定日曆讀寫；若工具可提供連線入口就附上。權限不足或過期則提示補授權／重新連線；宿主根本不支援時說明限制，不把缺工具誤報為拒絕授權，也不編造設定路徑。不要要求使用者在對話貼密碼或 token。
4. 用 profile.hook_setup 保存選擇；每個 workflow 記錄 description、hooks、trigger、target、authorization_ref、status、blockers。status 用 pending / ready / disabled：只有使用者明確拒絕才是 disabled，未回答時 completed_at 保持 null。各 hook 的 verification 記錄 status（unverified / verified / missing_connection / missing_permission / unsupported / error）、checked_at、capabilities、evidence_ref；證據引用工具結果，不保存憑證。舊 profile 缺欄位時視為尚未確認，不推定已同意。
5. 僅在依賴全部可用且操作已獲授權時啟用流程。mode=connected 表示服務與所需能力已驗證；workflow ready 還需設定完整及成功建立必要排程（保存 job_id）。若能力只能在實際操作時驗證，先完成可查看的內容與目標，在使用者既有授權範圍內執行該操作，依真實結果更新驗證；不另做有副作用的測試。一般讀取權限不等於使用者授權寄信、分享或清理。
6. 缺少依賴的流程保持 pending，hook 保持 manual（執行故障可為 error）；提供教材／草稿／手動排程替代，繼續可進行的課程。使用者完成串接後重新驗證，只處理該流程的缺項，沿用既有明確授權；啟用前查既有 job_id，避免重建排程。之後權限被撤銷時暫停受影響流程並再次提醒。

setup 摘要逐項列出「選擇的流程／服務／狀態／下一步」，有 pending 就不能宣稱所有服務設定完成。hook_setup.completed_at 表示已完成偏好訪談與摘要，不代表每個流程已啟用。

## 共用契約

輸入至少帶 learner_id、subject_id、operation、idempotency_key、payload、授權範圍。输出記錄 status（prepared / succeeded / failed / unknown）、provider、external_id、url（可無）、timestamp、error。只有驗證成功才能聲稱已寄送／已儲存／已排程。

啟用前先準備可查看內容與目標，再取得尚缺的必要授權。既有明確授權持續有效，不重問。只啟用使用者要求的服務。未知結果先用外部 ID／穩定鍵查詢，禁止盲目重送；查詢或安全重試最多兩次，仍失敗則保留 pending 工作與可匯出的成果。

## Hooks 對照

| Hook | 輸入 → 輸出 | 無服務時替代 |
|---|---|---|
| mail（Gmail 或其他） | 已確認收件人、標題、教材、答案入口 → message_id | 對話教材或 email 草稿，不宣稱已寄送 |
| storage（Google Drive／其他儲存服務） | 根目錄 ID、邏輯路徑、內容、版本 → artifact_id / url | 可匯出文件；無檔案工具就輸出可保存文字 |
| calendar（Google Calendar 或其他） | 時區、已查核日期、時段、衝突結果 → event_id | 排程表；可生成匯入檔但不宣稱已加入日曆 |
| holiday_calendar | 地區、日期範圍、假日類型 → 日期集＋來源＋查核時間 | 使用者提供休假表；未知狀態暫停自動推送 |
| flashcards | deck_id、卡片及 review event → item_id / 回想結果 | 對話逐張揭答；JSON/CSV 記錄 |
| automations | 時區、觸發、守門、操作範圍 → job_id | 學生下次輸入「開始學習」時執行到期工作 |
| assessment / charts | 指標、量尺、證據與觀察值 → 評量與圖表資源 | 資料表與標示限制的文字趨勢 |
| cleanup | 已到期的精確 artifact_id＋保留政策 → audit 結果 | 候選清單；未授權不刪除 |

寄信需要使用者指示啟用寄信及其提供／確認的收件人。模擬職場回信預設在學習對話中，不寄給真實同事。Drive 分享不預設公開，答案連結沿用適當權限，不為了讓按鈕可用而擅自開公開存取。

## Automations 指令範本

把下列契約改成該宿主支援的排程格式；不把文字範本當已建立的自動化。

「在設定的當地時間讀取 profile 與 session 最新版本，檢查工作日、公定休假與自訂休假；休息或假日資訊未知時不主動推送。依 session 解析當前 Day，以穩定工作鍵查重後執行指定工作。不要假定學生已作答。紀錄成功回執或待同步結果。除了使用者訂閱的教材／提醒，只在有重要失敗或需要使用者處理時通知，不回報無變化的狀態。」

不同操作分開授權與查重：每日教材鍵用 learner/subject/day/email；複習提醒用 learner/subject/local-date/review；週報用 learner/subject/local-week/report；清理用 artifact_id/expiry-version。只修改已登記、屬於此學習系統的 jobs。

## 移植與失敗恢復

保存外部 ID 和 canonical record 的對應。服務恢復時依 pending operation 重讀遠端狀態後同步，不能重算學生得分或重複增加 streak。改供應商先匯出紀錄及 ID 對照，新的 hook 沿用 learner / subject / concept / session ID。不要把個人資料、帳號或憑證打包進公開 skill。
