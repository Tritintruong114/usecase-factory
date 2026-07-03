---
name: to-prototype
description: Turn an approved wireframe/static mock into a Vite-powered interactive prototype that can be previewed locally as HTML and deployed/viewed on Vercel. Use after mockups.md + mockups.data.js exist and the user wants "to prototype", "interactive prototype", "clickable prototype", "Vite preview", or "render prototype". Output is a self-contained prototype source folder plus a built static preview, not production FE and not tied to new-design.
disable-model-invocation: true
---

# To Prototype

Fourth and final "mock" of the design phase. Pipeline:

`/design-a-screen` → `/mockup-to-html` → **`/to-prototype`** → later Phase-2 FE.

This skill converts the approved wireframe/static mock into a **live, manipulable prototype** backed by a small **Vite + React** source set. The prototype must still be previewable like an HTML artifact and deployable on Vercel, but it is no longer required to mount inside `new-design/`.

## Core idea

`to-prototype` produces two things in the target repo:

1. **Source** — a self-contained Vite app under `prototype/`.
2. **Preview artifact** — a static built preview copied to `prototype.html` / `prototype-assets/` so the repo can be opened/deployed like the old `mockups.html`.

The goal: keep the convenience of `mockups.html` while adding real React state and actions.

## What makes this different from the earlier mocks

| Mock | Where | Fidelity | State |
|---|---|---|---|
| ASCII wireframe | `mockups.md`, `appendix/mockups.md`, or `doc/ws-<name>/mockups.md` | sketch / coverage gate | none |
| HTML wireframe | `mockups.html` + `mockups.data.js` | static viewer | tab/state switch only |
| **Prototype (this)** | `prototype/` source + `prototype.html` built preview | live React/Vite | **manipulable — actions mutate state** |
| FE stub-data | the real FE repo | production code | real FE backed by stubs/contracts |

The whole point of this prototype over the HTML wireframe: it reveals **flow + interaction** problems that switching tabs/states cannot. Every important state in `mockups.data.js` must be reachable by a user action (connect, add, approve, send, toggle, open modal...), not only by a hidden demo toggle.

## Hard constraints

1. **Self-contained Vite app.** Do not require `new-design/`, `../../ui`, or any external app shell. Create/modify `prototype/` in the target repo.
2. **Still previewable as HTML.** After build, generate/copy a static entry at repo root:
   - `prototype.html`
   - `prototype-assets/`
   Vercel must be able to serve it at `/prototype.html`.
3. **Keep root Vercel friendly.** If the repo already has `index.html`, preserve it. If it is only a redirect to `mockups.html`, update it to link or redirect to `prototype.html` if the user wants prototype as default. Do not delete `mockups.html`.
4. **Three-layer split.**
   - `prototype/src/App.jsx` and components = engine/layout/behavior
   - `prototype/src/copy.js` = static Vietnamese copy
   - `prototype/src/fixtures.js` = data records + seed/derive helpers
5. **Manipulable state, derived UI.** The app must own state, derive UI from it, and make each key state reachable by real clicks/forms.
6. **No backend.** No real fetch, auth, DB, schema contract, or production integration. This is a throwaway design artifact.
7. **Do not clobber existing work.** Inspect files first. Preserve existing `mockups.html`, `mockups.data.js`, `index.html`, Vercel config, and git changes unless the user explicitly asks to replace.

## Inputs

Find these in the target repo, accepting the current repo conventions:

- Wireframe: first available of:
  - `mockups.md`
  - `appendix/mockups.md`
  - `doc/ws-<name>/mockups.md`
- Data source: first available of:
  - `mockups.data.js`
  - `appendix/mockups.data.js`
  - `doc/ws-<name>/mockups.data.js`
- Optional style reference:
  - `design-system-tokens.css`
  - existing `mockups.html`

If a wireframe or data source is missing/incomplete, STOP and tell the user to finish `/design-a-screen` → `/mockup-to-html` first.

## Output structure

Create this in the target repo:

```txt
prototype/
  package.json
  index.html
  vite.config.js
  src/
    main.jsx
    App.jsx
    styles.css
    copy.js
    fixtures.js
    components/
      bits.jsx
      Overview.jsx
      Sandbox.jsx
prototype.html
prototype-assets/
```

Recommended URLs after deploy:

- `/prototype.html` = live Vite-built interactive prototype
- `/mockups.html` = old static mockup viewer remains available
- `/` = may redirect/link to `prototype.html` if this is the current approved preview

## Workflow

### 1. Inspect the repo and protect changes

Run:

```bash
git status --short --branch
find . -maxdepth 3 -type f | sort
```

Do not overwrite unrelated modified files. If a conflicting prototype already exists, inspect it and update incrementally.

### 2. Read the gate inputs

Read wireframe and `mockups.data.js` end to end. List:

- tabs/screens
- empty/sample states
- modals
- CTAs/actions
- state transitions
- what must be wired now vs marked "soon"

### 3. Scaffold or update the Vite source

If `prototype/` does not exist, create it from `assets/vite/`.

Minimum dependencies:

```json
{
  "scripts": {
    "dev": "vite --host 0.0.0.0",
    "build": "vite build",
    "preview": "vite preview --host 0.0.0.0"
  },
  "dependencies": {
    "@vitejs/plugin-react": "latest",
    "vite": "latest",
    "react": "latest",
    "react-dom": "latest"
  },
  "devDependencies": {}
}
```

Use `base: './'` in `vite.config.js` so the built preview works from `/prototype.html` with relative assets.

### 4. Implement the prototype

Fill the Vite app from the mock:

- `fixtures.js`: copy/adapt records from `mockups.data.js`; add `seedState(mode)` and derive helpers.
- `copy.js`: put all static VN strings here.
- `App.jsx`: tabs, mode toggle, lifted state, action handlers, content router.
- Components: make important states reachable by clicks/forms, not only by demo data.
- `styles.css`: copy/adapt visual tokens from `design-system-tokens.css` / `mockups.html` where useful, but keep it self-contained.

### 5. Build and produce HTML preview artifact

From target repo:

```bash
cd prototype
npm install
npm run build
cd ..
rm -rf prototype-assets
cp -R prototype/dist/assets prototype-assets
cp prototype/dist/index.html prototype.html
python3 - <<'PY'
from pathlib import Path
p = Path('prototype.html')
s = p.read_text()
s = s.replace('./assets/', './prototype-assets/')
p.write_text(s)
PY
```

If the project uses Bun and `bun install` is already standard, Bun is allowed. Otherwise default to npm for portability.

### 6. Verify

Run:

```bash
python3 -m http.server 4174
```

Then check:

```bash
curl -I http://127.0.0.1:4174/prototype.html
curl -I http://127.0.0.1:4174/prototype-assets/<built-js-file>
```

Also run:

```bash
cd prototype && npm run build
```

The build must pass before reporting done.

### 7. Commit/deploy only when asked or clearly part of current flow

If the user asks to deploy or the repo is already being Vercel-previewed, then:

```bash
git add prototype prototype.html prototype-assets index.html package-lock.json
git commit -m "docs: add vite interactive prototype"
git push origin main
vercel --prod
```

Preserve exact deployment URLs and report them.

## Anti-patterns

- Do not require `new-design/`.
- Do not touch production FE contracts.
- Do not replace `mockups.html`; keep it as the static reference.
- Do not make a giant inline `<script>` if a Vite source tree is expected.
- Do not put all VN copy directly in JSX.
- Do not fake interactivity with only a tab/state switch; actual CTAs must mutate state.
- Do not break Vercel root or existing deployment paths.
