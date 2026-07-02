# Changelog

All notable changes to `usecase-factory` are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for how to choose a version bump.

## [Unreleased]

### Added
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
