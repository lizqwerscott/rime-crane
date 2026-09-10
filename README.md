# 凇鹤拼音

![demo](./others/demo_crane.webp)

整合了雾凇拼音和小鹤双拼/音形方案的拼音输入法，简称「凇鹤拼音」。

- 雾凇：功能齐全，词库体验良好，长期更新修订。
- 凇鹤：去除了雾凇中的其他双拼方案，增加了对鹤形的支持，对接官方的小鹤音形。
- tiger-code 分支中现可使用虎码了。

[Rime 配置：雾凇拼音 | 长期维护的简体词库](https://github.com/iDvel/rime-ice) 是本方案全拼/双拼部分的基础方案和词库方案。

[小鹤双拼/音形](https://www.flypy.com/) 是以双手均衡性最优、强弱指分布最合理、跨排别扭组合频率最低为追求的双拼设计方案。其音形码以易学、单字重码率适度、整体效率持平四码类方案为设计目的。

[RIME | 中州韵输入法引擎](https://rime.im/) 是一个跨平台的输入法算法框架，这里是 Rime 的一个配置仓库。

用户需要[下载各平台对应的 Rime 发行版](https://rime.im/download/)，并将此配置应用到配置目录。

详细介绍：[Rime 配置：雾凇拼音](https://dvel.me/posts/rime-ice/)


## 基本套路

- 简体 | 全拼 | 小鹤双拼 | 小鹤音形
- [雾凇部分全部功能](https://github.com/iDvel/rime-ice#%E5%9F%BA%E6%9C%AC%E5%A5%97%E8%B7%AF)
- 凇鹤 - 小鹤音形主要功能：
    - 首选词（必选）
    - 通过分号次选字词上屏
    - 随心码调整特殊的码位
    - 分号键引导的快符（不支持成对符号光标移动到中间）
    - 一简词
    - 表外字，主要是粤语词汇
    - 全码词
    - `O` 符号引导（默认关闭）
    - 全码字（默认关闭，出简不全）
    - 用户码表
    - 简码提示，如熟悉可以关闭
    - 二重简码（默认关闭，10.9k 之后由一简词代替，可以根据情况开关）
    - 左 `Shift` 键用做输入法内的〔中/英〕切换，右 `Shift` 键保留系统（可通过 Karabiner 等工具实现输入法切换）
    - \` 万能码，作为任意码的补全
    - 通过 Lua 脚本实现了部分直通车功能
    - `Tab` 键编码清屏
    - `Enter` 键编码上屏
    - `Shift + 空格` 进行〔中/半角〕切换
    - `Ctrl + .` 进行〔中/英标点〕切换
    - `Ctrl + j` 进行〔简/繁〕切换

### 支持的快符

![](others/fast-symbols.png)

<!--
http://www.keyboard-layout-editor.com/#/
[{t:"#ff0000"},"Q\n：“","W\n？","E\n（","R\n）","T\n@","Y\n《","U\n》",{c:"#7d7d7d",t:"#000000"},"I",{c:"#cccccc",t:"#ff0000"},"O\n「」","P\n『』"],
[{x:0.25},"A\n！","S\n……","D\n、","F\n重复","G\n·","H\n《》","J\n“”","K\n（）","L\n〔〕",{c:"#ffabab"},":\n;"],
[{x:0.75,c:"#cccccc"},"Z\n“","X\n→","C\n”","V\n——","B\n_",{c:"#7d7d7d",t:"#000000"},"N","M"]
 -->

### 支持的直通车功能

|编码|Windows功能|macOS功能|
|-|-|-|
|oav|打开安装目录|打开安装目录|
|ocm|打开CMD|打开Terminal|
|odn|打开我的电脑|打开Finder|
|oec|打开Excel|打开Excel|
|ogj|打开用户配置目录|打开用户配置目录|
|oht|打开画图工具|-|
|ojs|打开计算器|打开计算器|
|owd|打开Word|打开Word|

|编码|功能|
|-|-|
|ojf|〔简/繁〕切换|

## 词库说明（更新至官方清风版 v1.26.9c）

本方案码表已全面切换至**官方小鹤音形清风便携版（WindInput）**官方挂接源，实现无损保序同步：
- **词汇扩充**：主码表首选字词扩充至 68,572 条（净增 1 万多条官方新词）。
- **官方调频同步**：同步最新调频字（如 `la` 拉、`lom` 骆）与最新快符键位规范（`;p` 单书名号 `〈〉`）。
- **词库模式对齐**：支持官方熟手模式、常规模式与初学模式，可在 `xhup.dict.yaml` 中按需开启/关闭。

```yaml
# 小鹤音形的主码表：文件 "xhup.dict.yaml"，其中按需加载的码表分别如下：
# --- 用户优先层 ---
- "xhup_dicts/xhup.user.top"          # 用户置顶码表：可以按需自行添加置顶词汇
- "xhup_dicts/xhup.user"              # 用户自用词库

# --- ① 熟手模式基础库（默认启用）---
- "xhup_dicts/xhup.primary"           # -0- 首选字词（68,572条，官方原生自然序）
- "xhup_dicts/xhup.secondary"         # 1.1 次选字词（分类词库：次选）
- "xhup_dicts/xhup.whimsicality"      # 1.1 随心码（分类词库：随心）
- "xhup_dicts/xhup.off-table"         # 2.2 表外字（分类词库：表外）
- "xhup_dicts/xhup.single.code"       # 2.1 一简词（一简次选，26个单字/词）
- "xhup_dicts/xhup.fast.symbols"      # 1.2 快符（分号引导符号）

# --- ② 常规模式扩展（已有简码的全码词，可按需开启）---
- "xhup_dicts/xhup.full.code.words"   # 2.3 全码词（约500条）

# --- ③ 初学模式扩展（全码字与生僻字，默认关闭，初学可开启）---
# - "xhup_dicts/xhup.full.code.chars"   # 全码字（已有简码，全码有其他字词，约1650条）
# - "xhup_dicts/xhup.rare.chars"        # 生僻字（约500条）

# --- 可选附加库 ---
# - "xhup_dicts/xhup.secondary.simple"  # 二简次选（66个单字，备选）
# - "xhup_dicts/xhup.symbols"           # 符号与部首字根
# - "xhup_dicts/xhup.emoji"             # 斜杠引导表情
# - "xhup_dicts/xhup.ok"                # ok引导两分/三分拆字拼字库（8.8万条）
```

> 注：维护人员或自动化 Agent 请参阅 [AGENTS.md](./AGENTS.md) 了解官方清风便携版码表逆向同步工作流与测试规范。
## 使用说明

建议备份原先配置，清空配置目录。

### 手动安装

将仓库所有文件复制粘贴进去就好了。

更新词库，手动覆盖 `xhup_dicts` `en_dcits` `opencc` `build` 四个文件夹。

### 东风破（Plum）安装（推荐）

如果你已安装 [东风破 (rime/plum)](https://github.com/rime/plum)，可使用以下命令一键安装并自动注册方案列表：

* **完整安装**（小鹤音形 + 小鹤双拼 + 雾凇词库）：
  ```bash
  bash rime-install kchen0x/rime-crane
  ```
* **仅小鹤音形纯码表**（轻量模式，不含全拼大词典）：
  ```bash
  bash rime-install kchen0x/rime-crane:others/recipes/xhup
  ```
* **仅更新词库**：
  ```bash
  bash rime-install kchen0x/rime-crane:others/recipes/all_dicts
  ```

### 软链接安装

克隆本仓库到本地，将本地目录创建软链接到 Rime 的配置目录：

```bash
rm -rf ~/Library/Rime && ln -sif `pwd` ~/Library/Rime
```

更新时只需在仓库目录下执行 `git pull`。

## 进阶配置：小鹤音形 5 码起联想英文单词

小鹤音形原生为**四码定长、顶字上屏**。若你在日常使用中有高频输入英文单词的需求，习惯手动按空格上屏，且不想频繁按 Shift 切换中英文或使用引导前缀：

本项目提供了配套的 Lua 滤镜组件 `lua/xhup/english_len_filter.lua`，可实现**超过 4 码后自动由雾凇英文词库（`melt_eng`）接管并联想英文长词**，同时保证 4 码以内中文候选绝对纯净：

* **1~4 码**：严格屏蔽外部英文候选，中文候选 100% 纯净（例如输入 `like` 仅出中文词「立刻」，输入 `appl` 空码时不提前跳出英文）；
* **≥ 5 码**：音形中文码表自动断码，由雾凇英文词库瞬间接管，流畅联想补全长单词（例如输入 `apple`、`computer`、`application`）；
* **1~4 字母短英文**：日常输入诸如 `git`、`app`、`cpu` 等短词时，打完直接按回车（`Enter`）即可将原始字母直接上屏。

### 开启方式

在你的 Rime 用户配置目录下新建或修改 `xhup.custom.yaml`（模板参见 `xhup.custom.template.yaml`），写入以下内容：

```yaml
patch:
  # 1. 放开最大编码长度，关闭自动顶屏与空码清屏
  speller/max_code_length: 32
  speller/auto_select: false
  speller/auto_clear: none

  # 2. 挂载雾凇英文词库依赖与翻译器
  schema/dependencies/+:
    - melt_eng
  engine/translators/+:
    - table_translator@melt_eng

  # 3. 启用长度过滤滤镜（输入 1~4 码不展示英文，5 码起放行）
  engine/filters/@before 3: lua_filter@*xhup/english_len_filter

  # 4. 配置英文词库联想补全与权重压制
  melt_eng:
    dictionary: melt_eng
    enable_completion: true
    enable_sentence: false
    enable_user_dict: false
    initial_quality: -2
```

保存后，在系统状态栏重新部署（Deploy）Rime 即可生效。
