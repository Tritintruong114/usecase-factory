#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_MODEL="${CLAUDE_MODEL:-sonnet}"
CLAUDE_EFFORT="${CLAUDE_EFFORT:-high}"
CLAUDE_PERMISSION_MODE="${CLAUDE_PERMISSION_MODE:-bypassPermissions}"
DAILY_AGENT_IDEA_AUTO_PUSH="${DAILY_AGENT_IDEA_AUTO_PUSH:-1}"
OUT_DIR="${DAILY_AGENT_IDEA_DIR:-$ROOT_DIR/doc/daily-agent-app-ideas}"
LOG_DIR="${DAILY_AGENT_IDEA_LOG_DIR:-$ROOT_DIR/logs/cron}"
DATE_UTC="$(date -u +%F)"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$OUT_DIR" "$LOG_DIR"

LOCK_DIR="/tmp/usecase-factory-daily-agent-idea.lock"
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "Another daily agent-app idea run is already active." >&2
  exit 75
fi
trap 'rmdir "$LOCK_DIR"' EXIT

TMP_FILE="$(mktemp)"
LOG_FILE="$LOG_DIR/daily-agent-app-idea-$STAMP.log"

PROMPT=$(cat <<'PROMPT_EOF'
You are creating one concrete AI Agent app seed for ClawExperts.

This seed must start from a real market problem signal, not pure brainstorming.
First do a lightweight web research scan, then choose exactly ONE problem worth turning into an agent app idea.

Research scope:
- Search current public sources from global and/or Vietnam markets.
- Look for repeated operational pain, workaround-heavy workflows, manual coordination, missed follow-up, compliance/admin drag, creator/operator bottlenecks, or support/sales/finance/research tasks that already happen daily/weekly.
- Prefer sources such as forums, product reviews, app marketplace reviews, industry reports, job posts, LinkedIn/community posts, vendor docs, public case studies, and news about regulatory or workflow changes.
- Do not invent market stats. If a signal is weak, label it weak.
- Use at least 3 source URLs in the brief. If web access fails, say so explicitly and write a lower-confidence seed.

Write a single Markdown brief in Vietnamese. It must be specific enough to become input for `/usecase-factory:run`, but it is still a lightweight researched seed, not the full usecase-factory dossier.

Choose exactly ONE promising problem-to-agent-app direction for either:
- end-users: individual consumers, creators, freelancers, students, families, professionals, or
- power users: operators, founders, sales/admin/finance/support leads, analysts, agency owners, no-code builders.

Avoid generic "AI assistant" ideas. Prefer sharp daily/weekly workflows with a painful before-state, clear repeated trigger, messy context, multi-step tool use, follow-up, and a human checkpoint.

Think agent-flow first, user-flow second:
- Agent Flow is the product spine: trigger → context → plan → tools → decision points → human checkpoint → action → follow-up → memory/update → failure handling.
- User Flow is the control surface around that spine: review queue, approvals, overrides, history, settings, and exception handling.
- Do not describe the app as a conventional SaaS screen journey first. Start from what the agent does when work arrives, then describe how the human supervises it.

Required output:

# <short product-style name>

## Slug
<lowercase-kebab-case-slug>

## One-liner
<one sentence>

## Market problem signal
- Market / geography scanned:
- Source URLs:
- Repeated pain observed:
- Existing workaround:
- Why this looks agent-worthy:
- Confidence: High / Medium / Low

## Target user
- Segment:
- Power-user or end-user:
- Market / geography:
- Buyer:
- User:

## Pain hypothesis
- Current workflow:
- Specific pain:
- Frequency:
- Why now:
- Current substitutes:

## Agent fit
Score each axis Yes / Weak / No with one short reason:
- Judgment:
- Multi-step tool use:
- Memory / context:
- Messy conversation:
- Proactive follow-up:
- Human checkpoint:

## Agent flow
- Trigger:
- Context / memory:
- Plan:
- Tools / integrations:
- Decision points:
- Human checkpoint:
- Action:
- Follow-up:
- Memory / learning update:
- Failure handling:

## Control surface / user flow
- Primary surface:
- Review queue:
- Approval / override actions:
- History / audit trail:
- Settings:
- Exception handling:

## MVP scope
- v0 core loop:
- Must have:
- Explicitly not v0:
- Data needed:

## Risk questions for usecase-factory
- Buyer clarity:
- Pain intensity:
- Willingness to pay:
- Substitute strength:
- Feasibility:
- GTM wedge:

## Factory command
```bash
/usecase-factory:run <slug> <one-line idea + target market>
```

Constraints:
- No fabricated market size, revenue, pricing, traction, or statistics.
- If uncertain, mark as hypothesis.
- Make the idea narrow enough that a research dossier can be produced in one run.
- Make the command at the end usable by replacing <slug> with the actual slug.
PROMPT_EOF
)

{
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Generating daily agent-app idea"
  echo "root=$ROOT_DIR"
  echo "out_dir=$OUT_DIR"
  echo
} | tee "$LOG_FILE"

(
  cd "$ROOT_DIR"
  "$CLAUDE_BIN" \
    -p \
    --model "$CLAUDE_MODEL" \
    --effort "$CLAUDE_EFFORT" \
    --permission-mode "$CLAUDE_PERMISSION_MODE" \
    "$PROMPT"
) >"$TMP_FILE" 2>>"$LOG_FILE"

SLUG="$(
  awk '
    BEGIN { in_slug = 0 }
    /^## Slug[[:space:]]*$/ { in_slug = 1; next }
    /^## / { in_slug = 0 }
    in_slug && NF {
      gsub(/`/, "", $0)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0)
      print $0
      exit
    }
  ' "$TMP_FILE" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g'
)"

if [[ -z "$SLUG" ]]; then
  SLUG="agent-app-seed"
fi

OUT_FILE="$OUT_DIR/$DATE_UTC-$SLUG.md"
if [[ -e "$OUT_FILE" ]]; then
  OUT_FILE="$OUT_DIR/$DATE_UTC-$SLUG-$STAMP.md"
fi

mv "$TMP_FILE" "$OUT_FILE"

{
  echo "created=$OUT_FILE"
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Done"
} | tee -a "$LOG_FILE"

if [[ "$DAILY_AGENT_IDEA_AUTO_PUSH" == "1" ]]; then
  {
    echo
    echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Staging daily idea seed"
  } | tee -a "$LOG_FILE"

  (
    cd "$ROOT_DIR"
    git add -f "$OUT_FILE"

    if git diff --cached --quiet -- "$OUT_FILE"; then
      echo "No daily idea seed changes to commit"
      exit 0
    fi

    git commit -m "Add daily agent app idea seed for $DATE_UTC"
    git push origin HEAD
  ) 2>&1 | tee -a "$LOG_FILE"
fi

printf '%s\n' "$OUT_FILE"
