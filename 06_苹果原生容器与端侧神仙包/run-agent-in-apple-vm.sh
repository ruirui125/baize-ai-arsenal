#!/usr/bin/env bash
# 使用苹果官方 apple/container 将 AI Coding Agent 隔离在独立微型 VM 中运行
# 只挂载当前工作目录到 /workspace，宿主机其他目录、私钥与系统钥匙串 100% 物理不可见

set -euo pipefail

PROJECT_DIR="${1:-$(pwd)}"
IMAGE_NAME="${AGENT_VM_IMAGE:-node:22-bookworm}"

if ! command -v container >/dev/null 2>&1; then
  echo "[提示] 未检测到苹果 container 命令，请先前往 https://github.com/apple/container 安装并执行 container system start"
  exit 1
fi

echo "[安全沙盒] 正在独立微型 VM 中挂载项目目录: ${PROJECT_DIR} -> /workspace"
exec container run --rm -it \
  --cpus 4 \
  --memory 4g \
  --volume "${PROJECT_DIR}:/workspace" \
  --workdir /workspace \
  "${IMAGE_NAME}" \
  bash
