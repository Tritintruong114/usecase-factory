---
name: run
description: Turn an AI Agent use-case idea (+ market) into a research dossier, four research docs, and a Proceed/Pivot/Narrow/Kill decision. Spawns parallel web-research worker agents, layers evidence (must-cite/infer/assumption) into a single dossier (source of truth), synthesizes four grill-input docs, then RENDERS A VERDICT at a Decision Gate. Does NOT design screens, map JTBD to UI, or build a screen-brief. Invoke as /usecase-factory:run <slug> [idea + market].
---

# Use-Case Factory — orchestrator router

This skill is a **thin router**. All execution logic lives in `playbook.md` next to this file (kept separate so it can be versioned and improved without touching the trigger contract).

## STEP 0 — read the playbook first (mandatory)

Before doing anything else, **read `playbook.md`** in this skill's directory (`${CLAUDE_PLUGIN_ROOT}/skills/run/playbook.md`) end to end. It is the official execution guide: the 8-step flow, the worker-agent specs, the evidence-class rules, the dossier contract, the Decision Gate decision tree, and the handoff rules. Do not run from this router alone — the router only names the steps; the playbook defines how to do them.

Templates to copy live in `${CLAUDE_PLUGIN_ROOT}/skills/run/templates/` (`00-research-dossier` … `04-mvp-coreloop`, plus `08-start-here` for the Decision Pack entry point).
Validation scripts live in `${CLAUDE_PLUGIN_ROOT}/scripts/` (`validate-dossier.sh`, `coverage-check.sh`).

## Input

```
/usecase-factory:run <slug> [use-case idea + target market]
```

`$ARGUMENTS` = `<slug> [idea + market]`.

- First token = `<slug>` → keys the output path `doc/ws-<slug>/`.
- Rest = the idea + market seed.
- Missing idea → look for `doc/ws-<slug>/brief.md`. Still not enough → interview the user briefly, **max 5 questions, one at a time** (what is it · for whom · pain · which market · who pays).
- **Do NOT start research** until all four are present: (1) use-case idea, (2) target market, (3) target user/buyer hypothesis, (4) problem/pain hypothesis.

## The flow (each step is defined in the playbook)

1. **Resolve + read** — resolve `<slug>` → `doc/ws-<slug>/`, create `appendix/`, read `brief.md` seed + any prior research. This is setup, NOT research. Identify the gap.
2. **Agent Fit Check** — early filter: why must this be an AI Agent (not plain SaaS / automation / chatbot / human VA / manual)? Score 6 axes. Weak fit raises a flag; research still runs to prove/disprove.
3. **Spawn parallel research agents** — fan out in ONE message, multiple Agent calls. Use the bundled worker agents (market-sizing-researcher, jtbd-pain-researcher, competitor-substitute-researcher, persona-wtp-researcher). Each runs a real web deep-research pass and returns a structured report.
4. **Build the dossier** — assemble all worker reports into `appendix/dossier.md` (template `00`). Headings 0–9 are a CONTRACT. The dossier is the SINGLE source of truth.
5. **Synthesize 4 output docs** — copy templates `01`–`04`, fill ONLY with evidence (+ URL/label) present in the dossier. Write into `appendix/`.
6. **Coverage pre-check** — self-run the grill-gate checklist; report results, do not add screens.
7. **Decision Gate** — pick exactly ONE: Proceed / Pivot / Narrow / Kill, with rationale, confidence, top evidence IDs, biggest risk. Optionally consult the bundled `decision-gate-reviewer` agent as an adversarial check.
8. **Write `00-START-HERE.md`** — the Decision Pack entry point (template `08`): verdict, a 5–10 line summary, why, and role-based routing. This is the file a reader opens first, at whatever gate the run stops.
9. **Handoff** — list outputs + verdict. Only Proceed hands off downstream; Pivot/Narrow/Kill stops and presents the decision.

## Required outputs (write into `doc/ws-<slug>/`)

The command is NOT done until all of these exist:

- `doc/ws-<slug>/00-START-HERE.md` — verdict + summary + why + role-based routing (product / builder / appendix)
- `doc/ws-<slug>/appendix/dossier.md` — with a filled **Decision Gate** (§8) and **Evidence Table** (§3)
- `doc/ws-<slug>/appendix/Boi-Canh-Va-Van-De.md`
- `doc/ws-<slug>/appendix/MR-<slug>-Problem-Solution.md`
- `doc/ws-<slug>/appendix/Target-User-<slug>.md`
- `doc/ws-<slug>/appendix/MVP-Coreloop.md`
- A Decision Gate verdict: **Proceed / Pivot / Narrow / Kill**

Verify before finishing:

```
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-dossier.sh doc/ws-<slug>/appendix/dossier.md
bash ${CLAUDE_PLUGIN_ROOT}/scripts/coverage-check.sh doc/ws-<slug> <slug>
```

## Hard rules

- **The internet is the research engine.** Market size, competitors, pain, pricing come from real web search + fetch + cited URLs.
- **`brief.md` / any vault note is a SEED only, never a research source.** It tells you what is already decided (core loop, scope) so you don't contradict it — it does not supply market numbers.
- **The dossier is the source of truth.** Output docs may only state claims that have a row + source/label in the dossier.
- **Layer every claim explicitly: must-cite / infer / assumption.** Must-cite needs a URL (verify ≥2 sources for important ones). Infer = reasoned, no URL, labelled "infer". Assumption = unverified (WTP, urgency, switching, integration, ROI) — labelled, never laundered into fact.
- **Never fabricate numbers** — no invented stats / pricing / market size / traction. Missing data → record a GAP + assumption, do not infer a number.
- **The factory must render a verdict.** End at the Decision Gate; never default blindly to Proceed OR Narrow. Proceed = "good enough to grill" — unverified WTP is normal and becomes risk flag #1, NOT a reason to downgrade. Only Pivot/Narrow/Kill for a real reason (weak fit / substitute clearly wins / scope too broad / pain not worth paying for).
- **Do NOT** draw screens / ASCII / HTML, map JTBD 1:1 to screens, or create a screen-brief — those are downstream steps.

When Decision = Proceed, hand off downstream. When Pivot/Narrow/Kill, present the decision and stop.
