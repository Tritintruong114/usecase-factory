# CLAUDE.md — usecase-factory (developer guide)

This repo **is a Claude Code plugin** (`usecase-factory`), not an app. There is no build
step and no runtime server. You ship Markdown: skills, playbooks, agent specs, templates,
and a couple of bash validators. README.md is the user-facing doc; this file is for
**developing the plugin itself**.

## What ships vs. what's runtime

- **Ships** (and is the only thing in `package.json` `files`): `.claude-plugin/`, `skills/`,
  `agents/`, `scripts/`, `README.md`.
- **Runtime output, never committed**: everything the pipeline writes under `doc/ws-<slug>/`.
  `doc/`, `output/`, `logs/` are gitignored. Don't add real research output to git, and don't
  rely on any `doc/ws-*` folder existing — it's generated per run.

## The pipeline (skills are stages, in order)

```
[use-case-brief] → run → agent-domain-spec → grill-to-brief → design-a-screen ─┐
  (optional seed)  (research+  (research+core    (spec→         (brief→ASCII    │ (ASCII = human-align
                  Decision    loop → Agent       screen brief,  wireframe,      │  + COVERAGE GATE)
                  Gate)       Domain Spec on     a projection   coverage gate)  │
                              OpenClaw)          of the spec)                   │
                                                                               └→ brief-to-html
                                                 (brief + design system → self-contained HTML;
                                                  ASCII only cross-checks coverage) + HANDOFF.md
```
`agent-domain-spec` sits between `run` and `grill-to-brief`: for an Agent App you do NOT jump from a
core loop straight to a screen brief. It writes `Agent-Domain-Spec.md` — how the nghiệp-vụ is
agent-ised (objects, lifecycle, intents, signals, decision/approval policy, guardrails, learning
loop, background jobs) mapped onto **OpenClaw primitives** (skills · tools/connectors · memory ·
sessions/subagents · cron/heartbeat · approval surfaces · guardrails · workspace state). The screen
brief is then a *projection* of that spec. `copy-writer` is a sub-skill invoked by `grill-to-brief`
(microcopy), not a standalone stage. The pipeline **stops at the handoff package** — it deliberately
does NOT produce real backend code, an FE↔BE contract, or the real OpenClaw build. That's Phase-2,
a separate repo.

Command namespace: every skill is invoked as `/usecase-factory:<skill>` (e.g.
`/usecase-factory:run sale-ai-agent <idea + market>`).

## Skill authoring convention — thin router + playbook

Each skill follows the **same two-file shape**. Keep it when adding/editing skills:

- `skills/<name>/SKILL.md` — a **thin router**. Frontmatter (`name`, `description`, optionally
  `disable-model-invocation: true` for downstream-only skills) + a short contract: the
  command signature, required inputs/outputs, hard boundaries, and a mandatory **STEP 0: read
  `playbook.md` first**. The router only *names* steps.
- `skills/<name>/playbook.md` — the **full execution guide** (the N-step flow, agent specs,
  contracts, decision trees). All real logic lives here so it can be versioned without touching
  the trigger contract in the frontmatter `description`.

Why split: the `description` is the model's trigger contract — editing it changes when the skill
fires. Iterate on *behavior* in `playbook.md`, change *triggering* in `SKILL.md` frontmatter.

### Path references inside skills
Always reference bundled files via `${CLAUDE_PLUGIN_ROOT}` (resolves at install time), never
relative or absolute local paths:
- templates → `${CLAUDE_PLUGIN_ROOT}/skills/<name>/templates/`
- scripts → `${CLAUDE_PLUGIN_ROOT}/scripts/`
All skills operate from the per-run working dir `doc/ws-<slug>/`.

## Templates
Numbered, copied (not generated from scratch) by the owning skill, then filled:
`00`–`04` live in `skills/run/templates/` (dossier + 4 research docs); `05-screens-brief` in
`skills/grill-to-brief/templates/`; `06-agent-domain-spec` in `skills/agent-domain-spec/templates/`
(headings §0–§19 are a contract — see `validate-agent-domain-spec.sh`). If you change a template's
headings, **update the matching validator** — heading names are a contract (see below).

## Load-bearing rules (don't soften these when editing playbooks)

These are what make the output trustworthy. They're enforced in prose AND in `validate-dossier.sh`:

- **The internet is the research engine** — market size, competitors, pain, pricing come from
  real web search + fetched, cited URLs. Not from memory, not from a vault.
- **`brief.md` / any local note is a SEED, never a source** — it says what's already decided
  (core loop, scope); it supplies no market numbers.
- **The dossier (`_research/dossier.md`) is the single source of truth** — the 4 output docs may
  only state claims that have a row + source/label in the dossier. Headings 0–9 are a CONTRACT.
- **Layer every claim: must-cite / infer / assumption** — must-cite needs a URL (verify ≥2
  sources for important figures); assumptions (WTP, urgency, switching, integration, ROI) are
  labelled unverified, never laundered into fact.
- **Never fabricate numbers** — missing data becomes a GAP + a question to validate, not an
  invented stat.
- **The factory must render a verdict** — Proceed / Pivot / Narrow / Kill, never default blindly.

## Agents
`agents/*.md` are the spawnable workers, auto-discovered from `agents/`, **read-only by design**:
- **Research workers A–D** (`market-sizing`, `jtbd-pain`, `competitor-substitute`, `persona-wtp`) +
  the adversarial `decision-gate-reviewer` — used by `run` (fanned out in **one message with
  multiple Agent calls** so they run concurrently).
- **`domain-modeler-agent`** (extracts objects/lifecycle/intent/signals/decision-points from the
  research) + the adversarial **`agent-logic-reviewer`** (hunts over-automation, missing approval
  gates, ambiguous states, thin guardrails, trust risk, spec↔brief mismatch) — used by
  `agent-domain-spec`.

## Validate / test locally

```bash
# Run the plugin from a clone without installing:
claude --plugin-dir .

# Confirm skills + all 7 agents are discovered:
claude plugin details usecase-factory

# Validators (the skills run these automatically; run them by hand when editing contracts):
bash scripts/validate-dossier.sh           doc/ws-<slug>/_research/dossier.md  # heading + verdict + layering contract
bash scripts/coverage-check.sh             doc/ws-<slug> <slug>                # 4 docs exist + placeholder-free
bash scripts/validate-agent-domain-spec.sh doc/ws-<slug>/Agent-Domain-Spec.md  # §0–§19 + approval layering + OpenClaw map
# or: npm run validate:dossier / npm run validate:coverage / npm run validate:agent-domain-spec
```

If you change dossier/doc headings or the verdict vocabulary, update `scripts/validate-dossier.sh`
and `scripts/coverage-check.sh` to match — otherwise valid output will fail validation.

## Versioning & publishing

- Version lives in **three places** — keep them in sync when bumping: `package.json`,
  `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`.
- **Publishing is gated.** Do NOT run `npm publish` (publishes `@clawexperts/claude-usecase-factory`)
  unless the maintainer explicitly confirms.

## In-flight note
The 7 skills are `use-case-brief · run · agent-domain-spec · grill-to-brief · copy-writer ·
design-a-screen · brief-to-html`. **`agent-domain-spec`** (added 0.3.0) is the Agent-App stage
between `run` and `grill-to-brief`: research + core loop → `Agent-Domain-Spec.md` (the nghiệp-vụ
agent-ised onto OpenClaw primitives), so the screen brief becomes a *projection* of that spec
rather than a leap from core loop to UI. The HTML render stage was renamed `mockup-to-html` →
**`brief-to-html`** in
0.2.0 when its primary input flipped from the ASCII map to the screen brief (the ASCII anchored
the render to an ugly grid; the brief + design system produce a far better look). The ASCII
(`design-a-screen` → `mockups.md`) is now the human-alignment artifact + coverage gate, not the
render source. Always confirm the current skill set with `ls skills/` before assuming a stage's
name.
