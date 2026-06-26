#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SLUG="${1:-${USECASE_FACTORY_SLUG:-}}"
IDEA="${USECASE_FACTORY_IDEA:-}"

if [[ $# -gt 1 ]]; then
  shift
  IDEA="$*"
fi

if [[ -z "$SLUG" ]]; then
  echo "Usage: $0 <slug> [idea + target market]" >&2
  echo "Or set USECASE_FACTORY_SLUG and optionally USECASE_FACTORY_IDEA." >&2
  exit 64
fi

WORKSPACE_DIR="$ROOT_DIR/doc/ws-$SLUG"
BRIEF_FILE="$WORKSPACE_DIR/brief.md"

if [[ -z "$IDEA" && ! -f "$BRIEF_FILE" ]]; then
  echo "Missing idea and no brief found at $BRIEF_FILE" >&2
  echo "Cron runs are non-interactive, so provide an idea or create brief.md first." >&2
  exit 64
fi

CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_MODEL="${CLAUDE_MODEL:-sonnet}"
CLAUDE_EFFORT="${CLAUDE_EFFORT:-high}"
CLAUDE_PERMISSION_MODE="${CLAUDE_PERMISSION_MODE:-bypassPermissions}"
CLAUDE_MAX_BUDGET_USD="${CLAUDE_MAX_BUDGET_USD:-}"
USECASE_FACTORY_AUTO_PUSH="${USECASE_FACTORY_AUTO_PUSH:-1}"

LOG_DIR="${USECASE_FACTORY_LOG_DIR:-$ROOT_DIR/logs/cron}"
mkdir -p "$LOG_DIR" "$WORKSPACE_DIR"

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_FILE="$LOG_DIR/${SLUG}-${STAMP}.log"
LOCK_DIR="/tmp/usecase-factory-${SLUG}.lock"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "Another usecase-factory run is already active for slug: $SLUG" >&2
  exit 75
fi
trap 'rmdir "$LOCK_DIR"' EXIT

PROMPT="/usecase-factory:run $SLUG"
if [[ -n "$IDEA" ]]; then
  PROMPT="$PROMPT $IDEA"
fi

{
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Starting usecase-factory run"
  echo "root=$ROOT_DIR"
  echo "slug=$SLUG"
  echo "log=$LOG_FILE"
  echo
} | tee "$LOG_FILE"

CLAUDE_ARGS=(
  -p
  --plugin-dir "$ROOT_DIR"
  --model "$CLAUDE_MODEL"
  --effort "$CLAUDE_EFFORT"
  --permission-mode "$CLAUDE_PERMISSION_MODE"
)

if [[ -n "$CLAUDE_MAX_BUDGET_USD" ]]; then
  CLAUDE_ARGS+=(--max-budget-usd "$CLAUDE_MAX_BUDGET_USD")
fi

(
  cd "$ROOT_DIR"
  "$CLAUDE_BIN" "${CLAUDE_ARGS[@]}" "$PROMPT"
) 2>&1 | tee -a "$LOG_FILE"

status=${PIPESTATUS[0]}
{
  echo
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Finished with status $status"
} | tee -a "$LOG_FILE"

if [[ "$status" -eq 0 && "$USECASE_FACTORY_AUTO_PUSH" == "1" ]]; then
  {
    echo
    echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Staging generated research output"
  } | tee -a "$LOG_FILE"

  (
    cd "$ROOT_DIR"
    git add -f "$WORKSPACE_DIR"

    if git diff --cached --quiet -- "$WORKSPACE_DIR"; then
      echo "No generated research changes to commit for $SLUG"
      exit 0
    fi

    git commit -m "Add usecase factory output for $SLUG"
    git push origin HEAD
  ) 2>&1 | tee -a "$LOG_FILE"

  push_status=${PIPESTATUS[0]}
  if [[ "$push_status" -ne 0 ]]; then
    echo "Auto-push failed with status $push_status" | tee -a "$LOG_FILE" >&2
    exit "$push_status"
  fi
fi

exit "$status"
