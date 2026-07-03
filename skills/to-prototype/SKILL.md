---
name: to-prototype
description: Render an approved wireframe into an interactive, manipulable prototype that runs INSIDE new-design's real layout (sidebar + chrome) by reusing its actual components — the 4th "mock", after /mockup-to-html and before Phase-2 FE. Unlike mockup-to-html (a static viewer in doc/), this is live React with manipulable state — connect a channel or add a product and the onboarding step turns green; the demo toggle just seeds it. Generic — the skin and components come from a style reference (default new-design/), not baked in. Use after the ASCII wireframe + mockups.data.js are approved and the user wants to "build the interactive prototype", "make the mock clickable/manipulable", "turn the wireframe into a real prototype", or "render the 4th mock". Triggers on "to prototype", "interactive prototype", "manipulable prototype", "clickable mock inside new-design".
disable-model-invocation: true
---

# To Prototype

Fourth and final "mock" of the design phase. Pipeline: `/design-a-screen` (ASCII MAP, the GATE) → `/mockup-to-html` (static interactive viewer in `doc/`) → **`/to-prototype`** (live manipulable prototype inside the real app). Still design-time and throwaway — NO real backend, NO FE↔BE contract. That is Phase-2 FE, a separate later step.

## What makes this different from the 3 other mocks

| Mock | Where | Fidelity | State |
|---|---|---|---|
| ASCII wireframe | `doc/ws-<name>/mockups.md` | sketch (the GATE) | none |
| HTML wireframe | `doc/ws-<name>/mockups.{html,data.js}` | design-system, static | tab/state switch only |
| **Prototype (this)** | `new-design/src/workspaces/<ws>/` | **real components, real layout** | **manipulable — actions mutate state** |
| FE stub-data | the real FE repo | production code | real, backed by stubs (Phase-2) |

The whole point of the prototype over the HTML wireframe: it reveals **flow + interaction** problems that switching tabs/states cannot. So the bar is: each discrete state in `mockups.data.js` (e.g. ov1 → ov2 → ov3) must be reachable by **real user action** (connect a channel, add a product), not a hidden toggle.

## HARD constraints (do NOT violate)

1. **Render INSIDE new-design.** The prototype mounts in new-design's `mock` screen panel, so the platform sidebar + chrome stay exactly as-is. Reuse new-design's real primitives via `../../ui` (`Card`, `Btn`, `Chip`, `Pill`, `Switch`, `Icon`, `useToast`, `ProgressBar`). NEVER build a parallel rail/topbar/shell, and never re-style `--cw-*` tokens — those come from new-design already.
2. **Three-layer split — never inline literals.**
   - components (`index.jsx`, `<tab>.jsx`, `bits.jsx`) = the **engine** (layout + behavior)
   - `copy.js` = **content** — every static VN string lives here, edited in one place
   - `fixtures.js` = **data** — EMPTY/SAMPLE records + the live-state seed/derive helpers
3. **Manipulable state, derived UI.** Lift the shared workspace state (channel connections, product count, run on/off…) to the dashboard. DERIVE the UI (checklist, banners, KPIs) from it. The demo-data toggle only **seeds** that state; user actions then override it. This is what separates a prototype from a viewer.
4. **No backend.** No `fetch`, no real schema/contract, no framework wiring beyond React state. Throwaway design-time artifact.

## Inputs

1. **Wireframe** — `doc/ws-<name>/mockups.md` (the coverage GATE) **and** `doc/ws-<name>/mockups.data.js` (the per-screen state source the prototype must reproduce live). If either is missing/incomplete, STOP and send the user back to `/design-a-screen` → `/mockup-to-html`.
2. **Style reference + components** — repo default **[new-design/](../../../new-design/)**. Tokens in [new-design/src/index.css](../../../new-design/src/index.css); shared primitives in [new-design/src/ui.jsx](../../../new-design/src/ui.jsx). The prototype reuses these directly (it lives inside new-design), so there is nothing to re-skin.

## Output — file structure (the convention the sales pilot established)

Everything under `new-design/src/workspaces/<ws>/`:

| File | Role |
|---|---|
| `index.jsx` | `<WsDashboard>` — header (emoji/title/subtitle + run-switch), tab strip (`wired` hero tabs vs `soon`), content router, floating demo-data toggle, global sandbox modal. Owns the lifted state + seed/derive. |
| `<tab>.jsx` | one file per **wired hero tab**; reuse `../../ui`. Out-of-scope tabs stay `wired:false` ("soon"). |
| `bits.jsx` | ws-specific primitives layered on `../../ui` (channel badges, status pills, fields…). |
| `fixtures.js` | data layer — `EMPTY`/`SAMPLE` + `seed*()` (seed live state from a mode) + `build*()` (derive UI lists from live state). |
| `copy.js` | content layer — one `COPY` object with all static VN copy; interpolated strings are functions. |

Plus ONE registry entry (auto-applied, see step 4) — no edits to App.jsx / rail.jsx.

## Workflow

### 1. Read inputs + confirm the GATE
Read `mockups.md` and `mockups.data.js` end to end. List every tab, every state, every modal/empty/done. Decide which tabs are **hero (wired)** for the pilot vs **soon**. If coverage is incomplete, STOP — don't prototype an unfinished wireframe.

### 2. Scaffold from `assets/`
Copy the skeletons in [assets/](assets/) into `new-design/src/workspaces/<ws>/` and fill them:
- [assets/index.jsx](assets/index.jsx) → `<WsDashboard>`: set TABS (wired/soon), header copy refs, demo-toggle, sandbox, and the **lifted state + `seed`/`build` + handlers** passed to tabs. Export it as a NAMED export `<Ws>Dashboard` (the registry imports it by name).
- [assets/fixtures.js](assets/fixtures.js) → `EMPTY`/`SAMPLE` from `mockups.data.js`, plus `seedSetup(mode)` and `buildChecklist(setup)` (rename per ws). Data-bound copy (list rows, KPI numbers, pulse) lives HERE with its records.
- [assets/copy.js](assets/copy.js) → move EVERY static string from the wireframe into `COPY`, grouped by area; interpolated ones become functions.
- [assets/bits.jsx](assets/bits.jsx) → ws-specific primitives.
- [assets/example-tab.jsx](assets/example-tab.jsx) → the canonical hero tab: shows reading `checklist`/`setup` props, **deriving UI from state**, **morphing between wireframe states** (ov1↔ov2), and pulling all copy from `COPY`. Clone it per hero tab.

### 3. Make each wireframe state reachable by action
For every discrete state in `mockups.data.js`, wire the real action that reaches it (QR-scan → channel connected → step green; add-product → step green → ov2 morph). The demo toggle seeds the baseline; actions move between states live. Verify by clicking, not by reading.

### 4. Wire into new-design (one registry entry)
Add ONE entry to **[new-design/src/workspaces/registry.js](../../../new-design/src/workspaces/registry.js)** — the single source of truth that both App.jsx (screen dispatch) and rail.jsx (pinned sidebar rows) read. Do NOT touch App.jsx or rail.jsx; they map over the registry already.

```js
import { <Ws>Dashboard } from './<ws>';
// …add to the PROTOTYPES array:
{ id: 'mock-<ws>', label: '<Sidebar label>', title: '<hover tooltip>', initials: 'XX',
  gradient: 'linear-gradient(140deg,#…,#…)', Component: <Ws>Dashboard },
```

`id` must be unique and non-empty (convention: `mock-<ws>`). Multiple prototypes coexist — each gets its own pinned row and screen.

### 5. Build + self-check
`cd new-design && bun run build` must pass. Then grep the component files for stray VN literals — anything that isn't a comment, a status-enum key (in `bits.jsx`), or a data value (in `fixtures.js`) belongs in `copy.js`. Tell the user to run `bun run dev` and reach the prototype via the pinned sidebar row.

## Anti-patterns
- Don't build a parallel shell/rail/topbar — mount inside new-design and reuse `../../ui`.
- Don't hand-edit App.jsx / rail.jsx to wire a prototype — add a `registry.js` entry; they read the registry.
- Don't re-skin `--cw-*` tokens — new-design owns the design system.
- Don't inline VN copy in JSX — it goes in `copy.js`; data-bound copy goes in `fixtures.js`.
- Don't make a state reachable only by the demo toggle — every wireframe state needs a real action path.
- Don't wire real data/fetches/contracts — that's Phase-2 FE, not the prototype.
- Don't run if `mockups.md` / `mockups.data.js` are missing or incomplete — send the user back up the pipeline.
- Don't keep the old `<iframe src="mockups.html">` once the live prototype replaces it.
