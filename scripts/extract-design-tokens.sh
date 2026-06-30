#!/usr/bin/env bash
# extract-design-tokens.sh — BASIC token extractor for the Use-Case Factory.
#
# When a user contributes a design system (a self-contained / bundled HTML export),
# this pulls its CSS custom properties (`--cw-*`) out into a clean, paste-ready
# token file that `/usecase-factory:brief-to-html` drops straight into the
# `[data-theme="light"]` / `[data-theme="dark"]` blocks of `mockups.html`.
#
# It is deliberately dumb: grep the `--cw-NAME: value` pairs in source order.
# 1st occurrence of a name  -> light theme.
# 2nd occurrence (if any)    -> dark theme (theme-varying token).
# Tokens that appear once    -> theme-independent (kept in the light block only).
#
# Usage:
#   bash scripts/extract-design-tokens.sh [design-system-file] [output-file]
# Defaults:
#   in  = design-system/Openclaw_Design_System.html   (the bundled demo)
#   out = <dir-of-input>/tokens.css                   (written next to the source)
#
# Design systems normally live OUTSIDE this repo (each team points at their own,
# via the brief's `## Design system` path or $DESIGN_SYSTEM_ROOT). Point this at
# any path: `npm run extract:tokens /path/to/their-design-system.html`.
#
# This is the BASIC pass. A richer extractor (component shapes, multiple
# palettes, Figma/Storybook) can replace it later without changing the contract:
# the output is always a CSS file with light + dark `--cw-*` token blocks.

set -euo pipefail

IN="${1:-design-system/Openclaw_Design_System.html}"
OUT="${2:-$(dirname "$IN")/tokens.css}"

if [[ ! -f "$IN" ]]; then
  echo "ERROR: design system file not found: $IN" >&2
  echo "Point it at a contributed design-system export (HTML with --cw-* tokens)." >&2
  exit 1
fi

# Pull every "--cw-name: value" up to the terminating ; (excluding } and quotes),
# in source order, one pair per line as  name<TAB>value .
pairs="$(grep -oE '\-\-cw-[a-zA-Z0-9-]+:[^;}"]+' "$IN" \
  | sed -E 's/^(--cw-[a-zA-Z0-9-]+):[[:space:]]*/\1\t/')"

if [[ -z "$pairs" ]]; then
  echo "ERROR: no --cw-* tokens found in $IN" >&2
  echo "This basic extractor expects --cw-* CSS custom properties. If the design" >&2
  echo "system uses a different token convention, extend this script." >&2
  exit 1
fi

# Split into light (1st seen) and dark (2nd seen) using awk, preserving order.
echo "$pairs" | awk -F'\t' -v out="$OUT" -v src="$IN" '
{
  name=$1; val=$2;
  if (!(name in seen)) {
    seen[name]=1;
    lorder[++ln]=name; light[name]=val;
  } else if (seen[name]==1) {
    seen[name]=2;
    dorder[++dn]=name; dark[name]=val;
  }
}
END {
  print "/* Auto-extracted from " src " by scripts/extract-design-tokens.sh */";
  print "/* Do NOT edit by hand — re-run the script when the design system changes. */";
  print "";
  print "[data-theme=\"light\"] {";
  for (i=1;i<=ln;i++) printf "  %s: %s;\n", lorder[i], light[lorder[i]];
  print "}";
  print "";
  print "[data-theme=\"dark\"] {";
  for (i=1;i<=dn;i++) printf "  %s: %s;\n", dorder[i], dark[dorder[i]];
  print "}";
}' > "$OUT"

light_count="$(grep -c '^[[:space:]]*--cw-' "$OUT" || true)"
echo "OK: wrote $OUT"
echo "  source : $IN"
echo "  tokens : $light_count token lines (light + dark blocks)"
echo "  next   : /usecase-factory:brief-to-html pastes these into mockups.html's token blocks."
