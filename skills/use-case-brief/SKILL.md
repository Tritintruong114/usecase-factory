---
name: use-case-brief
description: Turn a rough use-case idea into a validated Use-Case Brief. Interview to fill the idea essence (one-liner, business/nghiệp vụ, target audience, problem, core loop with its pulls), pressure-test distinctness + moat + viability against existing workspaces, and write doc/ws-<slug>/brief.md. The brief is an OPTIONAL seed that /usecase-factory:run consumes if present (run works from a bare idea too). Use when shaping or validating a new use-case idea before building. Invoke as /usecase-factory:use-case-brief.
disable-model-invocation: true
---

# Use-Case Brief

Turn a rough idea the user already has into a **validated Use-Case Brief** — an **optional seed** that `/usecase-factory:run` reads if it's present (run also works from a bare idea or a short interview, so this step is never required). You sharpen and pressure-test; you do NOT brainstorm ideas from scratch (the user always brings the idea).

This skill OWNS the brief contract below — it is the single source of truth for `brief.md`.

## Workflow

1. **Take the idea** — the user describes it (chat or arg). Don't invent the product; sharpen what they bring.
2. **Fill Layer 1 (essence)** by interview — one field at a time, recommend an answer, explore `use-case/ws-*/` and `CONTEXT.md` before asking.
3. **Pressure-test Layer 2 (gate)** — run the three checks. If any fails hard (duplicate of an existing ws, no moat, not viable), say so plainly and stop before the user sinks the whole build flow into it.
4. **Write** `doc/ws-<slug>/brief.md` with both layers. This is the seed artifact; `/usecase-factory:run` reads it (if present) before research, and a later PRD/build step can expand it further.

## The Brief contract

```
─ LAYER 1: IDEA ESSENCE (what the idea IS) ───────────────────
slug:            ws-<kebab>           (provisional — refine after grill)
one-liner:       what the agent DOES (1 line)
nghiệp vụ:       the business / workflow the agent automates  → drives entities + ubiquitous language (CONTEXT.md)
target audience: the End-User — role, expertise, how often they show up
problem:         what pain, why it hurts
CORE LOOP:       closed cycle + pull(s) + reward — backbone fidelity, ~3 lines (see below)

─ LAYER 2: VALIDATION GATE (a test, NOT a definition) ────────
distinct?:       what is genuinely different vs existing ws (survey use-case/ws-*)
moat?:           why a cloned bundle is a dead shell (minted key, accumulated data, lock-in)
viable?:         worth building
```

### Writing CORE LOOP (the hardest, most valuable field)

The core loop is the **backbone** — the repeating cycle that gives the product its habit. UI and notifications are NOT in the loop; they are *derived* from it later (grill + wireframe decide how each loop step and pull gets surfaced). The loop is the reason a given screen exists.

A good core loop has:

- **A closed cycle, not a linear list.** The last step must feed back to the first. If it just ends, it isn't a loop.
- **Named pull(s)** — what actually brings the user back. A loop with no pull is dead. Pull flavors to look for:
  - *real-time / urgent* — an event the user cannot ignore (e.g. the agent escalates a message it can't handle → human takes over now). Usually the strongest pull, and often the highest-quality signal feeding a later step.
  - *scheduled* — a recurring "here's what needs you" (e.g. a nightly batch → "N items waiting" in the morning).
  - *positive* — a reason to look on a good day too (trend up, wins) so the habit survives quiet days. Good to have, lower priority than the first two.
- **A reward that compounds** — each turn of the loop should visibly pay off (and ideally trend upward), pulling the user back.

Keep it to ~3 lines at brief fidelity. Detail — classifying pulls, friction-reducers (propose → human review+edit), substrate splits, the surfacing mechanism — is what a later grill/PRD step adds on top. Don't pre-grill it here.

Worked example (ws-sales-agent-multi-channel, at brief fidelity):
```
CORE LOOP: MEASURE → SPOT → FIX(agent proposes → human reviews+edits) → VERIFY → ↺
  pulls:  HITL escalation (urgent) · nightly batch "N to review" (daily) · trend↑ (secondary)
  reward: agent visibly improves + verify is instant + trend compounds
```

## Anti-patterns

- Don't brainstorm ideas the user didn't bring — this is shape + validate, not generate.
- Don't let CORE LOOP be a linear checklist — force the cycle closed and name a pull.
- Don't bake UI/notifications into the loop — those are derived downstream.
- Don't skip the Layer 2 gate — a duplicate-of-existing-ws or moat-less idea should be caught here, not after a full build.
- Don't over-grill the brief — it is a seed; a later grill/PRD step does the deep work.
