# Learn Everything — Study System｜通用學習系統

將任何想學的主題，變成一套有進度、有練習、有回饋的每日學習流程。

適用於職場英語、日文、程式設計、Kubernetes、演算法、會計等主題。系統先了解你的目標與程度，再安排適量課程；用主動輸出、錯題紀錄與間隔複習追蹤你是否真的會用。

## 安裝與初次使用

### 1. 安裝 skill

使用 [Skills CLI](https://github.com/vercel-labs/skills)，採用與 [mattpocock/skills](https://github.com/mattpocock/skills#installation-30-second-setup) 相同的 `npx skills add` 安裝方式。先安裝 Node.js（含 npm / npx）與 Git，在終端機執行：

```sh
npx skills@latest add yydr314/learn-everything
```

依提示選擇 `study-system` 與要使用的 agent。預設安裝在目前專案；若希望跨專案使用，可全域安裝。以下直接指定 Codex：

```sh
npx skills@latest add yydr314/learn-everything --skill study-system --agent codex --global
```

Windows 若無法建立符號連結，可加 `--copy`。安裝需要網路下載 CLI 與 skill；只想查看可安裝項目時使用：

```sh
npx skills@latest add yydr314/learn-everything --list
```

### 2. 直接開始學習

在你的 agent 開啟新對話，輸入：

> 使用 $study-system 帶我學英文，每天 30 分鐘。

**初次使用就會自動進行入門設定，不需要另外說「setup」。** 系統第一輪回覆會詢問學習需求，並主動讓你複選：每日教材 Email、複習／上課提醒、每週學習報告寄送、雲端同步、日曆排課、外部字卡或自訂自動化；也可以選擇只在對話學習或稍後決定。選擇外部流程後，會確認收件人／目的地、時區、時間與操作範圍，實際檢查對應服務。

**尚未串接或權限不足時，系統會提醒你連接服務、開啟必要權限，並將該流程列為待設定。** 完成連接後說「已連接好了」即可接續驗證。可先開始對話課程；只有具備能力、已授權且工具回報成功的流程，才會顯示已啟用。

### 3. 更新或移除

```sh
npx skills@latest update
npx skills@latest remove study-system
```

`update` 會檢查 CLI 管理的已安裝 skills；更新前先備份自行修改的 skill 檔案。全域安裝移除時加 `--global`。學習紀錄應保存在獨立資料目錄，更新／移除 skill 不需刪除學習紀錄。

先前用本專案腳本安裝的版本，請先備份並將原 `study-system` 移出技能搜尋目錄，再以 CLI 重新安裝；避免專案與全域保留重複版本。CLI 安裝與手動腳本擇一使用。

### 離線備用安裝

沒有 Node.js 時，可[下載完整 ZIP](https://github.com/yydr314/learn-everything/archive/HEAD.zip)，解壓後在 Windows 雙擊 `install.cmd`，或在 macOS / Linux 執行 `sh install.sh`。腳本本身不連網，預設安裝到 `~/.agents/skills/study-system`；不能只下載腳本。

自訂位置時，參數是技能目錄的父資料夾：

```powershell
# Windows PowerShell
./install.ps1 -SkillsDir './.agents/skills'
```

```sh
# macOS / Linux
sh install.sh './.agents/skills'
```

安裝器不覆寫既有的 `study-system`。更新時先將原有技能資料夾備份移出技能搜尋目錄，再執行新版安裝器；學習資料應另存，不放在技能資料夾內。移除時刪除安裝的技能資料夾即可，獨立保存的學習紀錄不受影響。

## 開始學習

安裝完成後，可以直接說：

> 使用 $study-system 帶我學 Kubernetes。我的目標是能獨立排查服務連線問題，每天 30 分鐘，週末休息。請先診斷我的程度。

也可以換成：

> 使用 $study-system 帶我練習職場英文。我目前約多益 590 分，希望能在軟體工程會議中清楚表達想法。

系統會確認你的學習目標、先備知識、教學語言、每日時間、時區、休息規則，以及想啟用的 hook 流程。以上程度與時間只是示例，不會套用到每個人。

| 想做的事 | 可以這樣說 |
|---|---|
| 開始每日流程 | 「開始今天的學習」 |
| 快速複習 | 「我要今天的 Flashcards」 |
| 間隔複習 | 「開始今天的 Spaced Review」 |
| 接續未完成的課 | 「繼續上一課」 |
| 結課後繼續學 | 「我還想繼續」 |
| 查看成果 | 「產生本週學習報告」 |

## 每日流程

**每日教材 → Flashcards / Spaced Review → 正式課程 → 獨立輸出 → 回饋與複習文件**

預設每天約 50–60 分鐘，可依你的時間調整。每個 Day 份量大致相等；課程完成會明確顯示 **「✅ Day X 今日課程結束」**。如果還想繼續，直接進入下一個 Day，不無限追加當天作業。

## 包含哪些功能？

- **休息規則**：工作日學習；週末、公定假日及自訂休假不主動派課，不累積加倍補課。
- **每日教材**：先閱讀與作答，再看 Vocabulary／關鍵概念，最後查看答案。可在對話交付或透過 Email 發送。
- **Flashcards 與 Spaced Repetition**：優先複習到期與不熟的概念，以新情境檢查能否運用。
- **Mistake / Error Log**：保留原始作答、修正與再次評量結果。
- **能力追蹤與圖表**：指標依主題替換；只使用實際評量證據，不虛構進步。
- **每日複習文件與週報**：整理學習成果、反覆錯誤與下一步重點。
- **答案延遲清理**：可設定暫存答案至少保留 72 小時，遇休息日順延；啟用清理前需授權。

## 可選服務

初次使用會主動詢問以下可選流程；不用串接服務也能在對話中開始學習，之後可隨時調整：

| Hook | 用途 |
|---|---|
| Gmail／其他郵件服務 | 每日教材寄送 |
| Google Drive／其他儲存服務 | 保存設定、教材、錯題、能力資料與報告 |
| Calendar／假日日曆 | 學習時段、衝突檢查及休假判斷 |
| Flashcards | 卡片管理與回想紀錄 |
| Automations | 在已授權的時段執行工作 |

本套件提供工作流程與整合契約，不內建這些服务的帳號連線，也不保證每個宿主都有對應工具。**安裝不等於啟用寄信、同步或排程。** 只有實際工具執行成功，系統才會回報已完成；沒有永久儲存能力時會提供可保存的紀錄。

## 自訂與檔案導覽

| 檔案 | 用途 |
|---|---|
| [SKILL.md](SKILL.md) | 技能入口與核心教學流程 |
| [agents/openai.yaml](agents/openai.yaml) | 顯示名稱與呼叫提示 |
| [assets/profile.template.json](assets/profile.template.json) | 學習目標、時間、指標與 hooks 設定 |
| [assets/document-templates.md](assets/document-templates.md) | 教材、答案、每日複習與週報範本 |
| [references/learning.md](references/learning.md) | 主題設計、複習與評量 |
| [references/scheduling.md](references/scheduling.md) | 假日、排程與清理政策 |
| [references/data.md](references/data.md) | 資料契約及 Drive 儲存結構 |
| [references/hooks.md](references/hooks.md) | 外部服務的整合契約 |
| [references/acceptance.md](references/acceptance.md) | 行為驗收情境 |

首次使用將 profile 範本複製到獨立學習資料儲存區；空值代表待設定。不同使用者與主題使用獨立紀錄，分享技能時不要包含學習資料、收件人資訊或存取憑證。
<<<<<<< Updated upstream
=======

## 發布與維護

儲存庫根目錄的 `SKILL.md` 可供 Skills CLI 探索，無需另外發布 npm 套件。維持 agents、assets、references 與入口的相對路徑；fork 到其他儲存庫時，請同步修改上方安裝指令的 owner/repo。修改需推送到 GitHub 後，遠端安裝才會取得新版。

本機可先用 `npx skills@latest add . --list` 驗證探索；如需試裝，從獨立測試目錄用 `npx skills@latest add <本機儲存庫絕對路徑> --skill study-system --agent codex --copy`，不要加 `--global`。離線備用腳本僅複製技能入口、README、agents、assets、references。

安裝器驗證使用隔離目錄：`tests/test-install.ps1` 與 `tests/test-install.sh`。測試成果存於被 Git 忽略的 `.test-output/`；測試不會安裝到你的正式技能目錄。GitHub Actions 會在 Windows、Ubuntu、macOS 執行安裝測試，請以各次執行結果確認相容性。修改教學規則後也請檢查 [行為驗收情境](references/acceptance.md)。
>>>>>>> Stashed changes
