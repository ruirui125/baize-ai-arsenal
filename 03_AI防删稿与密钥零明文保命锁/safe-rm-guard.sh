#!/usr/bin/env bash
# safe-rm-guard.sh — PreToolUse safety guardrail for AI Coding Agents
# Blocks destructive wipe commands and prevents accidental email/secret leakage in curl headers.

set -euo pipefail

PAYLOAD="$(cat || true)"

python3 - "$PAYLOAD" <<'PY'
import json, re, sys

raw = sys.argv[1] if len(sys.argv) > 1 else ""
if not raw.strip():
    sys.exit(0)

try:
    data = json.loads(raw)
except Exception:
    sys.exit(0)

cmd = (data.get("tool_input") or {}).get("command") or ""

DANGEROUS_PATTERNS = [
    (r"\brm\s+-[a-zA-Z]*r[a-zA-Z]*f?\s+(/|~|\$HOME|\*|\.\.)(\s|$)", "Blocked catastrophic recursive rm target"),
    (r"\bgit\s+reset\s+--hard\b", "Blocked git reset --hard without manual human confirmation"),
    (r"\bgit\s+clean\s+-[a-zA-Z]*f", "Blocked git clean -f (untracked files would be permanently lost)"),
    (r"\bcurl\b.*(-A|--user-agent|-H)\s+['\"]?[^'\"]*[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}", "Blocked personal email leakage in outbound curl header (#107757 protection)"),
]

for pat, reason in DANGEROUS_PATTERNS:
    if re.search(pat, cmd, re.IGNORECASE):
        sys.stderr.write(f"[BAIZE-SAFETY-LOCK] {reason}: {cmd}\n")
        sys.exit(2)

sys.exit(0)
PY
