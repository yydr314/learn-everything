# Learn Everything — Study System｜通用學習系統

將任何想學的主題，變成一套有進度、有練習、有回饋的每日學習流程。

適用於職場英語、日文、程式設計、Kubernetes、演算法、會計等主題。系統先了解你的目標與程度，再安排適量課程；用主動輸出、錯題紀錄與間隔複習追蹤你是否真的會用。

## 一鍵安裝

**[下載安裝包（ZIP）](https://github.com/yydr314/learn-everything/archive/HEAD.zip)** · **[GitHub 儲存庫](https://github.com/yydr314/learn-everything)**

下載完整 ZIP（或在 GitHub 點選 **Code → Download ZIP**），解壓縮後：

| 系統 | 安裝方式 |
|---|---|
| Windows | 雙擊 **[install.cmd](https://github.com/yydr314/learn-everything/blob/HEAD/install.cmd)** |
| macOS / Linux | 在解壓縮的資料夾執行 **`sh install.sh`** |

Windows 使用系統內建 Windows PowerShell；macOS / Linux 使用 `sh`。不需 Python、Node.js 或額外套件，安裝過程不連網。請下載整個儲存庫，不能只下載安裝腳本。GitHub 頁面上的連結負責下載，解壓後才執行安裝。

已安裝 Git 的使用者也可以下載後直接安裝：

```powershell
git clone https://github.com/yydr314/learn-everything.git
if ($LASTEXITCODE -eq 0) { & ./learn-everything/install.cmd }
```

```sh
git clone https://github.com/yydr314/learn-everything.git && sh learn-everything/install.sh
```

安裝器會將技能與配套文件安裝到 `~/.agents/skills/study-system`。完成後，在 Codex 開啟新對話並輸入 `$study-system`；若未出現，重新啟動應用程式。這個安裝位置依據 [OpenAI 的技能文件](https://learn.chatgpt.com/docs/build-skills)。

這是技能檔案的安裝器，不會把技能發布到 ChatGPT 網頁版或插件商店。其他支援 Agent Skills 的應用程式，請使用其技能匯入功能；跨 ChatGPT 介面的分發方式請參考 [官方插件封裝說明](https://developers.openai.com/plugins/build/plugins)。

### 自訂安裝位置

參數是「技能目錄的父資料夾」，安裝器會在其下建立 `study-system`：

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

系統會確認你的學習目標、先備知識、教學語言、每日時間、時區與休息規則。以上程度與時間只是示例，不會套用到每個人。

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

不用串接服務就能在對話中開始學習。要長期保存紀錄、寄信或自動提醒，再依需求配置 hooks：

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

## 發布與維護

將本資料夾的內容作為 GitHub 儲存庫根目錄上傳，README 和安裝腳本即可使用，不需要填寫固定的儲存庫網址。安裝器僅複製技能入口、README、agents、assets、references，其他資料不會一併安裝。

安裝器驗證使用隔離目錄：`tests/test-install.ps1` 與 `tests/test-install.sh`。測試成果存於被 Git 忽略的 `.test-output/`；測試不會安裝到你的正式技能目錄。GitHub Actions 會在 Windows、Ubuntu、macOS 執行安裝測試，請以各次執行結果確認相容性。修改教學規則後也請檢查 [行為驗收情境](references/acceptance.md)。
