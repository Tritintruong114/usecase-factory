#!/usr/bin/env bash
# validate-agent-domain-spec.sh — check an Agent Domain Spec honors the heading contract, and that
# its required sibling 01-PRODUCT-MAP.md exists and is filled in (Decision Pack contract).
# Usage: validate-agent-domain-spec.sh <path-to-Agent-Domain-Spec.md>
# Default path: doc/ws-<slug>/Agent-Domain-Spec.md (01-PRODUCT-MAP.md is expected next to it)
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

# `01-PRODUCT-MAP.md` is a required sibling — agent-domain-spec writes it right after the spec
# itself (Decision Pack contract). Check it exists next to the spec and looks filled-in.
SPEC_DIR=$(dirname "$SPEC")
PRODUCT_MAP="$SPEC_DIR/01-PRODUCT-MAP.md"
if [[ ! -f "$PRODUCT_MAP" ]]; then
  miss "sibling 01-PRODUCT-MAP.md (expected at $PRODUCT_MAP — agent-domain-spec must write it alongside the spec)"
else
  pm_found=""
  for p in '<placeholder>' 'TODO' '<slug>' '<Tên hiển thị>' '<!-- guidance'; do
    if grep -Fq "$p" "$PRODUCT_MAP"; then
      pm_found+=" '${p}'"
    fi
  done
  if grep -Eq '<!--' "$PRODUCT_MAP"; then
    pm_found+=" '<!-- comment -->'"
  fi
  if [[ -n "$pm_found" ]]; then
    miss "01-PRODUCT-MAP.md still has placeholders:$pm_found"
  else
    pass "01-PRODUCT-MAP.md present + placeholder-free"
  fi
fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "PASS  agent domain spec honors the heading contract and 01-PRODUCT-MAP.md is present."
  exit 0
else
  echo "FAIL  agent domain spec is missing required sections/sibling — see MISS lines above." >&2
  exit 1
fi
