# 凇鹤拼音 (Rime-Crane) 架构与维护规范

本项目整合了**雾凇拼音 (rime-ice)** 的拼音基础能力与**官方小鹤双拼/音形 (flypy)** 的形码体系。

---

## 1. 架构总览

### 1.1 方案组成
* **`xhup.schema.yaml`**：小鹤音形纯码表方案（四码定长、分号次选、快符引导、二简提示）。
* **`double_pinyin_flypy.schema.yaml`**：小鹤双拼方案，支持反引号键（`` ` ``）引导辅助形码过滤（`xhup_aux`），并集成雾凇全套拼音词库、中英混输与自动空格排版。
* **`xhup_aux.schema.yaml` / `xhup_aux.dict.yaml`**：单字小鹤音形后二码形码词典，由脚本从主字表中全量派生。
* **`xhup_reverse.schema.yaml` / `xhup_reverse.dict.yaml`**：音形全码反查词典，支持以 `` ` `` 作为通配万能键反查编码与字形。

### 1.2 词库分层结构 (`xhup.dict.yaml`)
对齐官方清风便携版（WindInput）分层理念：
* **用户优先层**：
  * `xhup.user.top`：用户自定义置顶词库
  * `xhup.user`：用户自用词库
* **① 熟手模式基础库（默认启用）**：
  * `xhup.primary`：官方首选字词（68,572 条，从 `00_xh.wdat` 无损保序解包）
  * `xhup.secondary`：分类词库：次选字词（1,666 条）
  * `xhup.whimsicality`：分类词库：随心码（26 条）
  * `xhup.off-table`：分类词库：表外字（362 条，包含粤语高频表外字）
  * `xhup.single.code`：一简次选（26 条单字与高频词）
  * `xhup.fast.symbols`：分号快符（24 条，同步官方最新快符键位）
* **② 常规模式扩展**：
  * `xhup.full.code.words`：已有简码的全码词（500 条）
* **③ 初学模式扩展（按需启用）**：
  * `xhup.full.code.chars`：已有简码的全码字（1,654 条）
  * `xhup.rare.chars`：生僻字库（498 条）
* **可选附加库**：
  * `xhup.secondary.simple`：二简次选（66 条二重简码）
  * `xhup.symbols`：符号与部首字根（896 条）
  * `xhup.ok`：ok 引导两分/三分拆字拼字库（88,020 条）
  * `xhup.emoji`：斜杠引导 Emoji 表情库（26 条）

---

## 2. 官方清风便携版码表同步工作流

小鹤音形官方挂接平台已演进至 **清风输入法便携版（WindInput）**。本仓库内置无损提取与自动化同步工具，无需依赖闭源 Windows 程序。

### 2.1 依赖工具
* **Python 3.8+**（纯标准库，无第三方包依赖）
* **Go 1.18+**（用于编译 `xhup_aux`）
* **Clang / GCC**（可选，用于编译 librime 原生测试驱动）

### 2.2 一键全量同步步骤
当官方发布清风便携版新版本（如 `v1.26.9d` 或更高版本）时：

1. 将官方压缩包解压至仓库根目录（目录名匹配 `小鹤音形_清风便携版*`，已被 `.gitignore` 忽略）；
2. 运行同步脚本提取全部码表并清洗语法：
   ```bash
   python3 others/script/sync_from_qingfeng.py
   ```
   *脚本会自动解析 `00_xh.wdat`（DAT v6 格式）并按 `order` 物理序精准还原，同步分类库、简码、快符、符号、表情以及二简词提示 `opencc/short_hints.txt`。*
3. 重新生成双拼反查形码词典：
   ```bash
   cd others/script && go run ./xhup_aux
   ```
4. 执行对验证明与端到端测试：
   ```bash
   # 验证输出与官方原包逐行对齐
   python3 others/script/verify_against_official.py

   # （macOS）编译并运行 librime 真实引擎测试驱动
   clang -O2 others/script/test_engine.c -o others/script/test_engine
   ./others/script/test_engine xhup b c la lom xnhe hhfg jw jiww buzd gjkg xikx orq ouj ";" ";p"
   ```
5. 使用 `git diff` 审阅官方字词与调频变动，确认无误后提交代码。

---

## 3. 维护规范与注意事项

1. **绝对禁止直接提交便携版二进制程序**：
   官方解压包内的 `*.exe`, `*.dll`, `*.octrie` 均属构建原材料，严禁计入 Git 历史。
2. **保序原则 (`sort: original`)**：
   小鹤音形强依赖重码词序。`xhup.primary.dict.yaml` 必须严格保持官方原版 `order` 自然序，不得按字母或拼音重新排序。
3. **快符与命令清洗**：
   清风输入法专用的 `$CC(...)`、`ime.pair(...)` 等脚本在导入 Rime 时已由 `sync_from_qingfeng.py` 自动清洗为纯净字符，快符前缀由脚本统一补齐分号 `;`。若有新增快符需在清洗规则中跟进。
