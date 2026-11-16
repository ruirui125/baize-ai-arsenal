# 02 · 免改源码动态断点 MCP 与省 9 倍 Token 代码审查包

> 对应公众号「零号白泽」后台暗号：**`调试神器`**

---

## 一、`ChromeDevTools/chrome-devtools-mcp v1.13.0`（★ 57,270 · `Apache-2.0`）

- **官方仓库**：https://github.com/ChromeDevTools/chrome-devtools-mcp
- **核心痛点终结**：以前让 AI 查前端诡异状态，AI 只会在你的业务代码里塞满 `console.log('DEBUG 1')` 然后忘了删；升级 `v1.13.0` 后，AI 可直接通过 Chrome DevTools 协议**免改一行源码打运行时日志断点（Logpoints）、模拟接口 500 超时故障、以及用本地 JSON 覆盖线上接口返回**。

### 1. 一键 `mcp_config.json` 接入配置（兼容 Claude Code / Cursor / Antigravity）
```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": [
        "-y",
        "chrome-devtools-mcp@latest",
        "--browserUrl=http://127.0.0.1:9222"
      ]
    }
  }
}
```

### 2. 直接发给 AI 的 4 条高频排障口令
1. **免改源码打动态断点查变量**：
   > “不要修改任何本地 `.tsx` 源码加 `console.log`！请直接用 `chrome-devtools` 在结算按钮点击回调处挂载运行时日志断点，打印当前 `cartState` 和请求载荷，定位为什么金额变成了 `NaN`。”
2. **线上问题本地覆盖复现（Local Overrides）**：
   > “不要起本地 Mock 服，直接用 DevTools 网络覆盖把 `/api/v1/quota` 的响应临时替换为空数组 `[]`，截图验证空状态页面有没有白屏崩溃。”
3. **弱网与接口报错压力测试**：
   > “模拟 `Slow 3G` 并将支付轮询接口设为 `504 Gateway Timeout`，检查按钮防连点锁是否正常释放。”
4. **内存泄漏快照比对**：
   > “切换路由前后各抓一份 Heap Snapshot，找出没有解绑的全局事件监听器或残留闭包。”

---

## 二、阿里开源 `alibaba/open-code-review`（★ 52,478 · `Apache-2.0`）

- **官方仓库**：https://github.com/alibaba/open-code-review
- **省 9 倍 Token 的核心架构秘密**：
  - 纯大模型审 PR 的通病是“把几千行上下文全塞进昂贵模型，结果还在挑变量命名刺”。
  - `open-code-review` 在阿里内部跑了两年抓出数百万缺陷，秘诀是 **「确定性 AST/静态数据流管线先行筛出可疑切片 + 仅把高风险调用链喂给大模型做语义裁决」**，实测单次审查 Token 消耗仅为全量喂给 Claude Code 的 **`1/9`**！

---

## 三、Atlassian 工程师验证：「零大模型」确定性 PR 自动推进 10 条军规

> 为什么把大模型踢出定时轮询（Cron Loop），反而能休假一天自动推进 129 个 PR？

1. **轮询层 0 Token**：每 5 分钟跑一次纯 Python/Shell 定时脚本拉 GitHub/GitLab PR 状态，绝不用大模型做空转轮询；
2. **互斥状态桶（State Buckets）**：每个 PR 每次只归入唯一状态（`ci_failed` / `merge_conflict` / `changes_requested` / `awaiting_review_4h` / `ready_to_merge`），每次最多触发 1 个确定性动作；
3. **幂等账本防死循环**：本地 SQLite/JSON 记录 `(pr_id, head_sha, action)`，同一个 Commit 绝不重复拉起修复 Agent；
4. **强制产物会话溯源页脚（核心神技！）**：每个由 Agent 提的 PR 描述末尾自动附带 `Origin-Session-ID`，一旦 CI 变红，脚本直接把报错塞回**原本写这段代码、脑子里装着完整上下文的原会话**，而不是开个失忆的新 Agent 瞎猜；
5. **爆炸半径分级（`/blast-radius`）**：按改动文件自动标 `Low`（文档/单测/关闭开关后的新功能）、`Medium`（构建配置）、`High`（数据库迁移/鉴权/计费）；
6. **礼貌催审护栏**：仅在工作时间、PR 挂起超 4 小时无人看、排除机器人账号后温和提醒未审人，同一 PR 最多提醒 2 次（间隔至少 3 天）；
7. **审批后置熔断**：就算人工点了 `Approve`，合并前若最新一轮 CI 变红立即自动挂起拦截。
