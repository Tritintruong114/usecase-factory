---
name: run-openclaw
description: >
  Run the Use-Case Factory pipeline entirely inside OpenClaw agent runtime.
  No Claude CLI, no slash commands. Uses Tavily search, exec, sessions_spawn,
  and file I/O — all native OpenClaw tools. Designed to survive timeouts and
  parallel research failures without crashing the pipeline.
---

# run-openclaw — Use-Case Factory for OpenClaw Runtime

## Why this exists

The original `skills/run/` and `skills/grill-to-brief/` etc. are built for
**Claude Desktop** — they assume `claude` CLI, slash command `/usecase-factory:run`,
and Claude-style sub-agent spawning.

This skill (`run-openclaw`) is the **OpenClaw-native port**. It uses:
- `tool_search` (Tavily) for web research
- `exec` for file ops, validation scripts, git
- `sessions_spawn` for parallel research (non-blocking, timeout-resilient)
- File I/O for output artifacts (same structure as Claude version)
- `read` for templates and agent specs
- `process` with poll for long-running research sessions

The output layout is **identical** to the Claude pipeline so they can share
`doc/ws-<slug>/` workspace and downstream tools (brief-to-html, to-prototype).

## Reliability promise

| Risk | Mitigation |
|------|-----------|
| Tavily search timeout (15s) | Retry once with fallback to `web_search`; if still fail, record GAP in dossier |
| `sessions_spawn` research timeout | Set generous `completionTimeout` (120s); poll with `process`; if research fails, use agent's own reasoning + mark as "inferred" |
| `exec` validation script fails | Never blocks pipeline; report warning, continue |
| Tool call limits | Break pipeline into atomic steps; state saved to file after each step |
| Agent forced reset mid-pipeline | State file in `doc/ws-<slug>/.run-state.json` = resume-able |

## Input

```
Say: "Chạy pipeline cho ý tưởng X"
# or:
"Chạy pipeline ws-agent-email" (resume existing slug)
```

Required before starting research:
1. Use-case idea (what is it)
2. Target market / geography
3. Target user / buyer hypothesis
4. Problem / pain hypothesis

If any missing — ask max 2 questions, then proceed with assumptions (label them).

## Pipeline steps (atomic, resume-able)

Each step writes to `.run-state.json` and `doc/ws-<slug>/`. If interrupted,
re-run reads state and skips completed steps.

```
Step 1: Resolve slug & create workspace
  → doc/ws-<slug>/ + appendix/
  → Write brief.md from idea

Step 2: Agent Fit Check
  → Score 6 axes (persistence, tool-use, context, memory, human-loop, autonomy)
  → If weak fit → flag but continue

Step 3: Parallel research (sessions_spawn, 4 workers)
  → 4 sessions run via sessions_spawn with 120s timeout
  → Each writes to doc/ws-<slug>/appendix/worker-{A,B,C,D}.md
  → If session times out → agent self-researches via Tavily, labels "inferred"

Step 4: Build dossier
  → Read 4 worker reports + Tavily results
  → Write doc/ws-<slug>/appendix/dossier.md (template 00)
  → Every claim: must-cite / infer / assumption

Step 5: Synthesize 4 outputs
  → Fill templates 01-04 from dossier evidence only
  → Write into appendix/

Step 6: Coverage pre-check
  → exec scripts/coverage-check.sh (non-blocking)
  → Report gaps

Step 7: Decision Gate
  → Proceed / Pivot / Narrow / Kill
  → Write to dossier.md §8
  → Optionally read decision-gate-reviewer.md as adversarial check

Step 8: Write 00-START-HERE.md
  → Verdict + summary + role-based routing

Step 9: Handoff
  → Only Proceed → prep for brief-to-html / to-prototype downstream
  → Pivot/Narrow/Kill → stop, present decision to user
```

## Output contract (same as Claude version)

```
doc/ws-<slug>/
├── 00-START-HERE.md
├── brief.md
├── .run-state.json         ← Resume state (OpenClaw-specific)
└── appendix/
    ├── dossier.md          ← Source of truth, §8 Decision Gate required
    ├── Boi-Canh-Va-Van-De.md
    ├── MR-<slug>-Problem-Solution.md
    ├── Target-User-<slug>.md
    ├── MVP-Coreloop.md
    ├── worker-A-market-sizing.md
    ├── worker-B-jtbd-pain.md
    ├── worker-C-competitor-substitute.md
    └── worker-D-persona-wtp.md
```

## State management

`.run-state.json` tracks:
```json
{
  "slug": "ws-agent-email",
  "steps": {
    "resolve": "done",
    "fit-check": "done",
    "research": "done",
    "dossier": "done",
    "synthesis": "done",
    "coverage": "done",
    "decision": "done",
    "start-here": "done"
  },
  "decision": "Proceed",
  "verdict": "...",
  "handoff": true
}
```

## Hard rules (same as Claude, critical)

1. **Internet is the research engine.** Use Tavily search. Never make up numbers.
2. **brief.md is a SEED only** — never a source for market data.
3. **Dossier is source of truth.** Outputs may only state claims in the dossier.
4. **Layer every claim:** `(must-cite)`, `(infer)`, `(assumption)`.
5. **Never fabricate numbers.** Missing → GAP + assumption.
6. **Must render a verdict.** Proceed/Pivot/Narrow/Kill. No default.
7. **Do NOT draw screens** — that's downstream (brief-to-html / to-prototype).

## Templates

Copied from `skills/run/templates/` (Claude version). Identical content.
Keep them in sync.

## Validation (optional)

```bash
# Run from repo root
bash scripts/validate-dossier.sh doc/ws-<slug>/appendix/dossier.md
bash scripts/coverage-check.sh doc/ws-<slug> <slug>
```

If either fails → report but do not block.
