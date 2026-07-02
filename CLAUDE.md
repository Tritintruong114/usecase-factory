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
  (optional seed)  (research+  (research+core    (spec→         (brief→ASCII    │ (ASCII = coverage
                  Decision    loop → Agent       screen brief,  wireframe,      │  gate, filed in
                  Gate)       Domain Spec on     a projection   appendix/)      │  appendix/)
                              OpenClaw)          of the spec)                   │
                                                                               └→ brief-to-html
                                                 (brief + design system → self-contained HTML;
                                                  ASCII only cross-checks coverage;
                                                  finalizes 00-START-HERE.md)
```
Every stage keeps a single **Decision Pack** current in `doc/ws-<slug>/`: `00-START-HERE.md`
(verdict + summary + role-based routing, written by `run`, updated by every later stage) and
`01-PRODUCT-MAP.md` (the product decision — pain → user → workflow → agent job → business value →
moat — written by `agent-domain-spec`) sit at the workspace root next to the builder specs
(`Agent-Domain-Spec.md`, `screens-brief.md`, `mockups.{html,data.js}`). The dossier, the 4 research
docs, and the ASCII map are evidence, not decisions — they live in `appendix/`, out of the way.
There is no separate `HANDOFF.md` — `00-START-HERE.md` has carried that job since 1.0.0.

`agent-domain-spec` sits between `run` and `grill-to-brief`: for an Agent App you do NOT jump from a
core loop straight to a screen brief. It writes `Agent-Domain-Spec.md` — how the nghiệp-vụ is
agent-ised (objects, lifecycle, intents, signals, decision/approval policy, guardrails, learning
loop, background jobs) mapped onto **OpenClaw primitives** (skills · tools/connectors · memory ·
sessions/subagents · cron/heartbeat · approval surfaces · guardrails · workspace state). The screen
brief is then a *projection* of that spec. `copy-writer` is a sub-skill invoked by `grill-to-brief`
(microcopy), not a standalone stage. The pipeline **stops at the Decision Pack** — it deliberately
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
Numbered, copied (not generated from scratch) by the owning skill, then filled. The number is a
global add-order sequence across the whole plugin, not per-directory — always check the highest
number in use across `skills/*/templates/` before adding one, so two skills never claim the same
number in different folders.

- `00`–`04` live in `skills/run/templates/` — dossier + 4 research docs, written into
  `doc/ws-<slug>/appendix/`.
- `05-screens-brief` lives in `skills/grill-to-brief/templates/` → `screens-brief.md`.
- `06-agent-domain-spec` lives in `skills/agent-domain-spec/templates/` → `Agent-Domain-Spec.md`
  (headings §0–§19 are a contract — see `validate-agent-domain-spec.sh`).
- `07-product-map` lives in `skills/agent-domain-spec/templates/` → `01-PRODUCT-MAP.md`, the
  product decision map (Decision Pack).
- `08-start-here` lives in `skills/run/templates/` → `00-START-HERE.md`, the Decision Pack entry
  point — written by `run`, then updated (not re-created) by `agent-domain-spec`, `grill-to-brief`,
  and `brief-to-html` as each stage's artifacts become available.

If you change a template's headings, **update the matching validator** — heading names are a
contract (see below).

## Load-bearing rules (don't soften these when editing playbooks)

These are what make the output trustworthy. They're enforced in prose AND in `validate-dossier.sh`:

- **The internet is the research engine** — market size, competitors, pain, pricing come from
  real web search + fetched, cited URLs. Not from memory, not from a vault.
- **`brief.md` / any local note is a SEED, never a source** — it says what's already decided
  (core loop, scope); it supplies no market numbers.
- **The dossier (`appendix/dossier.md`) is the single source of truth** — the 4 output docs may
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
bash scripts/validate-dossier.sh           doc/ws-<slug>/appendix/dossier.md   # heading + verdict + layering contract
bash scripts/coverage-check.sh             doc/ws-<slug> <slug>                # 00-START-HERE.md exists + 4 appendix docs placeholder-free
bash scripts/validate-agent-domain-spec.sh doc/ws-<slug>/Agent-Domain-Spec.md  # §0–§19 + approval layering + OpenClaw map + 01-PRODUCT-MAP.md sibling
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
(`design-a-screen` → `appendix/mockups.md`) is a coverage-gate artifact, not the render source.

**1.0.0** restructured the *output shape* into a Decision Pack (breaking change to output paths —
see `CONTRIBUTING.md`'s versioning table): `run` now also writes `00-START-HERE.md` (verdict +
summary + role-based routing, kept current by every later stage) and files the dossier + 4 research
docs under `appendix/` instead of the workspace root / `_research/`; `agent-domain-spec` also
writes `01-PRODUCT-MAP.md` (the one-page product decision); `design-a-screen`'s `mockups.md` moved
into `appendix/`; and the old terminal-only `HANDOFF.md` was retired — `brief-to-html`'s last step
now finalizes `00-START-HERE.md` instead of emitting a separate file. Always confirm the current
skill set with `ls skills/` and the current output shape with `ls skills/*/templates/` before
assuming a stage's name or a file's path.
