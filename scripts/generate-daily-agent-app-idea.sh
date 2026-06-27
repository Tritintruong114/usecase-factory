#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_MODEL="${CLAUDE_MODEL:-sonnet}"
CLAUDE_EFFORT="${CLAUDE_EFFORT:-high}"
CLAUDE_PERMISSION_MODE="${CLAUDE_PERMISSION_MODE:-bypassPermissions}"
DAILY_AGENT_IDEA_AUTO_PUSH="${DAILY_AGENT_IDEA_AUTO_PUSH:-1}"
DAILY_AGENT_IDEA_BRANCH="${DAILY_AGENT_IDEA_BRANCH:-main}"
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

Output language rule:
- Write the Markdown brief in Vietnamese 100%.
- Section headings, field labels, rationale, risk questions, and notes must be Vietnamese.
- Allowed non-Vietnamese: URLs, product/company names, technical proper nouns, API names, and the shell command in the final code block.
- Do not use English section headings such as "Target user", "Pain hypothesis", "Agent flow", "Control surface", "MVP scope", or "Factory command".

This seed must start from a real market problem signal, not pure brainstorming.
First do a lightweight web research scan, then choose exactly ONE problem worth turning into an agent app idea.

Phạm vi quét vấn đề:
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

Format bắt buộc:

# <short product-style name>

## Slug
<lowercase-kebab-case-slug>

## Một câu mô tả
<một câu>

## Tín hiệu vấn đề thị trường
- Thị trường / địa lý đã quét:
- Nguồn tham khảo:
- Nỗi đau lặp lại quan sát được:
- Cách làm thay thế hiện tại:
- Vì sao vấn đề này hợp với agent:
- Độ tin cậy: Cao / Trung bình / Thấp

## Người dùng mục tiêu
- Phân khúc:
- Nhóm người dùng:
- Thị trường / địa lý:
- Người mua:
- Người dùng trực tiếp:

## Giả thuyết nỗi đau
- Quy trình hiện tại:
- Nỗi đau cụ thể:
- Tần suất:
- Vì sao là lúc này:
- Cách thay thế hiện tại:

## Độ phù hợp với agent
Chấm từng trục Có / Yếu / Không, kèm một lý do ngắn:
- Cần phán đoán:
- Cần dùng nhiều công cụ / nhiều bước:
- Cần trí nhớ / ngữ cảnh:
- Có hội thoại hoặc dữ liệu lộn xộn:
- Cần chủ động theo dõi:
- Cần điểm duyệt của con người:

## Luồng agent
- Kích hoạt:
- Ngữ cảnh / trí nhớ:
- Kế hoạch:
- Công cụ / tích hợp:
- Điểm ra quyết định:
- Điểm duyệt của con người:
- Hành động:
- Theo dõi tiếp:
- Cập nhật trí nhớ / học từ phản hồi:
- Xử lý lỗi:

## Bề mặt điều khiển / luồng người dùng
- Bề mặt chính:
- Hàng đợi duyệt:
- Hành động duyệt / can thiệp:
- Lịch sử / audit trail:
- Cài đặt:
- Xử lý ngoại lệ:

## Phạm vi MVP
- Vòng lặp lõi v0:
- Bắt buộc có:
- Chưa làm ở v0:
- Dữ liệu cần có:

## Câu hỏi rủi ro cho usecase-factory
- Độ rõ của người mua:
- Cường độ nỗi đau:
- Sẵn sàng chi trả:
- Sức mạnh của cách thay thế:
- Tính khả thi:
- Wedge GTM:

## Lệnh chạy factory
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

FORBIDDEN_ENGLISH_HEADINGS='^## (One-liner|Market problem signal|Target user|Pain hypothesis|Agent fit|Agent flow|Control surface|Control surface / user flow|MVP scope|Risk questions|Risk questions for usecase-factory|Factory command)[[:space:]]*$'

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

if grep -Eq "$FORBIDDEN_ENGLISH_HEADINGS" "$TMP_FILE"; then
  {
    echo "Output rejected: found old English section headings."
    echo "Please rerun after adjusting the generator prompt or model output."
  } | tee -a "$LOG_FILE" >&2
  rm -f "$TMP_FILE"
  exit 65
fi

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

    # Commit the seed directly onto the target branch (default: main) and push
    # there. Seeds live under the gitignored doc/, so switching branches never
    # disturbs the generated file in the working tree. We fast-forward to the
    # remote first so the commit lands on top of the latest main.
    git fetch origin "$DAILY_AGENT_IDEA_BRANCH"
    git checkout "$DAILY_AGENT_IDEA_BRANCH"
    git merge --ff-only "origin/$DAILY_AGENT_IDEA_BRANCH" || true

    git add -f "$OUT_FILE"

    if git diff --cached --quiet -- "$OUT_FILE"; then
      echo "No daily idea seed changes to commit"
      exit 0
    fi

    git commit -m "Add daily agent app idea seed for $DATE_UTC"
    git push origin "$DAILY_AGENT_IDEA_BRANCH"
  ) 2>&1 | tee -a "$LOG_FILE"
fi

printf '%s\n' "$OUT_FILE"
