#!/usr/bin/env bash
# coverage-check.sh — check the 4 Use-Case Factory output docs exist and contain no leftover placeholders.
# Usage: coverage-check.sh <ws-dir> <slug>
#   <ws-dir>  e.g. doc/ws-sale-ai-agent
#   <slug>    e.g. sale-ai-agent   (used to resolve MR-<slug>- and Target-User-<slug>)
# Exit 0 = all four exist and are placeholder-free. Exit 1 = missing file or leftover placeholder.

set -euo pipefail

WS_DIR="${1:-}"
SLUG="${2:-}"

if [[ -z "$WS_DIR" || -z "$SLUG" ]]; then
  echo "usage: coverage-check.sh <ws-dir> <slug>" >&2
  echo "  e.g. coverage-check.sh doc/ws-sale-ai-agent sale-ai-agent" >&2
  exit 2
fi

fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  BAD  %s\n' "$1"; fail=1; }

# Resolve the two variable-named docs by glob first (preferred name is
# MR-<slug>-Problem-Solution.md / Target-User-<slug>.md, but real workspaces
# often use a title-cased product or persona name instead — accept either).
resolve_one() {
  # $1 = glob, $2 = preferred exact path. Echo the first match, else the preferred path.
  local match
  match=$(ls $1 2>/dev/null | head -n1 || true)
  if [[ -n "$match" ]]; then echo "$match"; else echo "$2"; fi
}

MR_FILE=$(resolve_one "$WS_DIR/MR-*-Problem-Solution.md" "$WS_DIR/MR-${SLUG}-Problem-Solution.md")
TU_FILE=$(resolve_one "$WS_DIR/Target-User-*.md"          "$WS_DIR/Target-User-${SLUG}.md")

# The four required output docs (dossier is checked by validate-dossier.sh).
FILES=(
  "$WS_DIR/Boi-Canh-Va-Van-De.md"
  "$MR_FILE"
  "$TU_FILE"
  "$WS_DIR/MVP-Coreloop.md"
)

# Common leftover placeholders that mean the doc wasn't actually filled.
# Note: real source links like [label](http...) are fine; we only flag the literal markers below.
PLACEHOLDER_PATTERNS=(
  '<placeholder>'
  'TODO'
  '<YYYY-MM-DD>'
  '<slug>'
  '<Tên use-case>'
  '<!-- guidance'
)

echo "Coverage check: $WS_DIR (slug: $SLUG)"

for f in "${FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    bad "missing output file: $f"
    continue
  fi

  found=""
  for p in "${PLACEHOLDER_PATTERNS[@]}"; do
    if grep -Fq "$p" "$f"; then
      found+=" '${p}'"
    fi
  done
  # Catch any leftover guidance comment blocks too.
  if grep -Eq '<!--' "$f"; then
    found+=" '<!-- comment -->'"
  fi

  if [[ -n "$found" ]]; then
    bad "$f still has placeholders:$found"
  else
    pass "$f present + placeholder-free"
  fi
done

echo
if [[ "$fail" -eq 0 ]]; then
  echo "PASS  all 4 output docs exist and are placeholder-free."
  exit 0
else
  echo "FAIL  coverage incomplete — see BAD lines above." >&2
  exit 1
fi
