# 零号白泽 · AI 开源神器与实战速查百宝箱 (`baize-ai-arsenal`)

> 微信公众号 **「零号白泽」（ID：`AgentBaiZe`）** 实测开源项目精选、中文避坑手册、万能 Prompt 模板与保命护栏脚本合集。  
> 所有收录仓库均经 GitHub 官方 API 核验开源协议，所有脚本与配置均去除私有路径、开箱即用。

---

## 📦 资源包目录导航（对应公众号后台回复暗号）

| 专题目录 | 公众号回复暗号 | 核心内容一览 |
| :--- | :---: | :--- |
| **[`01_代码大片与3D单网页/`](./01_代码大片与3D单网页/README.md)** | `代码大片` | `heygen-com/hyperframes`（★84.8k HTML 直出视频引擎）+ `ArtInMotion`（20 种纯代码手绘有声大片）+ **5 套几百 KB 单文件 Three.js 3D 世界万能中文 Prompt** + 独立美术盲审 Agent 提示词 + 单文件可运行 `starter_hyperframe_demo.html` |
| **[`02_免改源码断点MCP与审代码神器/`](./02_免改源码断点MCP与审代码神器/README.md)** | `调试神器` | `ChromeDevTools/chrome-devtools-mcp v1.13.0`（★57.2k 免改源码动态打日志断点 Logpoints / 故障注入 / 本地 Mock 覆盖）+ 阿里 `alibaba/open-code-review`（★52.4k 省 9 倍 Token 审代码）+ 零大模型确定性 PR 自动推进状态机 |
| **[`03_AI防删稿与密钥零明文保命锁/`](./03_AI防删稿与密钥零明文保命锁/README.md)** | `保命锁` | 针对“教授被删整年讲义”与 `#107757` 邮箱泄露事件：**`safe-rm-guard.sh` 防误删转回收站脚本 + Claude Code `PreToolUse` 护栏 Hook + API Key 零明文隔离 + `secretlint` 3 分钟自查模板** + 3 美元修 32 年老吉普 `xj-scanner` 档案 |
| **[`04_AI漫剧短剧防穿帮与分镜模板/`](./04_AI漫剧短剧防穿帮与分镜模板/README.md)** | `短剧分镜` | 千集 AI 短剧实战：**角色全身定妆防穿帮锁死表（含鞋靴/持物左右手/出画朝向）+ `Seedance 2.5` 保五官长镜头万能 Prompt 公式 + 前片终态快照无缝接续 SOP** |
| **[`05_指挥Agent最爱用的10条元指令/`](./05_指挥Agent最爱用的10条元指令/README.md)** | `十条指令` | 上万轮真实对话沉淀：**4 大阶段 10 句高阶 Agent 指挥元指令（第一性原理 / 质疑伪需求 / 二三阶推演 / 红队拆台 / Git 考古 / 返工转 Skill）+ `#L1~#L10` 一键粘贴 `CLAUDE.md` 配置块 + 黑金/米白双色高清手机锁屏速查壁纸** |
| **[`06_苹果原生容器与端侧神仙包/`](./06_苹果原生容器与端侧神仙包/README.md)** | `苹果容器` | 苹果官方 **`apple/container`（★51.6k 一容器一微型 VM 终结 Docker 8G 内存）+ `run-agent-in-apple-vm.sh` AI 硬件级沙盒脚本** + `MiniMax-H3` `6.4GB` 轻薄本原生 4K 量化指南 + `Gemini 4 Hydrogen` 每日 1500 次免费百万上下文 API |
| **[`07_AI独立游戏造富账本与角色动图四件套/`](./07_AI独立游戏造富账本与角色动图四件套/README.md)** | `角色动图` | **单张静态二次元插画自动变眨眼/口型/发丝摆动动态角色 4 款 MIT 开源工具链**（`mesh-avatar-studio` / `still2rig-psd`）+ **零手写代码手搓 3D 网页小游戏两步法万能 Prompt 模板** + 去 AI 廉价界面高星技能包 |
| **[`08_10大开源量化投研与每日股票复盘包/`](./08_10大开源量化投研与每日股票复盘包/README.md)** | `开源投研` | 外网 `1.90x` 超高收藏比：**合计 57.5 万星 10 大免费开源投研量化仓库**（`TradingAgents` ★122.8k 多 Agent 辩论 + 国人 `daily_stock_analysis` ★72.7k 零成本 GitHub Actions 每日复盘）+ **K 线转结构化 JSON `ai_candle_packet_demo.pine` 模板** |
| **姊妹完整案例专仓** | `Fable源码` | **[`ruirui125/claude-fable-code-video`](https://github.com/ruirui125/claude-fable-code-video)**：209 个纯代码直出 1080p 有声科普视频案例、分镜骨架与无丢帧渲染引擎 |

---

## ⚖️ 许可证说明

本仓库整理的原创脚本、配置模板与中文速查指南采用 **MIT License** 开源；引用的第三方开源项目（如 `hyperframes`、`chrome-devtools-mcp`、`open-code-review`、`xj-scanner` 等）分别遵循其原仓库许可证（`Apache-2.0` / `MIT` / `GPL-3.0`）。
