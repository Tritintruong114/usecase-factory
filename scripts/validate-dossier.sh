#!/usr/bin/env bash
# validate-dossier.sh — check a Use-Case Factory research dossier honors the heading contract.
# Usage: validate-dossier.sh <path-to-dossier.md>
# Default path: doc/ws-<slug>/_research/dossier.md
# Exit 0 = all checks pass. Exit 1 = at least one check failed.

set -euo pipefail

DOSSIER="${1:-}"

if [[ -z "$DOSSIER" ]]; then
  echo "usage: validate-dossier.sh <path-to-dossier.md>" >&2
  exit 2
fi

if [[ ! -f "$DOSSIER" ]]; then
  echo "FAIL  dossier not found: $DOSSIER" >&2
  exit 1
fi

fail=0
pass() { printf '  ok   %s\n' "$1"; }
miss() { printf '  MISS %s\n' "$1"; fail=1; }

echo "Validating dossier: $DOSSIER"

# Section 0..9 heading contract. Each must appear as a "## <n>." heading.
for n in 0 1 2 3 4 5 6 7 8 9; do
  if grep -Eq "^##[[:space:]]+${n}\." "$DOSSIER"; then
    pass "section ## ${n}."
  else
    miss "section ## ${n}. (required heading)"
  fi
done

# Named sections that must be present (case-insensitive).
check_phrase() {
  local label="$1" pattern="$2"
  if grep -Eiq "$pattern" "$DOSSIER"; then
    pass "$label"
  else
    miss "$label (expected text matching: $pattern)"
  fi
}

check_phrase "Decision Gate section"  "^##[[:space:]]+8\.[[:space:]]*Decision Gate"
check_phrase "Evidence Table section" "^##[[:space:]]+3\.[[:space:]]*Evidence Table"

# Decision Gate must carry an actual verdict, not be left blank.
if grep -Eiq "Proceed|Pivot|Narrow|Kill" "$DOSSIER"; then
  pass "Decision Gate verdict present (Proceed/Pivot/Narrow/Kill)"
else
  miss "Decision Gate verdict (Proceed/Pivot/Narrow/Kill)"
fi

# Evidence layering must be used somewhere.
if grep -Eiq "must-cite|assumption|infer" "$DOSSIER"; then
  pass "evidence layering present (must-cite / infer / assumption)"
else
  miss "evidence layering (must-cite / infer / assumption)"
fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "PASS  dossier honors the heading contract."
  exit 0
else
  echo "FAIL  dossier is missing required sections — see MISS lines above." >&2
  exit 1
fi
