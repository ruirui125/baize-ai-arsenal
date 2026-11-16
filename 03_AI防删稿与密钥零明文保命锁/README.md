# 03 · AI 防误删手稿、防邮箱泄露与密钥零明文「保命五道锁」

> 对应公众号「零号白泽」后台暗号：**`保命锁`**  
> 背景：芝加哥大学法学院教授吃顿午饭被 AI 删光整年宪法讲义（215 万阅读）+ Claude Code `#107757` 把用户私人邮箱塞进 `curl User-Agent` 全网广播招来钓鱼邮件。把 AI 放进电脑干活前，先花 3 分钟装好这套物理护栏！

---

## 第一道锁：高危删除自动转回收站（`safe-rm-guard.sh`）

不要把命运寄托在提示词里写“请千万别删错文件”（大模型一上头重构目录就会顺手 `rm -rf`）。同目录提供 [`safe-rm-guard.sh`](./safe-rm-guard.sh)，作为 Agent 钩子拦截脚本：

- 遇到 `rm -rf /`、`rm -rf ~`、`rm -rf *`、`git reset --hard`、`git clean -fdx` 直接硬阻断（返回非零退出码并提示人工确认）；
- 常规删除建议改走系统废纸篓（macOS `trash` / Linux `gio trash`），删错了随时 1 秒拖回来。

---

## 第二道锁：Claude Code `PreToolUse` 命令与隐私防火墙模板

将下方配置合并进你的 `~/.claude/settings.json`（或项目 `.claude/settings.json`），同时防住 **「误删文件」** 与 **「`curl` 顺手泄露私人邮箱/Token」**：

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash ./safe-rm-guard.sh"
          }
        ]
      }
    ]
  }
}
```

---

## 第三道锁：API Key 零明文落盘（告别 `.zshrc` 与 `.env` 裸奔）

针对近期多起开发者扩展投毒窃取明文 `.env` 事件：
1. **代码仓根目录严禁存放真实明文 `.env`**：本地联调通过密码管理器 CLI 按需注入进程内存（如 `op run --env-file=.env.tpl -- npm run dev` 或 macOS `security find-generic-password`），进程退出密钥即刻销毁，磁盘上 0 明文残留；
2. **开源或提交前跑一遍 3 秒 `secretlint` 死门禁**：
   ```bash
   npx @secretlint/quick-start "**/*"
   ```

---

## 第四道锁：文稿与代码双轨自动时光机

- 代码目录开异地私有 Git 自动快照，**非代码的重要文档目录（论文、合同、讲义、设计原稿）必须放在开启了「30 天历史版本恢复」的云盘同步目录或 macOS Time Machine 保护区内**——教授丢失的整年宪法讲义最后正是靠云盘历史版本救回来的。

---

## 附：硬核开源彩蛋档案

- **`MZULALI/xj-scanner`（3 美元单片机 + 双 AI 修好 32 年老吉普 ECU）**：https://github.com/MZULALI/xj-scanner  
  车主用一块 \$3 的 Arduino Nano 配合 Claude Code 逆向破译 1994 款切诺基 7800 波特反相 `SCI` 远古串口协议，揪出芯片里的测功机削油表，再用 Codex 将补丁硬刷进不可常规擦写的 1993 批次 EEPROM 一次过尾气年检。
- **`microsoft/TokenEconomizer`（`Apache-2.0`）**：通过自动裁剪闲置工具定义与死循环熔断，在 SWE-Bench 实测节省 `18.4% ~ 30.9%` Agent Token 开销。
