---
name: brief-to-prototype-spec
description: Bridge a usecase-factory Decision Pack into an external OpenClaw build pipeline (toc-use-cases' design-to-renderer) by converting Agent-Domain-Spec.md + screens-brief.md into a doc/ws-<slug>/prototype-spec.md shaped exactly like the prototype-spec.md that design-to-renderer's Phase 0 expects as locked-design input. Runs in two modes — Mode A (spec-only, always available) infers screen inventory/state machine/interaction notes from screens-brief.md + appendix/mockups.md and fills the data contract from Agent-Domain-Spec.md's core objects/lifecycle/tool policy; Mode B (if /usecase-factory:to-prototype was run) extracts the same sections mechanically from the real new-design/src/workspaces/<ws>/ code and cross-checks the data contract against Agent-Domain-Spec.md instead of guessing from fixtures.js. Every non-mechanical field that can't be traced to a source is flagged <<DEFER: grill>>, never invented. Use only for teams also running the internal toc-use-cases + use-case-renderers pipeline and wanting to hand off a Decision Pack without re-typing it into prototype-spec.md by hand. Triggers on "export to renderer", "bridge to design-to-renderer", "turn the brief into a prototype spec", "feed toc-use-cases", "/usecase-factory:brief-to-prototype-spec".
disable-model-invocation: true
---

# Brief to Prototype Spec — router

This skill is a **thin router**. All execution logic lives in `playbook.md` next to this file (kept
separate so it can be versioned without touching the trigger contract).

## Where this sits

```
Agent-Domain-Spec.md ──┐
                        ├──▶ /usecase-factory:brief-to-prototype-spec ──▶ doc/ws-<slug>/prototype-spec.md
screens-brief.md ───────┤        (+ appendix/mockups.md, + optional             │
                        │         new-design/src/workspaces/<ws>/ if            ▼
appendix/mockups.md ────┘         /usecase-factory:to-prototype ran)   [external: toc-use-cases'
                                                                          /design-to-renderer Phase 0]
```

This is a **downstream-only bridge**, not a pipeline stage every user needs. It exists for teams
that ALSO run the internal `toc-use-cases` + `use-case-renderers` pipeline (gitlab.firegroup.io,
private) and want to graduate a Decision Pack into that pipeline's `design-to-renderer` skill
without hand-transcribing `Agent-Domain-Spec.md`/`screens-brief.md` into a `prototype-spec.md`.
It never reads from or writes to those external repos — it only shapes THIS repo's own output to
match their input contract. If you don't use `toc-use-cases`, ignore this skill entirely; nothing
else in the pipeline depends on it.

## STEP 0 — read the playbook first (mandatory)

Before doing anything, **read `playbook.md`** in this skill's folder
(`${CLAUDE_PLUGIN_ROOT}/skills/brief-to-prototype-spec/playbook.md`) start to finish. It covers:
the Mode A / Mode B decision, the exact section-by-section source mapping, the `<<DEFER: grill>>`
marker convention, the `appendix/mockups.md` vs root `mockups.md` path-handoff note, and
anti-patterns.

## Command contract (summary — full detail in the playbook)

```
/usecase-factory:brief-to-prototype-spec <slug>
```

- **Required inputs:** `doc/ws-<slug>/Agent-Domain-Spec.md` + `doc/ws-<slug>/screens-brief.md` +
  `doc/ws-<slug>/appendix/mockups.md`. STOP and point the user at the missing upstream skill
  (`agent-domain-spec`, `grill-to-brief`, or `design-a-screen`) if any is absent.
- **Optional input:** `new-design/src/workspaces/<ws>/` (from `/usecase-factory:to-prototype`) — if
  present, switches to Mode B for richer extraction.
- Write `doc/ws-<slug>/prototype-spec.md` using
  `${CLAUDE_PLUGIN_ROOT}/skills/brief-to-prototype-spec/templates/09-prototype-spec.template.md`.
- Tell the user explicitly, as the last step: their `design-to-renderer` expects
  `doc/ws-<name>/mockups.md` at the workspace root, not nested under `appendix/` — carry
  `appendix/mockups.md` alongside `prototype-spec.md` when handing the workspace off.

## Boundaries

- Does NOT touch, clone, or require `toc-use-cases`/`use-case-renderers` to exist — output-shape
  conformance only.
- Does NOT invent a data contract, `sessionKey`-equivalent, or state-transition trigger that isn't
  traceable to `Agent-Domain-Spec.md`/`screens-brief.md` (or real prototype code in Mode B) — every
  such gap is `<<DEFER: grill>>`, collected in the output's "Open questions" section.
- Does NOT run `design-a-screen`, `to-prototype`, or any other upstream skill on the user's behalf —
  it only reads what already exists and stops if a required input is missing.
- Does NOT auto-fire — explicit invocation only, like `handoff-to-brief`/`design-a-screen`/
  `brief-to-html`/`to-prototype`.
