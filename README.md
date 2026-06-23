# ClawExperts Use-Case Factory

> **ClawExperts packages expert workflows into installable AI-agent plugins.**

A Claude Code plugin (`usecase-factory`) that turns an **AI Agent use-case idea** into a research dossier, four research docs, and a clear **Proceed / Pivot / Narrow / Kill** decision.

It is the market-research-and-decision stage that sits *before* you design any screens. Given an idea plus a target market, it spawns parallel web-research worker agents, layers their findings (must-cite / infer / assumption) into a single dossier that becomes the source of truth, synthesizes four downstream-ready research docs, and then **renders a verdict** at a Decision Gate. It deliberately does **not** design screens, map jobs to UI, or build a screen-brief — those are downstream steps.

## What it produces

For a given `<slug>`, into `doc/ws-<slug>/`:

| File | What it is |
|---|---|
| `_research/dossier.md` | The single source of truth: agent-fit check, web sweep log, layered evidence table, evidence-strength, substitute/workaround map, assumptions/risks, and the **Decision Gate** verdict. |
| `Boi-Canh-Va-Van-De.md` | Context & Problem — the day-in-the-life and the core problem. |
| `MR-<slug>-Problem-Solution.md` | Jobs-to-be-Done + solution hypotheses + competitors + substitutes/workarounds. |
| `Target-User-<slug>.md` | The persona — the lens every later screen is judged through. |
| `MVP-Coreloop.md` | The value core loop, v0 scope, and the cut line. |
| **A verdict** | **Proceed / Pivot / Narrow / Kill**, with rationale, confidence, top evidence IDs, and the biggest unresolved risk. |

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
  agents/
    market-sizing-researcher.md         # worker A — market size & context
    jtbd-pain-researcher.md             # worker B — jobs-to-be-done & pain
    competitor-substitute-researcher.md # worker C — competitors + every substitute
    persona-wtp-researcher.md           # worker D — persona & willingness-to-pay
    decision-gate-reviewer.md           # adversarial reviewer of the verdict
  scripts/
    validate-dossier.sh        # checks the dossier heading contract
    coverage-check.sh          # checks the 4 output docs exist + are placeholder-free
```

## Test it locally

From the directory that contains the `usecase-factory/` folder:

```bash
claude --plugin-dir ./usecase-factory
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
bash usecase-factory/scripts/validate-dossier.sh doc/ws-<slug>/_research/dossier.md
bash usecase-factory/scripts/coverage-check.sh   doc/ws-<slug> <slug>
```

- `validate-dossier.sh` — confirms the dossier carries sections 0–9, an Evidence Table, and a Decision Gate verdict.
- `coverage-check.sh` — confirms the four output docs exist and have no leftover placeholders (`<placeholder>`, `TODO`, guidance comments, etc.).

## How research and evidence work

A few rules are load-bearing — they are what make the output trustworthy:

- **The internet is the research engine.** Market size, competitors, pain, and pricing come from real web search and fetched, cited sources — not from memory and not from a vault.
- **A `brief.md` or any local note is a seed, never a source.** It tells the factory what's already decided (core loop, scope) so the research doesn't contradict it; it does not supply market numbers.
- **The dossier is the source of truth.** The four output docs may only state claims that have a row and a source/label in the dossier.
- **Every claim is layered.** *Must-cite* claims (market size, pricing, traction, regulation, real pain quotes) need a URL and are verified across two or more independent sources where it matters. *Infer* claims are reasoned and labelled. *Assumptions* (willingness-to-pay, urgency, switching, integration, ROI) are labelled unverified — never laundered into fact.
- **Nothing is fabricated.** When the web can't answer something, it's recorded as a gap plus the question to validate by interview — not filled with an invented number.
- **The factory renders a verdict.** It ends at a Decision Gate and never defaults blindly. Unverified willingness-to-pay is normal at this stage and becomes the top risk to carry forward — not a reason to stall.

## Development status

- **v0.1.0** — local plugin MVP.
- **1 skill** (`run`) + **5 agents** (4 research workers + 1 adversarial decision-gate reviewer).
- Tested locally with `claude --plugin-dir ./usecase-factory` (skill + all 5 agents discovered via `claude plugin details`).
- **npm-ready but not published** — no package will be pushed unless the maintainer explicitly confirms.

## Publishing

The `package.json` publishes to npm as **`@clawexperts/claude-usecase-factory`**. Publishing is intentionally gated — only run this once the ClawExperts maintainer confirms:

```bash
npm publish --access public
```

The published tarball ships `.claude-plugin/`, `skills/`, `agents/`, `scripts/`, and this README. The same folder can also be distributed via a Claude plugin marketplace.

## License

MIT
