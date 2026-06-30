---
name: mockup-to-html
description: Render an approved ASCII wireframe (mockups.md) into an interactive HTML prototype — a fixed engine (mockups.html) plus a content file (mockups.data.js) — so the wireframe can be eye-reviewed at real fidelity (clickable tabs, per-screen state switcher, light/dark) before any FE code. Generic — the visual skin (colors, radius, type, component shapes) comes from a style reference you point at, not baked in. Use after /usecase-factory:design-a-screen lands the ASCII map and the user wants to "render the wireframe to HTML", "make the mockup interactive", "turn mockups.md into a clickable prototype", or "preview the wireframe with the real design system". Triggers on "render wireframe", "mockup to html", "interactive wireframe", "clickable mockup".
disable-model-invocation: true
---

# Mockup to HTML

Second render of the Phase-1 wireframe. `/usecase-factory:design-a-screen` produces the ASCII MAP (`mockups.md`); this turns it into an interactive prototype for richer eye-review. Still a wireframe, NOT FE code: static markup, no real data, lives in `doc/`. The ASCII stays the source of truth and the alignment GATE; this is the prettier viewer.

## Two-file output (engine ↔ content split)

| File | Role | Per use-case |
|---|---|---|
| `mockups.html` | **Engine + style** — app shell, tab/state switch, light/dark, all CSS primitives. Copied verbatim from the template; the ONLY edit is the design-token block. | builds the DOM from `window.WIREFRAME` |
| `mockups.data.js` | **Content** — `window.WIREFRAME = {meta, tabs, screens}`. One text file holding every screen as an HTML string. | this is what you author each time |

> **The two files are ONE inseparable pair.** `mockups.html` loads the data via `<script src="mockups.data.js">` (relative path), so both MUST sit in the same folder — open/email/zip/upload them together. The `.html` alone renders blank. "Self-contained" means self-contained **as a pair**, not as one file.

Loaded via `<script src="mockups.data.js">` (not `fetch`), so the prototype opens on **double-click** (`file://`, no server, no CORS). Hard line: no real data wiring, no framework — Phase-2 FE stub-data is a separate, later step.

## Inputs

1. **ASCII source** — `doc/ws-<name>/mockups.md` (or nearest). Every tab + state + modal + empty/done in it must appear in the output. If missing/incomplete, STOP and send the user to `/usecase-factory:design-a-screen`.
2. **Style reference** — where the look comes from. Resolve in order:
   - An explicit reference the user names (folder / file / URL / "use ws-X's").
   - `$DESIGN_SYSTEM_ROOT` if that env var is set, else the repo default **`new-design/`** (Claude Design handoff). Tokens in `<root>/src/index.css` (`--cw-*`, light+dark); component shapes in `<root>/src/ui.jsx`.
   - Neither exists → keep the template's neutral default tokens and say so.

## Workflow

### 1. Read both inputs
Read `mockups.md` end to end — list every screen group (tab), every state per group, every modal/empty/done. This is the coverage contract; nothing may be dropped. Read the style reference; extract its **design tokens** (canvas/card/border/ink/accent, radius, font, shadow, light+dark) and **component shapes** (button variants, pill/badge, chip, switch, card). You map the reference onto the engine's class names — restyle, don't invent.

### 2. Write `mockups.html` from the engine template
Copy [assets/template.html](assets/template.html) verbatim to `doc/ws-<name>/mockups.html`. Do NOT touch the engine script or rename classes. The **only** edit: replace the neutral values in the `[data-theme="light"]` / `[data-theme="dark"]` token blocks with the reference's tokens (for new-design: copy the `--cw-*` values onto the matching names). Keep token NAMES stable. If the reference has no dark theme, keep the fallback.

### 3. Write `mockups.data.js` from the ASCII
Model on [assets/example.data.js](assets/example.data.js). Fill:
- `meta` — title, subtitle, `source` (path to mockups.md), `styleRef`. Set `runSwitch:true` only if the wireframe has a live/rest concept; else omit.
- `tabs` — one `{id,label}` per screen group (order = tab order; first is active).
- `screens[tabId]` — `states:[{id,label}]` (the switcher) + `html:{stateId: \`...\`}` for each state. Build each screen's HTML from the ASCII regions using the engine primitives (`.card`, `.btn`, `.pill`, `.kpi`, `.conv`, `.modalbox`, `.togglebox`, `table`, …). Render modals/drawers/empty/done each as their own state, as the existing wireframes do.

Use template literals for multi-line HTML. Copy = the ASCII's labels (mirror FE i18n keys); do NOT write new product copy.

### 4. Persist + self-check
Both files sit in `doc/ws-<name>/` (same folder — the pair is inseparable). Verify coverage: every tab/state/modal in `mockups.md` has a matching entry in `tabs` / `states` / `html`. Confirm the data file parses (no unescaped backticks inside template strings). Tell the user which style reference was used (and if you fell back to neutral defaults). Suggest they double-click `mockups.html` to review.

### 5. Emit the handoff index (`HANDOFF.md`)
This is the pipeline's terminal step — write `doc/ws-<name>/HANDOFF.md` from [assets/HANDOFF.template.md](assets/HANDOFF.template.md) so the package is self-explaining. Fill: the Decision-Gate verdict + top risk (from `_research/dossier.md`), the artifact list (treat `mockups.{html,data.js}` as ONE pair), the scope boundaries, the next step per receiver, and which style reference was used. If a prior `HANDOFF.md` exists, update it rather than duplicating. This turns a folder of files into a handoff a stakeholder / web-app / Phase-2 dev can pick up without asking.

## Anti-patterns
- Don't hand off `mockups.html` without `mockups.data.js` — they are one pair; the `.html` alone renders blank. Always ship/zip/upload both, in the same folder.
- Don't bake a design system into the skill — the skin always comes from the reference; the skill is generic.
- Don't inline screens into `mockups.html` or rewrite its engine — content lives only in `mockups.data.js`; restyle via the token block.
- Don't use `.json` + `fetch` for content — it breaks `file://` double-click. Content is a `.js` global.
- Don't drop any ASCII state — modals, empty, error, done each become their own state entry.
- Don't wire real data, fetches, or a framework — static wireframe viewer, not Phase-2 FE.
- Don't invent product copy — labels come from the ASCII / i18n keys.
- Don't run if `mockups.md` is missing — send the user to `/usecase-factory:design-a-screen` first.
