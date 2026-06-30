# ClawExperts Use-Case Factory

> **ClawExperts packages expert workflows into installable AI-agent plugins.**

A Claude Code plugin (`usecase-factory`) that takes an **AI Agent use-case idea** all the way from market research to a self-contained, reviewable screen prototype — with a clear **Proceed / Pivot / Narrow / Kill** decision gating the way.

Give it an idea plus a target market and it runs the full pipeline: spawn parallel web-research worker agents → layer their findings (must-cite / infer / assumption) into a single dossier that becomes the source of truth → synthesize four research docs → **render a verdict** at a Decision Gate → (on Proceed) design the **Agent Domain Spec** — how the nghiệp-vụ gets agent-ised and runs on OpenClaw primitives — → grill that into a justified screen brief → draw ASCII wireframes → render a self-contained HTML prototype → emit a handoff package. It stops short of real backend code and an FE↔BE contract — that is Phase-2 FE, a later step.

```
Use-case idea → Research dossier → MVP core loop → Agent Domain Spec → Screen brief → ASCII → HTML → OpenClaw implementation
   (seed)         (run + Decision Gate)            (agent-domain-spec)   (grill-to-brief) (design-a-screen) (brief-to-html)  (Phase-2, outside the plugin)
```

For **Agent Apps** the **Agent Domain Spec** stage is what stops the pipeline from jumping straight from a core loop to UI: it specs how the business is agent-ised (which objects the agent watches, their lifecycle, how it classifies intent, when it acts vs asks vs stays silent, which tools it may call, which actions need human approval, which guardrails block risk, what user feedback updates) and maps each part onto OpenClaw primitives — *before* any screen is drawn. The screen brief is then a **projection** of that spec.

The pipeline is staged, so you can also stop at any gate (research-only, decision-only, domain-spec-only, or screen-brief-only) and hand off from there.

## What the research stage produces

The research-and-decision stage (`/usecase-factory:run`) writes, for a given `<slug>`, into `doc/ws-<slug>/`:

| File | What it is |
|---|---|
| `_research/dossier.md` | The single source of truth: agent-fit check, web sweep log, layered evidence table, evidence-strength, substitute/workaround map, assumptions/risks, and the **Decision Gate** verdict. |
| `Boi-Canh-Va-Van-De.md` | Context & Problem — the day-in-the-life and the core problem. |
| `MR-<slug>-Problem-Solution.md` | Jobs-to-be-Done + solution hypotheses + competitors + substitutes/workarounds. |
| `Target-User-<slug>.md` | The persona — the lens every later screen is judged through. |
| `MVP-Coreloop.md` | The value core loop, v0 scope, and the cut line. |
| **A verdict** | **Proceed / Pivot / Narrow / Kill**, with rationale, confidence, top evidence IDs, and the biggest unresolved risk. |

## Final output — the handoff package

When the full pipeline runs through to rendering, the deliverable is a self-explaining **handoff package** in `doc/ws-<slug>/`, not a loose pile of files:

| Artifact | Role | Receiver |
|---|---|---|
| **`mockups.html` + `mockups.data.js`** | headline viewable prototype — **an inseparable pair** | non-tech review · future web-app prototype |
| `Agent-Domain-Spec.md` | how the nghiệp-vụ is agent-ised: objects, lifecycle, intents, signals, decision/approval policy, guardrails, learning loop, background jobs, + the OpenClaw implementation map | Phase-2 dev · OpenClaw build |
| `screens-brief.md` | the justified screen set (each screen traces to one job + one slice of the domain spec) + flows + coverage | spec |
| `mockups.md` | ASCII map — the coverage GATE | Phase-2 FE dev |
| `_research/dossier.md` + the 4 research docs | evidence + the Decision Gate verdict | "why it's worth building" |
| `HANDOFF.md` | the index that ties it together: verdict, read-order, scope boundaries, next step per receiver | read FIRST |

> ⚠ **`mockups.html` and `mockups.data.js` travel together.** The `.html` loads the data via `<script src="mockups.data.js">` (relative path), so both must stay in the same folder — emailing/zipping/uploading the `.html` alone renders blank. "Self-contained" means self-contained **as a pair**. `HANDOFF.md` (emitted by `brief-to-html` as the terminal step) makes the whole folder pick-up-able without questions.

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
      playbook.md              # the full 8-step execution guide (read first)
      templates/
        00-research-dossier.template.md
        01-context-problem.template.md
        02-mr-problem-solution.template.md
        03-target-user.template.md
        04-mvp-coreloop.template.md
    agent-domain-spec/         # research + core loop → Agent-Domain-Spec.md (how the nghiệp-vụ is agent-ised on OpenClaw)
      SKILL.md                 # thin router → the command /usecase-factory:agent-domain-spec
      playbook.md              # the full 7-step execution guide (read first)
      templates/
        06-agent-domain-spec.template.md
    grill-to-brief/
      SKILL.md                 # thin router → the command /grill-to-brief
      playbook.md              # the full 7-step execution guide (read first)
      templates/
        05-screens-brief.template.md
    copy-writer/               # UX microcopy — invoked by grill-to-brief step 7
      SKILL.md
    design-a-screen/           # screens-brief.md → ASCII wireframes
      SKILL.md
    brief-to-html/             # screen brief + design system → static HTML viewer + handoff index
      SKILL.md
      assets/                  # template.html + example.data.js + HANDOFF.template.md
    use-case-brief/            # OPTIONAL upstream — rough idea → validated brief.md seed
      SKILL.md
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
    coverage-check.sh               # checks the 4 output docs exist + are placeholder-free
    validate-agent-domain-spec.sh   # checks the Agent Domain Spec heading contract (§0–§19)
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
bash scripts/validate-dossier.sh            doc/ws-<slug>/_research/dossier.md
bash scripts/coverage-check.sh              doc/ws-<slug> <slug>
bash scripts/validate-agent-domain-spec.sh  doc/ws-<slug>/Agent-Domain-Spec.md
```

- `validate-dossier.sh` — confirms the dossier carries sections 0–9, an Evidence Table, and a Decision Gate verdict.
- `coverage-check.sh` — confirms the four output docs exist and have no leftover placeholders (`<placeholder>`, `TODO`, guidance comments, etc.).
- `validate-agent-domain-spec.sh` — confirms the Agent Domain Spec carries all sections §0–§19, an approval classification (auto / cần duyệt / cấm), guardrails, and the OpenClaw implementation map.

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

- **v0.3.0** — local plugin MVP.
- **7 skills** — the pipeline `[use-case-brief] → run → agent-domain-spec → grill-to-brief → design-a-screen → brief-to-html`, plus `copy-writer` (microcopy, invoked by grill-to-brief), + **7 agents** (4 research workers + 1 adversarial decision-gate reviewer + `domain-modeler-agent` and the adversarial `agent-logic-reviewer` for the Agent Domain Spec). `agent-domain-spec` sits between `run` and `grill-to-brief`: it turns the research + core loop into `Agent-Domain-Spec.md` (how the nghiệp-vụ is agent-ised on OpenClaw) so the pipeline doesn't jump from a core loop straight to UI. `design-a-screen` (ASCII) and `brief-to-html` (HTML) both branch off the screen brief: the ASCII is the human-alignment artifact + coverage gate, while `brief-to-html` renders from the brief + [design system](#design-system) and only cross-checks coverage against the ASCII. `use-case-brief` is an **optional** upstream (it only produces a seed `brief.md`; `run` works from a bare idea too). The pipeline terminates at the self-contained handoff package; the live interactive prototype + the real OpenClaw build (which need a dev environment) are intentionally left to the dev repo.
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
