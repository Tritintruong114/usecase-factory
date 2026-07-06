# run-openclaw — Use-Case Factory for OpenClaw Agent Runtime

## Problem

The original Use-Case Factory pipeline (`skills/run/`, `skills/grill-to-brief/`, etc.)
is built for **Claude Desktop** — Claude CLI, slash commands, sub-agent spawning.
It cannot run inside an OpenClaw agent.

## Solution

`run-openclaw` is a **native OpenClaw port** of the same pipeline.
Same output structure, same evidence rules, same Decision Gate —
but using OpenClaw tools instead of Claude:

| Claude feature | OpenClaw equivalent |
|---------------|-------------------|
| `claude` CLI + slash command | `tool_search` (Tavily) + `exec` + `sessions_spawn` |
| Sub-agent spawning | `sessions_spawn` with parallel worker sessions |
| Web research (Claude MCP) | Tavily search via `tool_search` |
| File I/O | `read` / `exec` (cat/write) |
| Agent specs in `agents/` | Read via `read` tool, follow as instructions |

## Reliability

- Timeout-resistant: each step saves state; resume on restart
- Research failures → graceful fallback (inferred + labelled)
- Validation scripts never block pipeline
- `sessions_spawn` with generous timeout + poll fallback

## How to use

```
To run: tell the agent "Chạy pipeline cho ý tưởng <X>"
The agent will read this SKILL.md and follow the 9-step pipeline.
```

## Output

All outputs go to `doc/ws-<slug>/` — same layout as the Claude pipeline.
This means both Claude and OpenClaw can work on the same use-case workspace.

## Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Agent trigger + step-by-step instructions |
| `templates/` | Copy of Claude templates (keep in sync) |

## Syncing with Claude pipeline

- Templates are copied from `skills/run/templates/`
- Agent specs are shared from `agents/`
- Decision rules come from `skills/run/playbook.md`
- Output contract is identical
