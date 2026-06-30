---
name: brief-to-html
description: Render a justified screen brief (screens-brief.md) into an interactive HTML prototype — a fixed engine (mockups.html) plus a content file (mockups.data.js) — so the screen set can be eye-reviewed at real fidelity (clickable tabs, per-screen state switcher, light/dark) before any FE code. The LOOK comes from the brief's intent (purpose, must-show, actions, states, copy, nav & headings) skinned by a REQUIRED design system — never from ASCII art, which anchors the model to an ugly literal layout. The ASCII map (mockups.md), if present, is only a coverage cross-check. Use after /usecase-factory:grill-to-brief lands the screen brief and the user wants to "render the brief to HTML", "make the screens interactive", "turn the brief into a clickable prototype", or "preview the screens with the real design system". Triggers on "brief to html", "render the brief", "interactive prototype", "clickable mockup".
disable-model-invocation: true
---

# Brief to HTML

Render of the Phase-1 screen set. `/usecase-factory:grill-to-brief` produces the justified SPEC (`screens-brief.md`); this turns it into an interactive prototype for eye-review. Still a wireframe, NOT FE code: static markup, no real data, lives in `doc/`.

**Why the brief drives the look, not the ASCII.** An ASCII mockup is a precise *low-fidelity* artifact: monospace grid, box-drawing, hard borders. Hand it to a generative renderer and the model faithfully reproduces that ugliness — cramped, boxy, no hierarchy. The screen brief is *intent* (what each screen is for, what it must show, what states it has, what the copy is, what the nav shape is). Intent + a real **design system** lets the model apply good visual design instead of copying a crude grid. So: render from the brief, skin with the design system, and use the ASCII only to check that nothing was dropped.

## Two-file output (engine ↔ content split)

| File | Role | Per use-case |
|---|---|---|
| `mockups.html` | **Engine + style** — app shell, tab/state switch, light/dark, all CSS primitives. Copied verbatim from the template; the ONLY edit is the design-token block. | builds the DOM from `window.WIREFRAME` |
| `mockups.data.js` | **Content** — `window.WIREFRAME = {meta, tabs, screens}`. One text file holding every screen as an HTML string. | this is what you author each time |

> **The two files are ONE inseparable pair.** `mockups.html` loads the data via `<script src="mockups.data.js">` (relative path), so both MUST sit in the same folder — open/email/zip/upload them together. The `.html` alone renders blank. "Self-contained" means self-contained **as a pair**, not as one file.

Loaded via `<script src="mockups.data.js">` (not `fetch`), so the prototype opens on **double-click** (`file://`, no server, no CORS). Hard line: no real data wiring, no framework — Phase-2 FE stub-data is a separate, later step.

## Inputs

1. **Screen brief (PRIMARY)** — `doc/ws-<name>/screens-brief.md` (or nearest). This is the spec the prototype renders: per screen → Purpose, Must-show, Actions (+ outcomes), States (display + outcome), Section headings, Copy; plus the `## Nav & headings spec`, `## Flows`, and `## Coverage check`. Every screen + every state + every flow it lists must appear in the output. If the brief is missing/incomplete, STOP and send the user to `/usecase-factory:grill-to-brief`.
2. **Design system (REQUIRED)** — where the look comes from. This pipeline always renders against a design system; there is no acceptable skin-less output.
   - **Use the exact file(s) the screen brief's `## Design system` section recorded** (tokens file + components file) — don't re-resolve if the brief already pinned them.
   - If the brief didn't record them, or the user names a different reference: resolve the location — design systems normally live OUTSIDE this repo (a path/URL the user names → `$DESIGN_SYSTEM_ROOT` → the repo's bundled demo **`design-system/`**) — then **list its files and ASK the user which file holds the design tokens and which holds the component shapes.** The layout is NOT fixed — it may be a single bundled HTML (e.g. `design-system/Openclaw_Design_System.html`), not a `src/index.css`/`ui.jsx` pair — so never assume.
   - **None resolvable → STOP and ask the user to point at a design system.** Do NOT render with the template's neutral default tokens — skin-less output is the very thing that makes the HTML ugly, and the pipeline forbids it.
3. **ASCII map (OPTIONAL — coverage cross-check only)** — `doc/ws-<name>/mockups.md`, if `/usecase-factory:design-a-screen` ran. Use it ONLY to verify coverage (did the brief-driven render miss a screen/state the ASCII enumerated?). **Never use it as the visual template** — that is the anchoring trap this skill exists to avoid.

## Workflow

### 1. Read the inputs
Read `screens-brief.md` end to end — list every screen, its states (display + outcome), its copy (title/subtitle/headings/action labels), the nav shape + items from `## Nav & headings spec`, and the `## Flows`. This screen+state list is the **coverage contract**. Then read the design system file(s) the brief recorded; extract its **design tokens** (canvas/card/border/ink/accent, radius, font, shadow, light+dark) and **component shapes** (button variants, pill/badge, chip, switch, card). You map the design system onto the engine's class names — restyle, don't invent. If `mockups.md` exists, skim it once for coverage only.

> **If the design system is a bundled/self-contained HTML** (its tokens are buried in a `__bundler` payload, e.g. `design-system/Openclaw_Design_System.html`), don't hand-scrape it — run `bash ${CLAUDE_PLUGIN_ROOT}/scripts/extract-design-tokens.sh <design-system-file>` first. It emits a `tokens.css` next to the source with paste-ready `[data-theme="light"]`/`[data-theme="dark"]` `--cw-*` blocks; paste those into step 2's token blocks verbatim.

### 2. Write `mockups.html` from the engine template
Copy [assets/template.html](assets/template.html) verbatim to `doc/ws-<name>/mockups.html`. Do NOT touch the engine script or rename classes. The **only** edit: replace the neutral values in the `[data-theme="light"]` / `[data-theme="dark"]` token blocks with the tokens extracted from the design-system file(s) the user confirmed (map its color/radius/type/shadow values onto the matching token names). Keep token NAMES stable. If the design system has no dark theme, keep the fallback.

### 3. Write `mockups.data.js` from the BRIEF
Model on [assets/example.data.js](assets/example.data.js). Fill:
- `meta` — title, subtitle, `source` (path to screens-brief.md), `styleRef` (the design system file). Set `runSwitch:true` only if the brief has a live/rest concept; else omit.
- `tabs` — one `{id,label}` per screen (order = the nav order from `## Nav & headings spec`; first is active). Labels come from each screen's Page title.
- `screens[tabId]` — `states:[{id,label}]` (one per display + outcome state in the brief) + `html:{stateId: \`...\`}` for each state. **Build each screen's HTML from the brief's intent** — Must-show as the content, Section headings as h2s, primary/secondary Actions as buttons wired to nothing, Copy as the labels — laid out per the nav shape and **styled with the design system's component shapes**. You have layout freedom within the brief's intent; render it the way the design system would, NOT as a transcription of ASCII boxes. Render each modal/drawer/empty/error/done as its own state entry.

Use template literals for multi-line HTML. Copy = the brief's Copy block (which mirrors FE i18n keys); do NOT write new product copy.

### 4. Persist + coverage cross-check
Both files sit in `doc/ws-<name>/` (same folder — the pair is inseparable). Verify coverage against the **brief**: every screen + every display/outcome state + every flow step has a matching `tabs` / `states` / `html` entry. **If `mockups.md` exists, also cross-check against it** — anything the ASCII enumerated that the brief-driven render lacks is a gap: add it (and note the brief should have listed it). Confirm the data file parses (no unescaped backticks inside template strings). Tell the user which design system was used (you must have one — if none resolved, you should have STOPPED at the input step). Suggest they double-click `mockups.html` to review.

### 5. Emit the handoff index (`HANDOFF.md`)
This is the pipeline's terminal step — write `doc/ws-<name>/HANDOFF.md` from [assets/HANDOFF.template.md](assets/HANDOFF.template.md) so the package is self-explaining. Fill: the Decision-Gate verdict + top risk (from `_research/dossier.md`), the artifact list (treat `mockups.{html,data.js}` as ONE pair), the scope boundaries, the next step per receiver, and which design system was used. If a prior `HANDOFF.md` exists, update it rather than duplicating. This turns a folder of files into a handoff a stakeholder / web-app / Phase-2 dev can pick up without asking.

## Anti-patterns
- **Don't render from the ASCII as a visual template** — that anchors the model to a crude monospace grid and is exactly why HTML came out ugly. Render from the brief's intent; the ASCII is a coverage check only.
- Don't hand off `mockups.html` without `mockups.data.js` — they are one pair; the `.html` alone renders blank. Always ship/zip/upload both, in the same folder.
- Don't bake a design system into the skill — the skin always comes from the resolved design system; the skill is generic.
- Don't inline screens into `mockups.html` or rewrite its engine — content lives only in `mockups.data.js`; restyle via the token block.
- Don't use `.json` + `fetch` for content — it breaks `file://` double-click. Content is a `.js` global.
- Don't drop any state the brief lists — modals, empty, error, done each become their own state entry.
- Don't wire real data, fetches, or a framework — static wireframe viewer, not Phase-2 FE.
- Don't invent product copy — labels come from the brief's Copy block / i18n keys.
- Don't run if `screens-brief.md` is missing — send the user to `/usecase-factory:grill-to-brief` first.
