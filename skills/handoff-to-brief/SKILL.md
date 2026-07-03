---
name: handoff-to-brief
description: Turn an EXISTING product's design/handoff documentation — a reverse-engineered spec of a live app, an old PRD, a design-system export doc with a screen inventory — directly into a conformant screens-brief.md, skipping the discovery stages (run, agent-domain-spec, grill-to-brief) that exist to validate a NEW, undecided idea. Extracts each screen's purpose/must-show/actions+outcomes/states/copy and the design-system pointer straight from the source doc instead of interviewing field-by-field, but still surfaces and confirms every genuine gate decision the doc leaves open (⚠-flagged inconsistencies, live-vs-dead/orphaned scope, which screens ship in v0 vs defer, which file(s) hold the design tokens) rather than silently resolving them. Writes doc/ws-<slug>/screens-brief.md in the exact heading contract grill-to-brief produces, so /usecase-factory:design-a-screen (optional) and /usecase-factory:brief-to-html run unmodified afterward. Use when the user already has documentation of something that EXISTS (not an idea to validate) and wants a screen brief + HTML prototype from it. Triggers on "convert this design doc to a screen brief", "turn this handoff spec into a screens brief", "chuẩn hoá design doc thành screen brief", "đi thẳng từ design doc ra brief", "skip research, brief straight from existing docs", "/usecase-factory:handoff-to-brief".
disable-model-invocation: true
---

# Handoff to Brief — router

This skill is a **thin router**. All execution logic lives in `playbook.md` next to this file (kept separate so it can be versioned without touching the trigger contract).

## Where this sits in the pipeline

```
[EXISTING product's design/handoff doc]   (the decision is already made — nothing to validate)
        │
        ▼  /usecase-factory:handoff-to-brief   (this skill — REPLACES run + agent-domain-spec + grill-to-brief)
        ▼
   screens-brief.md ──▶ design-a-screen (ASCII, optional) ──▶ brief-to-html (HTML) ──▶ prototype
```

`handoff-to-brief` is an **alternate entry point**, not a stage inside the research pipeline. Use it INSTEAD of `run` → `agent-domain-spec` → `grill-to-brief` when a product's screens and behavior are already decided and documented — e.g. a reverse-engineered spec of a live app you're rebuilding, an old PRD, a design-system export doc with a per-screen breakdown. If the user is validating a NEW, undecided idea, send them to `/usecase-factory:run` instead: this skill does not research the market, does not render a Proceed/Pivot/Narrow/Kill verdict, and does not model agent nghiệp-vụ — it extracts a UI decision that already exists on paper.

## STEP 0 — read the playbook first (mandatory)

Before doing anything, **read `playbook.md`** in this skill's folder (`${CLAUDE_PLUGIN_ROOT}/skills/handoff-to-brief/playbook.md`) start to finish. It covers: what any handoff doc needs to yield (design system, screen inventory, per-screen intent, nav shape), the extract-then-confirm workflow, the screens-brief contract (shared with `grill-to-brief` — same template, same output file), how to carry forward the source doc's own [LIVE]/[DEAD]/⚠ markers instead of erasing them, and anti-patterns.

## Command contract (summary — full detail in the playbook)

```
/usecase-factory:handoff-to-brief <slug> <path to the handoff/design doc(s)>
```

- Read the handoff doc(s) fully before asking anything.
- **Extract, don't interview** — every field a screen needs (purpose, must-show, actions+outcomes, states, copy) should already be answerable from the doc. Only stop and ask about genuine gaps: an unresolved ⚠ the doc itself flags, ambiguous live-vs-dead scope, which file(s) hold the design tokens vs component shapes, and the v0/deferred cut line if the doc doesn't already state one (e.g. a "shipped defaults" section).
- Write `doc/ws-<slug>/screens-brief.md` using the **same template as `grill-to-brief`** (`${CLAUDE_PLUGIN_ROOT}/skills/grill-to-brief/templates/05-screens-brief.template.md`) — same headings, so `design-a-screen` and `brief-to-html` need zero changes.
- Also write `doc/ws-<slug>/00-START-HERE.md`, noting plainly that this workspace skipped research/domain-spec because the product decision predates the handoff doc, and naming the doc as the source of truth.

## Boundaries

- Does NOT do market research, does NOT render a Decision Gate verdict, does NOT write `Agent-Domain-Spec.md` or `01-PRODUCT-MAP.md` — those exist to validate undecided ideas. If the user actually wants that, redirect to `/usecase-factory:run`.
- Does NOT draw ASCII — that's the optional `/usecase-factory:design-a-screen` coverage check, unmodified.
- Does NOT render HTML — that's `/usecase-factory:brief-to-html`, unmodified.
- Does NOT invent screens, states, or copy the source doc doesn't contain — a gap in the doc is a question to the user, never an invented answer.
- Does NOT silently pick scope on a large doc — which screens are v0 vs deferred is a gate decision, always surfaced and confirmed, same as in `grill-to-brief`.
- Does NOT launder the doc's own flagged uncertainty into confirmed fact — a `[DEAD]`, `⚠ FLAG`, or "needs follow-up" marker in the source carries into the brief as-is.
