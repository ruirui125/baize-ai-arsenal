# 06 · 苹果原生容器 `apple/container` 锁死 AI 沙盒 + 端侧轻薄本 4K / 免费百万上下文百宝箱

> **来源**：微信公众号 **「零号白泽」（`AgentBaiZe`）** 实测整理。  
> **涵盖仓库**：`apple/container`（★51.6k）、`apple/containerization`（★9.0k）、`Niko1221/Strata`（★44.7k）、`MiniMax-H3-Image` 6.4GB 量化生态及 Google AI Studio `Gemini 4 Hydrogen` 免费 API 配置。

---

## 一、告别吃掉 8G 内存的 Docker Desktop：苹果官方 `apple/container` 极速上手

苹果官方以 **`Apache-2.0`** 开源的纯 Swift 容器运行时，基于 macOS 原生 `Virtualization.framework` 实现 **「一个容器 = 一个独立硬件级微型 VM」**（`vminitd` 极简初始进程 + `vsock` 通信 + 原生 Rosetta 2 `amd64` 硬件加速，毫秒级冷启动）。

- **主仓库**：<https://github.com/apple/container>
- **底层 Swift 框架**：<https://github.com/apple/containerization>

### 3 步安装与启动（Apple Silicon Mac）
```bash
# 1. 下载最新官方 Release 安装包或通过 Homebrew 安装后启动后台服务
container system start

# 2. 毫秒级拉起一个独立微型 VM 容器（自动通过 Rosetta 2 兼容 linux/amd64）
container run --rm -it alpine:latest uname -a

# 3. 查看当前运行中的微型 VM 容器内存占用（按需分配，告别闲置吃 8GB 内存）
container ls
```

### 给 Claude Code / Codex 套上硬件级微型 VM 铁笼（同目录 `run-agent-in-apple-vm.sh`）
为什么不要直接裸跑高权限 Agent，也不要滥用半残的 `sandbox-exec`？
- **裸跑风险**：一句幻觉出来的 `rm -rf` 直接清空宿主机文稿；
- **半残系统沙盒痛点**：在宿主机直接开进程跑无头 Chrome 时容易误触 `login.keychain-db` 狂弹“找不到用于储存 Chrome 的钥匙串”警告框；
- **微型 VM 终极解法**：使用同目录 [`./run-agent-in-apple-vm.sh`](./run-agent-in-apple-vm.sh)，**只把当前单个项目文件夹挂载进微型 VM 的 `/workspace`**，宿主机其他目录、SSH 私钥与系统钥匙串在物理硬件层面 100% 不可见！

---

## 二、端侧算力四大神仙资源速查表

| 工具 / 模型 | 核心亮点 | 官方地址与实操口令 |
| :--- | :--- | :--- |
| **1. 初代 PS4 离线跑 9B（`Garlic LLM`）** | 2013 年老游戏机不刷 Linux 裸跑 `Qwen3.5-9B`，定制 GPU 内核 + 3/4-bit 量化飙出 **`39 tok/s`** | 技术复盘见公众号次条拆解 |
| **2. `Niko1221/Strata v0.2.14`（★44.7k）** | 自研原生 CUDA / AMD HIP 专家计算内核，`RTX 5070 Ti (16GB)` 跑 20K 长提示词提速 **`+47.7%`** | <https://github.com/Niko1221/Strata> |
| **3. `MiniMax-H3-Image` 轻薄本 4K 量化版** | 原版 `68.65GB` 33.1B 生图巨兽被压至 **`6.4GB`（`Q2_K`）/ `10.78GB`（`Q4`）**，6 步免 CFG 原生直出 `4096×4096` 4K + 16 图锁角色 | HuggingFace 搜索 `MiniMax-H3-Image-GGUF` 或 `MLX`；显存充裕选 Unsloth `18.8GB FP8` |
| **4. `Gemini 4 Hydrogen` 免费百万上下文 API** | Google AI Studio 每日约 **`1,500` 次免费调用** + **100 万上下文窗口**，跑日常 Agent 分诊与长文档摘要零成本 | 登录 <https://aistudio.google.com> 创建 API Key，模型名填 `gemini-4-hydrogen` |
| **5. 多 Agent 磁盘爆满救星 `morajabi/poo`** | 自动识别闲置 Git Worktree（动辄吃掉 50GB）与陈旧构建缓存，带安全规则与 MCP 接口 | <https://github.com/morajabi/poo> |
