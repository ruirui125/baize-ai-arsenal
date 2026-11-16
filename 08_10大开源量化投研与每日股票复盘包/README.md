# 08 · 外网超高收藏（`1.90x`）10 大开源投研量化仓库 + K 线转 JSON 喂给大模型工程指南

> **合规与免责声明**：本目录所有工具、开源仓库索引与 Pine Script 脚本**仅供软件工程、多智能体（Multi-Agent）辩论架构与金融数据可视化技术研究学习，绝不构成任何证券、期货或加密资产投资建议**。市场有风险，任何实盘决策请自行独立判断并承担风险。

---

## 一、为什么不能直接把 K 线截图丢给大模型看？（核心工程洞察）

视觉大模型直接看 K 线截图有三大硬伤：坐标轴价格容易读偏、均线交叉与成交量背离全是模糊像素、Token 消耗高且每次回答飘忽不定。

外网斩获 **`2,852` 次收藏（收藏/点赞比高达 `1.90x`）** 的标准解法只有一步：
> **在图表端用轻量脚本把每一根已收盘 K 线的客观数值（趋势状态、RSI/ATR 动量、成交量倍数、前高前低关键位）打包成干净的 JSON 数据包，再交给大模型做结构化风控推演与反例挑刺！**

同目录已附带教学版可运行模板：[`./ai_candle_packet_demo.pine`](./ai_candle_packet_demo.pine)（打开 TradingView 底部 `Pine 编辑器` 粘贴即可在图表右上角实时生成结构化 JSON 摘要面板）。

---

## 二、合计超 `57.5 万` GitHub Star · 10 大免费开源投研与量化重器导航

| 序号 | 开源项目（实核 Star 与协议） | 角色定位与核心看点 |
| :---: | :--- | :--- |
| **01** | **[`TauricResearch/TradingAgents`](https://github.com/TauricResearch/TradingAgents)**<br>（**★122,806** · `Apache-2.0`） | **多智能体模拟基金架构标杆**：把基本面分析师、情绪分析师、技术面研究员、多空辩论员与风控官拆成独立 Agent 互相质询，拒绝单模型一言堂幻觉 |
| **02** | **[`openbq-org/OpenBB`](https://github.com/openbq-org/OpenBB)**<br>（**★75,461**） | **开源版彭博数据底座**：统一接入财报、宏观经济、期权链与另类数据，原生支持挂载给 AI Agent 查询 |
| **03** | **[`ZhuLinsen/daily_stock_analysis`](https://github.com/ZhuLinsen/daily_stock_analysis)**<br>（**★72,715** · `MIT`） | **中文社区爆款零成本每日复盘看板**：支持 A 股 / 港股 / 美股多源行情 + 实时资讯聚合，直接白嫖 **GitHub Actions 每天定时免费运行**并推送到微信/飞书/邮箱 |
| **04** | **[`freqtrade/freqtrade`](https://github.com/freqtrade/freqtrade)**<br>（**★56,945** · `GPL-3.0`） | Python 开源策略回测、参数寻优（Hyperopt）与模拟盘验证框架，内置严格防未来函数（Lookahead Bias）检查 |
| **05** | **[`ccxt/ccxt`](https://github.com/ccxt/ccxt)**<br>（**★44,893** · `MIT`） | 跨平台统一历史行情拉取与订单簿标准化接口库（支持 Python / TypeScript / Go） |
| **06** | **[`microsoft/qlib`](https://github.com/microsoft/qlib)**<br>（微软开源 AI 量化投研平台） | 面向机器学习与因子挖掘的完整实验流水线，含标准回测基准数据集 |
| **07** | **[`microsoft/RD-Agent`](https://github.com/microsoft/RD-Agent)**<br>（微软开源自动化因子研发 Agent） | 让 Agent 自动完成「提出假设 → 编写因子代码 → 跑回测验证 → 迭代修正」的科研闭环 |
| **08** | **[`virattt/ai-hedge-fund`](https://github.com/virattt/ai-hedge-fund)** | 教学级多大师风格（价值投资 / 宏观对冲 / 安全边际）多视角碰撞估值实验仓 |
| **09** | **[`QuantConnect/Lean`](https://github.com/QuantConnect/Lean)** | 机构级事件驱动开源算法交易与多资产回测引擎（C# / Python） |
| **10** | **[`ranaroussi/yfinance`](https://github.com/ranaroussi/yfinance)** | 5 行 Python 代码免密钥拉取全球股票历史日线、分红拆股与资产负债表 |

---

## 三、给大模型做投研复盘时的「防自嗨红队提示词」（配合 JSON 数据包使用）

```text
以下是某标的刚收盘的结构化客观指标 JSON 数据包：
<在此粘贴 JSON>

请严格按「风控审计员」视角执行三步分析（仅作技术逻辑推演，不作买卖指令）：
1. 多空客观证据对账：列出当前数据中支持趋势延续的信号，以及出现量价背离或过度拥挤的信号；
2. 最强反对者证伪（Red-Team）：假设当前最顺眼的方向是一个诱多/诱空陷阱，请指出哪一个关键价位一旦跌破/突破，该逻辑立即证伪失效？
3. 观望条件（WAIT 优先）：如果当前盈亏比不清晰或处于震荡噪音区，请直接输出 WAIT 并说明需要等待哪个确认信号。
```
