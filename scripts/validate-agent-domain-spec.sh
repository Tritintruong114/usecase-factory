#!/usr/bin/env bash
# validate-agent-domain-spec.sh — check an Agent Domain Spec honors the heading contract.
# Usage: validate-agent-domain-spec.sh <path-to-Agent-Domain-Spec.md>
# Default path: doc/ws-<slug>/Agent-Domain-Spec.md
# Exit 0 = all checks pass. Exit 1 = at least one check failed.

set -euo pipefail

SPEC="${1:-}"

if [[ -z "$SPEC" ]]; then
  echo "usage: validate-agent-domain-spec.sh <path-to-Agent-Domain-Spec.md>" >&2
  exit 2
fi

if [[ ! -f "$SPEC" ]]; then
  echo "FAIL  agent domain spec not found: $SPEC" >&2
  exit 1
fi

fail=0
pass() { printf '  ok   %s\n' "$1"; }
miss() { printf '  MISS %s\n' "$1"; fail=1; }

echo "Validating agent domain spec: $SPEC"

# Section 0..19 heading contract. Each must appear as a "## <n>." heading.
for n in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do
  if grep -Eq "^##[[:space:]]+${n}\." "$SPEC"; then
    pass "section ## ${n}."
  else
    miss "section ## ${n}. (required heading)"
  fi
done

# Named sections that must be present (the load-bearing ones).
check_phrase() {
  local label="$1" pattern="$2"
  if grep -Eiq "$pattern" "$SPEC"; then
    pass "$label"
  else
    miss "$label (expected text matching: $pattern)"
  fi
}

check_phrase "Domain thesis section"        "^##[[:space:]]+1\.[[:space:]]*Domain thesis"
check_phrase "Role split section"           "^##[[:space:]]+2\.[[:space:]]*Human / Agent / Tool role split"
check_phrase "Approval policy section"      "^##[[:space:]]+11\.[[:space:]]*Approval policy"
check_phrase "Guardrails section"           "^##[[:space:]]+14\.[[:space:]]*Guardrails"
check_phrase "OpenClaw implementation map"  "^##[[:space:]]+17\.[[:space:]]*OpenClaw implementation map"

# Approval policy must classify actions into auto / approval / forbidden (anti over-automation).
if grep -Eiq "auto|cần duyệt|approval|cấm|forbidden" "$SPEC"; then
  pass "approval layering present (auto / cần duyệt / cấm)"
else
  miss "approval layering (auto / cần duyệt / cấm — every action must be classified)"
fi

# OpenClaw map must reference the primitive vocabulary.
if grep -Eiq "skills?|tools?/connectors?|connector|memory|session|cron|heartbeat|guardrail|workspace state" "$SPEC"; then
  pass "OpenClaw primitives referenced (skills/tools/memory/sessions/cron/approval/guardrails/workspace state)"
else
  miss "OpenClaw primitives (skills/tools/connectors/memory/sessions/cron/approval/guardrails/workspace state)"
fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "PASS  agent domain spec honors the heading contract."
  exit 0
else
  echo "FAIL  agent domain spec is missing required sections — see MISS lines above." >&2
  exit 1
fi
