# 可複用輸出範本

雙大括號欄位由實際資料填入；這些是範本變數。無資料寫「尚未評量／待設定」，不要虛構。語言與主題自行調整。

## 每日教材／Email

Subject: {{subject_name}}｜Day {{day}}｜{{topic}}

今日目標：{{observable_goal}}（約 {{minutes}} 分鐘）

{{short_material_with_reliable_source_if_needed}}

練習（先作答）：
1. {{comprehension_or_concept_question}}
2. {{application_question}}
3. {{short_independent_output_if_within_budget}}

### Vocabulary｜關鍵詞與概念

| 詞彙／術語／符號 | {{instruction_language}} 解釋 | 情境／例子 |
|---|---|---|
| {{term}} | {{meaning}} | {{example_without_answer_leak}} |

Check answers：{{verified_answer_link_or_return_to_chat_instruction}}
答案檔至少保留 3 天；若到期遇休息日順延清理。請先作答再查看。

## 獨立答案文件

# Day {{day}} 答案 v{{version}}
發布：{{published_at}}；最早清理：{{expires_at}}；休息日順延。

每題：正確／參考解法、推理、常見誤解與評分依據。
{{answers_and_explanations}}

## 每日複習文件

# {{subject_name}}｜Day {{day}} 複習

- 學習日期：{{actual_dates}}；狀態：{{learning_status}}
- 今天完成的目標：{{completed_goals}}
- 重點 1–3 項：{{key_concepts}}
- 原始作答 → 修正 → 原因：{{evidence_backed_corrections}}
- 獨立輸出與回饋：{{output_and_feedback}}
- 新卡／到期複習結果：{{review_summary}}
- 能力觀察：{{metric_scores_with_evidence_or_not_assessed}}
- 可選短自測：{{one_or_two_questions}}
- 自測解答（先作答再看）：{{solutions}}
- 下次複習：{{next_due_items_and_dates}}
- 下一課方向：{{next_day_goal}}
- 儲存／同步狀態：{{storage_status}}

## Weekly Learning Report

# {{subject_name}}｜{{local_iso_week}} 學習報告

資料截止：{{cutoff_timestamp}}；量尺版本：{{rubric_version}}

| 完成 Day 數 | 實際學習日數 | 已知學習時間 | 未完成／缺資料 |
|---:|---:|---|---|
| {{completed_days}} | {{distinct_dates}} | {{observed_minutes_or_unknown}} | {{incomplete_or_missing}} |

本週主題與成果：{{topics_and_artifact_links}}
反覆錯誤：{{recurring_errors_with_counts}}
改善證據：{{before_after_comparable_examples}}
新 Vocabulary／關鍵概念：{{new_terms}}
獨立輸出表現：{{independent_performance}}
複習狀態：{{new_learning_review_mastered_counts_and_due_queue}}

能力趨勢：{{chart_or_table_with_scale_dates_sample_sizes}}
解讀限制：{{missing_evidence_or_rubric_changes}}
下週優先事項（最多 3 項，維持每日預算）：{{priorities}}

## 課程結束訊息

✅ Day {{day}} 今日課程結束

今天掌握：{{two_or_three_takeaways}}
複習文件：{{verified_path_or_inline_content}}
下次方向：{{next_goal}}
{{pending_sync_only_if_present}}

若使用者接著要求繼續，直接開 Day {{next_day}}；不要再次要求確認。
