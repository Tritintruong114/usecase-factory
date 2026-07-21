# ClawExperts Use-Case Factory

> **ClawExperts packages expert workflows into installable AI-agent plugins.**

A Claude Code plugin (`usecase-factory`) that takes an **AI Agent use-case idea** all the way from market research to a self-contained, reviewable screen prototype — with a clear **Proceed / Pivot / Narrow / Kill** decision gating the way.

Give it an idea plus a target market and it runs the full pipeline: spawn parallel web-research worker agents → layer their findings (must-cite / infer / assumption) into a single dossier that becomes the source of truth → synthesize four research docs → **render a verdict** at a Decision Gate → (on Proceed) design the **Agent Domain Spec** — how the nghiệp-vụ gets agent-ised and runs on OpenClaw primitives — → grill that into a justified screen brief → draw ASCII wireframes → render a self-contained HTML prototype. It stops short of real backend code and an FE↔BE contract — that is Phase-2 FE, a later step.

The output is not a pile of research files — it's a **Decision Pack**. Every run keeps a
`00-START-HERE.md` current, from the very first stage onward: verdict, a 5–10 line summary, why,
and role-based routing (product / builder / evidence). A reader should know whether the use case is
worth pursuing, and what to build first, in **under 3 minutes** — without reading anything else.

```
Use-case idea → Research dossier → MVP core loop → Agent Domain Spec → Screen brief → ASCII → HTML → OpenClaw implementation
   (seed)         (run + Decision Gate)            (agent-domain-spec)   (grill-to-brief) (design-a-screen) (brief-to-html)  (Phase-2, outside the plugin)
```

For **Agent Apps** the **Agent Domain Spec** stage is what stops the pipeline from jumping straight from a core loop to UI: it specs how the business is agent-ised (which objects the agent watches, their lifecycle, how it classifies intent, when it acts vs asks vs stays silent, which tools it may call, which actions need human approval, which guardrails block risk, what user feedback updates) and maps each part onto OpenClaw primitives — *before* any screen is drawn. The screen brief is then a **projection** of that spec.

The pipeline is staged, so you can also stop at any gate (research-only, decision-only, domain-spec-only, or screen-brief-only) and hand off from there.

### Alternate entry: you already have the product decided

The three stages above (`run` → `agent-domain-spec` → `grill-to-brief`) exist to justify a screen set for an idea **nobody has decided yet**. If instead you already have documentation of something that **exists** — a reverse-engineered spec of a live app you're rebuilding, an old PRD, a design-system export with a screen-by-screen breakdown — skip straight to `/usecase-factory:handoff-to-brief <slug> <path to the doc>`. It extracts (rather than interviews) the same `screens-brief.md` contract straight from the doc, so `design-a-screen` and `brief-to-html` run unmodified afterward:

```
Existing product's handoff/design doc → Screen brief → ASCII (optional) → HTML → prototype
        (already decided)                (handoff-to-brief) (design-a-screen)  (brief-to-html)
```

It never writes `Agent-Domain-Spec.md` / `01-PRODUCT-MAP.md` and never renders a Decision Gate verdict — those exist only to validate an undecided idea.

### Optional bridge: handing a Decision Pack off to an internal OpenClaw build pipeline

If your org also runs an internal OpenClaw use-case build pipeline downstream of this plugin (one
that expects a locked `prototype-spec.md` as its own Phase-0 input — e.g. a `design-to-renderer`-style
skill), `/usecase-factory:brief-to-prototype-spec <slug>` converts `Agent-Domain-Spec.md` +
`screens-brief.md` (+ an optional real `to-prototype` build) into that shape, so the handoff doesn't
require re-typing the domain spec by hand. This is explicit-invoke-only, never touches any external
repo, and is irrelevant if you don't have such a downstream pipeline.

## The output shape — a Decision Pack, not a pile of files

Every artifact in `doc/ws-<slug>/` falls into one of three tiers, and the file layout says so:

```
doc/ws-<slug>/
├── 00-START-HERE.md          # read FIRST — verdict, summary, why, routing. Exists from the
│                              # earliest stage; every later stage updates it, never duplicates it.
├── 01-PRODUCT-MAP.md         # for product / decision-makers — pain → user → workflow →
│                              # agent job → business value → moat, core loop, and what's NOT in v0.
├── Agent-Domain-Spec.md      # for builders — how the nghiệp-vụ is agent-ised on OpenClaw
├── screens-brief.md          # for builders — the justified screen set + flows + coverage
├── mockups.html + mockups.data.js   # the prototype — an inseparable pair
├── brief.md                  # optional seed input (from /usecase-factory:use-case-brief)
└── appendix/                 # evidence, not decisions — open it to verify a claim, not to decide
    ├── dossier.md             #   single source of truth: evidence table + Decision Gate
    ├── Boi-Canh-Va-Van-De.md  #   Context & Problem
    ├── MR-<slug>-Problem-Solution.md   # JTBD + solution hypotheses + competitors/substitutes
    ├── Target-User-<slug>.md #   the persona
    ├── MVP-Coreloop.md       #   the core loop + v0 scope + cut line
    └── mockups.md             #   ASCII wireframe — the coverage GATE, not the reviewable artifact
```

**Read `00-START-HERE.md` first, always** — it's written by `/usecase-factory:run` as soon as a
verdict exists and updated by every later stage, so it's accurate at whatever gate a run stops
(research-only, decision-only, domain-spec-only, or screen-brief-only). It tells you the verdict,
a 5–10 line summary, why, and exactly which of the two files below to read next for your role.

| File | Role | Receiver |
|---|---|---|
| **`00-START-HERE.md`** | verdict + summary + why + role-based routing | **read FIRST, by everyone** |
| `01-PRODUCT-MAP.md` | the product decision in one page: pain → user → workflow → agent job → business value → moat, core loop + agent actions + human approval points + guardrails + success metrics, and what's explicitly **not** built in v0 | product / decision-makers |
| `Agent-Domain-Spec.md` | how the nghiệp-vụ is agent-ised: objects, lifecycle, intents, signals, decision/approval policy, guardrails, learning loop, background jobs, + the OpenClaw implementation map | builders / OpenClaw build |
| `screens-brief.md` | the justified screen set (each screen traces to one job + one slice of the domain spec) + flows + coverage | builders |
| **`mockups.html` + `mockups.data.js`** | the headline viewable prototype — **an inseparable pair** | non-tech review · future web-app prototype |
| `appendix/` — dossier + 4 research docs + ASCII map | evidence and coverage-check artifacts behind the decision | anyone verifying a claim, Phase-2 FE dev |

> ⚠ **`mockups.html` and `mockups.data.js` travel together.** The `.html` loads the data via `<script src="mockups.data.js">` (relative path), so both must stay in the same folder — emailing/zipping/uploading the `.html` alone renders blank. "Self-contained" means self-contained **as a pair**.

Every claim in `00-START-HERE.md` / `01-PRODUCT-MAP.md` that isn't self-evident should trace back to
a section in `appendix/` or `Agent-Domain-Spec.md` — if it doesn't, it's an assumption, and the doc
should say so rather than launder it into fact.

## What's inside the plugin

```
usecase-factory/
  package.json                 # npm packaging (publish-ready)
  README.md
  .claude-plugin/
    plugin.json                # plugin manifest (skills/ + agents/ are auto-discovered)
  skills/
    run/
      SKILL.md                 # thin router → the command /usecase-factory:run
      playbook.md              # the full 9-step execution guide (read first)
      templates/
        00-research-dossier.template.md
        01-context-problem.template.md
        02-mr-problem-solution.template.md
        03-target-user.template.md
        04-mvp-coreloop.template.md
        08-start-here.template.md   # → 00-START-HERE.md, the Decision Pack entry point
    agent-domain-spec/         # research + core loop → Agent-Domain-Spec.md (how the nghiệp-vụ is agent-ised on OpenClaw)
      SKILL.md                 # thin router → the command /usecase-factory:agent-domain-spec
      playbook.md              # the full 9-step execution guide (read first)
      templates/
        06-agent-domain-spec.template.md
        07-product-map.template.md  # → 01-PRODUCT-MAP.md, the product decision map
    grill-to-brief/
      SKILL.md                 # thin router → the command /grill-to-brief
      playbook.md              # the full 8-step execution guide (read first)
      templates/
        05-screens-brief.template.md
    handoff-to-brief/          # ALTERNATE entry — existing product's handoff doc → screens-brief.md
      SKILL.md                 # thin router → the command /usecase-factory:handoff-to-brief
      playbook.md              # extract-then-confirm workflow; reuses grill-to-brief's template
    copy-writer/               # UX microcopy — invoked by grill-to-brief step 7
      SKILL.md
    design-a-screen/           # screens-brief.md → ASCII wireframes (appendix/mockups.md)
      SKILL.md
    brief-to-html/             # screen brief + design system → static HTML viewer; finalizes 00-START-HERE.md
      SKILL.md
      assets/                  # template.html + example.data.js
    to-prototype/              # OPTIONAL 4th mock — live manipulable React prototype in new-design/
      SKILL.md
      assets/                  # index.jsx/fixtures.js/copy.js/bits.jsx/example-tab.jsx skeletons
    brief-to-prototype-spec/   # OPTIONAL bridge — Agent-Domain-Spec.md + screens-brief.md → a
                               # prototype-spec.md-shaped file for an internal OpenClaw build
                               # pipeline downstream (e.g. a design-to-renderer-style skill)
      SKILL.md
      playbook.md
      templates/
        09-prototype-spec.template.md
    use-case-brief/            # OPTIONAL upstream — rough idea → validated brief.md seed
      SKILL.md
    grill-to-customer-value/  # OPTIONAL standalone — dossier + 4 doc research → customer-value.md
                               # (core customer value, ranked fears, opportunities, problems,
                               # feature groups + a feature-centric traceability table). Not a
                               # pipeline stage; nothing downstream depends on it.
      SKILL.md
      playbook.md              # 3-layer grill: persona self-answer → interview → narrowing rounds
      templates/
        10-customer-value.template.md
  agents/
    market-sizing-researcher.md         # worker A — market size & context
    jtbd-pain-researcher.md             # worker B — jobs-to-be-done & pain
    competitor-substitute-researcher.md # worker C — competitors + every substitute
    persona-wtp-researcher.md           # worker D — persona & willingness-to-pay
    decision-gate-reviewer.md           # adversarial reviewer of the verdict
    domain-modeler-agent.md             # extracts objects/lifecycle/intent/decisions for the Agent Domain Spec
    agent-logic-reviewer.md             # adversarial reviewer of the Agent Domain Spec (over-automation, missing approval, trust risk)
  scripts/
    validate-dossier.sh             # checks the dossier heading contract
    coverage-check.sh               # checks 00-START-HERE.md + the 4 research docs (placeholder-free)
    validate-agent-domain-spec.sh   # checks the Agent Domain Spec heading contract (§0–§19) + 01-PRODUCT-MAP.md
    extract-design-tokens.sh        # bundled-HTML design system → paste-ready tokens.css
  design-system/               # bundled DEMO design system (NOT shipped; teams point at their own)
    Openclaw_Design_System.html
```

## Install from the marketplace

```
/plugin marketplace add Tritintruong114/usecase-factory
/plugin install usecase-factory@clawexperts
```

Then refresh later with `/plugin marketplace update`.

## Test it locally

From the cloned repo root:

```bash
claude --plugin-dir .
```

Then, inside Claude Code:

```
/usecase-factory:run <slug> <use-case idea + target market>
```

Example:

```
/usecase-factory:run sale-ai-agent An AI sales agent that follows up with leads on Zalo and Facebook for Vietnamese SMEs
```

If you omit the idea, the skill looks for `doc/ws-<slug>/brief.md`, then asks up to five short questions to fill the gaps before any research starts.

## Validate the output

The skill runs these automatically before finishing; you can also run them by hand:

```bash
bash scripts/validate-dossier.sh            doc/ws-<slug>/appendix/dossier.md
bash scripts/coverage-check.sh              doc/ws-<slug> <slug>
bash scripts/validate-agent-domain-spec.sh  doc/ws-<slug>/Agent-Domain-Spec.md
```

- `validate-dossier.sh` — confirms the dossier carries sections 0–9, an Evidence Table, and a Decision Gate verdict.
- `coverage-check.sh` — confirms `00-START-HERE.md` exists and the four research docs (in `appendix/`) have no leftover placeholders (`<placeholder>`, `TODO`, guidance comments, etc.).
- `validate-agent-domain-spec.sh` — confirms the Agent Domain Spec carries all sections §0–§19, an approval classification (auto / cần duyệt / cấm), guardrails, the OpenClaw implementation map, and that `01-PRODUCT-MAP.md` exists alongside it.

## Design system

The HTML render (`brief-to-html`) is always skinned by a **design system** — that's what makes the prototype look real instead of like raw ASCII boxes. The model:

- **Design systems live *outside* this repo.** Each team points at their own (a path, URL, or Figma/Storybook export). The repo ships one **bundled demo** under `design-system/` so the pipeline runs out of the box.
- **Pick one per run.** `grill-to-brief` records the chosen system in the brief's `## Design system` section — the exact file(s) for tokens and components. Resolution order: the path you name → `$DESIGN_SYSTEM_ROOT` → the bundled demo. If none resolves, the render skills **stop and ask** (there's no skin-less fallback — that's exactly what makes HTML render ugly).
- **Bundled HTML? Extract tokens first.** If the design system is a self-contained HTML export, run `npm run extract:tokens path/to/design-system.html` to produce a clean `tokens.css` (light + dark) next to it. `brief-to-html` inlines those tokens into `mockups.html`, so the prototype stays self-contained.
- **The generated `tokens.css` is not committed** — it's reproducible from the source, so it's gitignored like other build output.

## How research and evidence work

A few rules are load-bearing — they are what make the output trustworthy:

- **The internet is the research engine.** Market size, competitors, pain, and pricing come from real web search and fetched, cited sources — not from memory and not from a vault.
- **A `brief.md` or any local note is a seed, never a source.** It tells the factory what's already decided (core loop, scope) so the research doesn't contradict it; it does not supply market numbers.
- **The dossier is the source of truth.** The four output docs may only state claims that have a row and a source/label in the dossier.
- **Every claim is layered.** *Must-cite* claims (market size, pricing, traction, regulation, real pain quotes) need a URL and are verified across two or more independent sources where it matters. *Infer* claims are reasoned and labelled. *Assumptions* (willingness-to-pay, urgency, switching, integration, ROI) are labelled unverified — never laundered into fact.
- **Nothing is fabricated.** When the web can't answer something, it's recorded as a gap plus the question to validate by interview — not filled with an invented number.
- **The factory renders a verdict.** It ends at a Decision Gate and never defaults blindly. Unverified willingness-to-pay is normal at this stage and becomes the top risk to carry forward — not a reason to stall.

## Development status

- **v1.2.0** (current, 2026-07-18) — local plugin MVP. **v1.0.0** made the output shape a stable
  **Decision Pack** contract: `00-START-HERE.md` and `01-PRODUCT-MAP.md` are required outputs, the
  dossier + 4 research docs + the ASCII map moved into `appendix/`, and the old terminal-only
  `HANDOFF.md` was retired — its job is now carried by `00-START-HERE.md` from the very first stage
  (breaking change to output paths). **v1.1.0** added `handoff-to-brief` (alternate entry for an
  already-decided product) and `to-prototype` (optional live React prototype). **v1.2.0** added
  `brief-to-prototype-spec` — an optional bridge into an internal downstream OpenClaw build
  pipeline. See `CHANGELOG.md` for full detail per version.
- **11 skills** — the pipeline `[use-case-brief] → run → agent-domain-spec → grill-to-brief → design-a-screen → brief-to-html → [to-prototype] → [brief-to-prototype-spec]`, plus `copy-writer` (microcopy, invoked by grill-to-brief), the alternate entry `handoff-to-brief`, and the optional standalone `grill-to-customer-value` (dossier + 4 doc research → `customer-value.md`: core customer value, ranked fears, opportunities, problems, and the feature groups addressing each, via a 3-layer grill — persona self-answer, targeted interview, narrowing rounds gated on a stability check + a minimum question count. Nothing else in the pipeline depends on it or reads it automatically), + **7 agents** (4 research workers + 1 adversarial decision-gate reviewer + `domain-modeler-agent` and the adversarial `agent-logic-reviewer` for the Agent Domain Spec). `agent-domain-spec` sits between `run` and `grill-to-brief`: it turns the research + core loop into `Agent-Domain-Spec.md` (how the nghiệp-vụ is agent-ised on OpenClaw) so the pipeline doesn't jump from a core loop straight to UI, then distills the product decision into `01-PRODUCT-MAP.md`. `design-a-screen` (ASCII) and `brief-to-html` (HTML) both branch off the screen brief: the ASCII is a coverage-gate artifact filed in `appendix/`, while `brief-to-html` renders from the brief + [design system](#design-system) and only cross-checks coverage against the ASCII. `use-case-brief` is an **optional** upstream (it only produces a seed `brief.md`; `run` works from a bare idea too). `to-prototype` is an **optional** 4th mock — a live, manipulable React prototype, still throwaway design-time. The pipeline terminates with `brief-to-html` finalizing `00-START-HERE.md`; the real OpenClaw build (which needs a dev environment) is intentionally left to a separate repo — `brief-to-prototype-spec` is an **optional** explicit-invoke bridge for teams whose separate repo expects a `prototype-spec.md`-shaped handoff (see [above](#optional-bridge-handing-a-decision-pack-off-to-an-internal-openclaw-build-pipeline)).
- Tested locally with `claude --plugin-dir .` (skills + all 7 agents discovered via `claude plugin details`).
- **npm-ready but not published** — no package will be pushed unless the maintainer explicitly confirms.

## Publishing

The `package.json` publishes to npm as **`@clawexperts/claude-usecase-factory`**. Publishing is intentionally gated — only run this once the ClawExperts maintainer confirms:

```bash
npm publish --access public
```

The published tarball ships `.claude-plugin/`, `skills/`, `agents/`, `scripts/`, and this README. The same folder can also be distributed via a Claude plugin marketplace.

## Contributing

Contributions are welcome. The plugin is built from Markdown skills + agents (no app code) and a
few bash validators. Read [`CONTRIBUTING.md`](./CONTRIBUTING.md) for the contribution contract —
the thin-router + playbook skill shape, the read-only research agents, the template/validator
heading contract, the load-bearing evidence rules, and the pre-PR checklist. For plugin
architecture and the developer guide, see [`CLAUDE.md`](./CLAUDE.md).

## License

MIT

---

## OpenClaw Runtime Support

This repository has **two runtimes**:

| Runtime | Skill | Use case |
|---------|-------|----------|
| **Claude Desktop** | `skills/run/` (slash commands) | Full auto-pipeline: research → dossier → verdict → screens → prototype |
| **OpenClaw Agent** | `skills/run-openclaw/` (Tavily + exec + sessions_spawn) | Same pipeline, manual steps, Telegram/presentation-friendly |

Both produce identical `doc/ws-<slug>/` output layout — they can work on the same use-case.
The OpenClaw skill is designed to survive tool timeouts and resume mid-pipeline.

See `skills/run-openclaw/SKILL.md` for details.
