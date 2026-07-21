# Changelog

All notable changes to `usecase-factory` are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for how to choose a version bump.

## [Unreleased]

### Added
- **New skill `grill-to-customer-value`** — an optional, standalone skill (not a pipeline stage;
  nothing downstream depends on it) that grills the SAME dossier + 4 research docs
  `agent-domain-spec` reads (not its output) into `doc/ws-<slug>/customer-value.md`: core customer
  value, layered value (functional/economic/trust), ranked fears, opportunities, problems, and the
  feature groups addressing each fear/value, closing with a feature-centric traceability table.
  Runs a 3-layer interview: persona self-answer (Claude picks a persona + a specific day-moment
  from the docs and drafts hypotheses in character, evidence-labelled) → targeted interview (asks
  the user only what the docs can't answer) → narrowing rounds (forces convergence — "pick 3, pick
  1, what if it's missing" — until the core value and top fear each hold stable across 2
  consecutive rounds), gated on a minimum ~12-question floor so the exercise builds the user's own
  understanding, not just a file. Its fears/value are meant to inform `agent-domain-spec`'s
  guardrails and `grill-to-brief`'s screen purposes only by a human reading it — no skill parses it
  automatically. New template `10-customer-value.template.md`.

- **New skill `brief-to-prototype-spec`** — an optional, explicit-invoke-only bridge that converts
  `Agent-Domain-Spec.md` + `screens-brief.md` (+ an optional real `to-prototype` build) into a
  `doc/ws-<slug>/prototype-spec.md`-shaped file for teams that also run an internal OpenClaw
  build pipeline downstream (confirmed against `gitlab.firegroup.io/tryopenclaw/toc-use-cases` +
  `.../use-case-renderers` — the private "Phase-2, a separate repo" this plugin's `CLAUDE.md`
  already referred to). Runs in two modes: Mode A infers screen inventory/state machine/interaction
  notes from `screens-brief.md` + `appendix/mockups.md` and fills the data contract from
  `Agent-Domain-Spec.md`'s core objects/lifecycle/tool policy; Mode B (if `to-prototype` was run)
  extracts the same sections mechanically from the real prototype code instead. Every non-mechanical
  field that can't be traced to a source is flagged `<<DEFER: grill>>`, never invented. It never
  reads from or writes to any external repo — only this repo's own output shape. New template
  `09-prototype-spec.template.md`.

- **New skill `handoff-to-brief`** — an alternate pipeline entry point for when a product is
  already decided and documented elsewhere (a reverse-engineered spec of a live app, an old PRD,
  a design-system export with a per-screen breakdown), replacing `run` → `agent-domain-spec` →
  `grill-to-brief` for that case. It extracts (rather than interviews) the same `screens-brief.md`
  contract straight from the source doc — reusing `grill-to-brief`'s template verbatim — so
  `design-a-screen` and `brief-to-html` run unmodified afterward. It never writes
  `Agent-Domain-Spec.md`/`01-PRODUCT-MAP.md` and never renders a Decision Gate verdict; gate
  decisions the source doc leaves genuinely open (⚠-flagged inconsistencies, live-vs-dead scope,
  the v0/deferred cut line, which file holds the design tokens) are still always surfaced and
  confirmed, never silently resolved.

- **Decision Pack output shape.** `run` now also writes `doc/ws-<slug>/00-START-HERE.md` (template
  `08-start-here`) as soon as a verdict exists — a 5–10 line summary, the verdict + why, and
  role-based routing (product / builder / evidence). Every later stage (`agent-domain-spec`,
  `grill-to-brief`, `brief-to-html`) UPDATES this same file as its artifacts land, so it stays
  accurate at whatever gate a run stops.
- **`01-PRODUCT-MAP.md`** (template `07-product-map`, written by `agent-domain-spec`) — a one-page
  product decision: pain → user → workflow → agent job → business value → moat, the core loop +
  agent actions + human approval points + guardrails + success metrics, and an explicit "not in v0"
  list to block scope creep. This is a projection of `Agent-Domain-Spec.md` + the research, not a
  research summary — every claim traces to a section in `appendix/` or the spec.
- `scripts/coverage-check.sh` now also checks `00-START-HERE.md` exists.
- `scripts/validate-agent-domain-spec.sh` now also checks that `01-PRODUCT-MAP.md` exists next to
  the spec and is placeholder-free.

### Fixed
- **`to-prototype` (shipped 1.1.0) was never documented** in `README.md`'s skill tree/pipeline/skill
  count or `CLAUDE.md`'s "In-flight note" — both now list it alongside the new
  `brief-to-prototype-spec` addition.

### Changed
- **Evidence moved into `appendix/`.** The dossier (was `_research/dossier.md`, now
  `appendix/dossier.md`) and the 4 research docs (`Boi-Canh-Va-Van-De.md`,
  `MR-<slug>-Problem-Solution.md`, `Target-User-<slug>.md`, `MVP-Coreloop.md`) moved from the
  workspace root into `appendix/`. `design-a-screen`'s ASCII wireframe (`mockups.md`) also moved
  into `appendix/`. `Agent-Domain-Spec.md`, `screens-brief.md`, and `mockups.{html,data.js}` stay
  at the workspace root — they're decisions/deliverables, not evidence.
- **`HANDOFF.md` is retired.** Its job (verdict, read-order, scope boundaries, next step per
  receiver) is now carried by `00-START-HERE.md` from the very first stage instead of appearing
  only once `brief-to-html` finishes. `brief-to-html`'s former Step 5 ("emit the handoff index")
  is now "finalize `00-START-HERE.md`" — it updates the existing file instead of creating a new
  one. `skills/brief-to-html/assets/HANDOFF.template.md` was deleted; its content is folded into
  the new `08-start-here.template.md`.
- **BREAKING: output file paths changed.** Any tooling/scripts that read
  `doc/ws-<slug>/_research/dossier.md`, the 4 research docs from the workspace root, or
  `doc/ws-<slug>/HANDOFF.md` must be updated — see the `appendix/` layout above. Per
  `CONTRIBUTING.md`'s versioning table, renaming/moving output files is a MAJOR bump: `0.3.0 →
  1.0.0`.
- `README.md`, `CLAUDE.md`, and `CONTRIBUTING.md` updated for the new output shape and paths.

## [0.3.0] - 2026-07-02

### Added
- **New pipeline stage `agent-domain-spec`** (skill + playbook) between `run` and `grill-to-brief`.
  Turns the research dossier + MVP core loop into `Agent-Domain-Spec.md` — how the nghiệp-vụ is
  agent-ised: domain thesis, human/agent/tool role split, core objects, object lifecycle/state
  machine, intent taxonomy, signals, eligibility rules, decision policy, priority/scoring,
  confidence & uncertainty, approval policy (auto/cần duyệt/cấm), tool/action policy, draft/content
  policy, guardrails/anti-abuse/trust boundaries, learning loop, background jobs, an **OpenClaw
  implementation map** (skills/tools/connectors/memory/sessions/cron/approval/guardrails/workspace
  state), metrics, and open questions (§0–§19). The screen brief is now a *projection* of this spec.
- Template `06-agent-domain-spec.template.md` (the §0–§19 heading contract).
- Validator `scripts/validate-agent-domain-spec.sh` (+ `npm run validate:agent-domain-spec`) — checks
  §0–§19, the approval layering (auto/cần duyệt/cấm), guardrails, and the OpenClaw map.
- Two agents for the new stage: `domain-modeler-agent` (extracts objects/lifecycle/intent/signals/
  decision-points from the research) and the adversarial `agent-logic-reviewer` (hunts
  over-automation, missing approval gates, ambiguous states, thin guardrails, trust risk, and
  spec↔screen-brief mismatch). Both read-only.
- `CONTRIBUTING.md` — contribution contract (thin-router + playbook skill shape, read-only
  research agents, template/validator heading contract, SemVer policy, pre-PR checklist).
- `CLAUDE.md` — developer guide for the plugin.
- `CHANGELOG.md` — this file.
- `scripts/extract-design-tokens.sh` — basic extractor that pulls `--cw-*` tokens out of a
  bundled/self-contained design-system HTML into a paste-ready `design-tokens.css`
  (light + dark blocks) for `brief-to-html`.
- Screen brief gained a required `## Design system` section (records the exact token/component
  files) and a `## Nav & headings spec` block (top nav + per-screen titles/headings, the
  copy-paste payload for an external generator).

### Changed
- **`grill-to-brief` now consumes `Agent-Domain-Spec.md` as its primary input** — the screen brief
  is a projection of the agent domain spec, not invented business. Backward-compatible: if the spec
  is missing (older workspaces), it warns strongly and falls back to the 4 research docs. `run` and
  the dossier handoff now route Proceed → `agent-domain-spec` → `grill-to-brief`.
- Version bumped `0.2.0` → `0.3.0` (new backward-compatible stage).
- **Renamed `mockup-to-html` → `brief-to-html`** and flipped its primary input from the ASCII
  map to the screen brief. The prototype's *look* now comes from the brief's intent skinned by
  the design system; the ASCII (`mockups.md`) is demoted to a coverage cross-check only. This
  removes the anchoring that made ASCII-driven HTML render ugly.
- **A design system is now REQUIRED** across `grill-to-brief` / `design-a-screen` /
  `brief-to-html` — the silent neutral-default fallback is gone; the skills STOP and ask if none
  resolves. Default location moved `new-design/` → `design-system/`, and the skills now ASK which
  file(s) hold tokens vs components instead of assuming a fixed `src/index.css`/`ui.jsx` layout.

## [0.1.0]

### Added
- Initial local plugin MVP: pipeline `[use-case-brief] → run → grill-to-brief →
  design-a-screen → mockup-to-html`, plus the `copy-writer` sub-skill.
- 5 agents: 4 research workers (market-sizing, jtbd-pain, competitor-substitute, persona-wtp)
  and 1 adversarial decision-gate-reviewer.
- Validators `scripts/validate-dossier.sh` and `scripts/coverage-check.sh`.
- Decision Gate: Proceed / Pivot / Narrow / Kill verdict over a single-source-of-truth dossier.
