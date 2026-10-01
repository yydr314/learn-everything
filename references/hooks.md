# 可替換外部服務 hooks

這些是行為契約，不是已實作 API。先探索宿主真正可用的工具與授權，再映射到對應服務；不要依文件名稱虛構工具。每個 hook 可為 disabled、manual、connected、error，預設 manual。需要時遵循該宿主的服務技能。

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
