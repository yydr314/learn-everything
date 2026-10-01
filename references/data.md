# 學習資料、Drive 結構與一致性

Skill 是可分享的規則包；學習者資料存獨立的儲存區。每個 learner_id / subject_id 獨立，切換主題不覆寫其他主題。以下邏輯結構可映射至 Google Drive 或使用者選擇的儲存服務；依已啟用功能建立需要的項目即可。

```text
Learn Everything/
  learner-id/
    subject-id/
      00-profile/profile.json
      00-profile/curriculum.md
      01-lessons/Day-0001.md
      02-materials/Day-0001.md
      03-answers/Day-0001-v1.md
      04-daily-review/Day-0001.md
      05-flashcards/cards.json
      06-error-log/errors.json
      07-progress/observations.json
      07-progress/charts/
      08-weekly-reports/2026-W40.md
      09-state/sessions.json
      09-state/review-events.json
      09-state/artifacts.json
      09-state/operations.json
      09-state/holiday-cache.json
      10-archive/
```

可改用 Sheets / 資料庫保存同等表格，不要求同時維護多套可寫真相來源。profile 明定 canonical_store，其他儲存區只是備份或待同步副本。canonical_store 尚未設定時先提供對話紀錄，不假定已有永久保存能力。以不可變 ID 引用，不靠檔名尋找後任意取第一筆。

## 最小資料契約

所有紀錄帶 schema_version、learner_id、subject_id、created_at、updated_at；timestamp 用 ISO 8601 含 offset，local_date 用使用者時區。允許無資料為 null；禁止填入假的成功紀錄。

| Record | 必需欄位與不變條件 |
|---|---|
| Session | session_id、day_number、planned_date、started_at、completed_at、status、checkpoint、stage_completion、planned_minutes、actual_minutes、sync_status、version；同一主題 Day 唯一，actual_minutes 不可由猜測填入 |
| Stage completion | material / review / core / application / output 各有 status、evidence_ids、adjustment_reason；新手無到期項可記 not_applicable 並註明理由 |
| Evidence | evidence_id、session_id、prompt、original_response、feedback、assisted、source、observed_at；保留原始作答與更正版本 |
| Error | error_id、concept_id、category、original_response、correction、explanation、event_ids、review_item_id、status；同一概念可連多次出錯事件 |
| Card / review item | item_id、concept_id、front、back、source_id、stage、streak、status、last_reviewed_at、raw_due_at、next_due_at、transfer_success、event_ids |
| Review event | event_id、item_id、session_id、response、result、assisted、was_due、is_transfer、observed_at；event_id 去重，同一天最多一次成功升級 |
| Observation | observation_id、metric_id、rubric_version、score、max_score、evidence_id、independent、difficulty、observed_at；未測 score=null |
| Artifact | artifact_id、kind、provider、external_id/path、parent_id、system_owned、published_at、expires_at、pinned、status、version；cleanup 只能用精確 ID |
| Operation | operation_id、idempotency_key、action、target_id、status、attempts、receipt、last_error、authorization_ref；unknown 先查詢再重試 |
| Holiday cache | region、timezone、source、verified_at、coverage_start/end、holiday_dates/types、custom_rest_dates；超出涵蓋範圍是 unknown |

## 保存順序

先保存原始學習事件與 checkpoint，再更新彙總、衍生圖表及遠端服務。可用交易則一次提交；無交易則用 operation/event ID 與版本做可重入寫入。重跑同一收尾不能新增第二個 Day、第二張同概念卡或第二筆得分。

文字匯出使用 UTF-8。儲存服務寫入先查記錄的資源 ID，成功後保存回執。學習已完成但同步失敗時保留 learning_complete、sync_status=failed；下次只補同步。沒有永久儲存能力時直接告知並提供可保存的紀錄，不能宣稱已記住跨對話資料。

## 每日與每週交付

每日複習以 Day 為唯一鍵，含實際學習日期、概念、表現、錯誤、修正、短自測與答案、下次複習。不把自測列為「今天還未完成的必做作業」。

週報以當地 ISO week 為鍵，統計完成的 Day、實際學習日數、經使用者回報或工具觀測的時間、重複錯誤、改善證據、新術語、輸出表現、能力圖表、下週 1–3 個重點。一天上两個 Day，要分開報 Day 數與日數。缺資料清楚標示；不把休假納入缺課率。
