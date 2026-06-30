---
name: design-a-screen
description: Generate multiple radically different screen layouts as ASCII mockups using parallel sub-agents, then compare and synthesize into one. Use when designing an app screen, dashboard, console, or page; exploring layout or information-architecture options; deciding navigation shape (top tabs vs left rail vs wizard); pinning down landing/empty/loading/done states; or when a plan has a significant UI surface that prose alone can't make concrete. Triggers on "design a screen", "mock up the UI", "wireframe", "explore layouts", "design it twice for the UI".
disable-model-invocation: true
---

# Design a Screen

Sibling to `design-an-interface`, applying the same "Design It Twice" principle (A Philosophy of Software Design) to **visual layout** instead of code interfaces: your first layout is unlikely to be the best. Fan out radically different screen designs as ASCII mockups, compare, then synthesize.

Use this BEFORE grilling logic. A sketch forces precision that a decision table hides — navigation shape, what's on first paint, where each action lives, empty/loading/done states. Grill the design against mockups, not prose.

## Workflow

### 1. Gather requirements

Before sketching, understand:

- [ ] What is this screen / app for? Who uses it? (expertise, device, frequency)
- [ ] What are the must-show elements and the primary actions per screen?
- [ ] How many screens / sections, and how do users move between them?
- [ ] What states must each screen handle? (empty / loading / error / first-run vs returning / done)
- [ ] Any hard constraints? Embedded (iframe) vs standalone, brand, accessibility, i18n/RTL.
- [ ] **Palette constraint** — does the project restrict UI to a fixed component/widget set (a design system, a declarative-UI palette, etc.)? If yes, read that source, constrain every mockup to buildable widgets, and **flag any element that needs something the palette lacks** (a "palette-gap"). This is often the highest-value output — it surfaces bespoke-component work early. Skip if the project has no such constraint.

Ask the gaps out loud; explore the codebase/docs for answers before asking the user.

### 2. Generate layouts (parallel sub-agents)

Spawn 3+ sub-agents simultaneously (Agent tool). Each must produce a **radically different** layout — enforce divergence, not variations on one idea.

```
Prompt template per sub-agent:

Design the screen layout for: [screen/app description]

Requirements: [gathered requirements]
Must-show + primary actions: [...]
States to cover: [...]
[Palette constraint, if any]

Layout constraint for THIS design: [assign a different one to each agent], e.g.
- Agent 1: "Navigation as top horizontal tabs; dashboard-first landing"
- Agent 2: "Navigation as a left rail; content-first, minimal chrome"
- Agent 3: "Task/checklist-first — guide the first-run user through steps"
- Agent 4: "Split / master-detail — list on the left, detail on the right"

Output (ASCII only):
1. ASCII mockup of the primary screen (use box-drawing chars; label every region)
2. ASCII mockup of ONE critical alternate state (empty OR first-run OR done)
3. Information architecture: nav shape + screen list + what lives where
4. Trade-offs of this layout (when it shines, when it hurts)
5. Palette-gaps, if a palette constraint was given
```

### 3. Present layouts

Show each design **sequentially** (one at a time, let the user absorb each before the next):

1. ASCII mockup(s)
2. IA summary — nav shape, screen list, action placement
3. What it does well / poorly

Do NOT jump straight to comparison — absorb first.

### 4. Compare

After all are shown, compare on:

- **First-paint clarity** — does a first-time user know what to do immediately?
- **Information architecture** — is navigation obvious; does grouping match the user's mental model?
- **Action discoverability** — are primary actions where the eye lands; secondary ones tucked but reachable?
- **State coverage** — empty / loading / error / first-run / done all handled gracefully?
- **Density vs breathing room** — fit the usage (daily power-tool vs occasional)?
- **Buildability** — composable from the available palette, or how many bespoke components?

Discuss in prose, not tables. Highlight where the layouts diverge most — that divergence is the real decision.

### 5. Synthesize

The best design usually grafts ideas across options. Ask:

- "Which layout best fits your primary use and user?"
- "Any region or interaction from another option worth pulling in?"

Produce ONE merged ASCII mockup as the agreed design.

### 6. Persist

Write the outcome to `doc/ws-<name>/mockups.md` (or the nearest planning folder for the work). Capture:

- The chosen ASCII mockup(s) per screen, with each state.
- IA decisions (nav shape, screen list, action placement) as a short list.
- Palette-gaps found → bespoke components that need building (feed these to planning/grill).
- One line per rejected layout: what it was and why it lost (so the choice is auditable later).

Persist as decisions crystallise — don't batch to the end. This file (`mockups.md`) feeds `/usecase-factory:mockup-to-html` next, and is the coverage GATE a later PRD/FE step reads.

## Anti-patterns

- Don't let sub-agents converge — enforce radically different layouts.
- Don't skip the comparison — the value is in contrast, not any single sketch.
- Don't produce production CSS/code — this is layout and IA only; the mockup is a map, not a build.
- Don't ignore non-happy states — empty/first-run/done is where layouts actually break.
- Don't silently drop a palette-gap — naming the bespoke component early is the point.
