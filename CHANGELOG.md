# Changelog

All notable changes to `usecase-factory` are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for how to choose a version bump.

## [Unreleased]

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
