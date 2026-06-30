# Contributing to usecase-factory

Thanks for contributing. This repo is a **Claude Code plugin** — you contribute Markdown
(skills, playbooks, agents, templates) and bash validators, not application code. Read
[`CLAUDE.md`](./CLAUDE.md) first for the architecture; this file is the contribution contract.

## Ground rules

1. **Don't soften the load-bearing rules.** The evidence rules (internet is the research
   engine · dossier is the single source of truth · layer every claim must-cite/infer/assumption ·
   never fabricate numbers · always render a verdict) are what make the output trustworthy. A PR
   that weakens them will be rejected.
2. **Never commit runtime output.** Anything under `doc/`, `output/`, `logs/` is generated per
   run and is gitignored. PRs adding `doc/ws-*` content will be asked to remove it.
3. **Keep `description` frontmatter stable unless triggering is the point of your PR.** A skill's
   `description` is its model-trigger contract. Change *behavior* in `playbook.md`; only touch
   `description` when you intend to change *when the skill fires*, and call that out in the PR.

## How to add or change a skill

Every skill follows the **thin-router + playbook** shape — keep it:

```
skills/<name>/
  SKILL.md        # thin router: frontmatter + command contract + "STEP 0: read playbook.md"
  playbook.md     # the full execution guide — all real logic lives here
  templates/      # (optional) numbered .template.md files the skill copies then fills
```

- `<name>` is **kebab-case**; the skill is invoked as `/usecase-factory:<name>`.
- `SKILL.md` frontmatter: `name`, `description`, and `disable-model-invocation: true` for
  downstream-only stages (those meant to be called explicitly in the pipeline, not auto-fired).
- Reference bundled files with **`${CLAUDE_PLUGIN_ROOT}/...`** — never relative or machine paths.
- A skill operates from the per-run working dir `doc/ws-<slug>/`.
- If your skill is a new pipeline stage, place it in the correct order and update both
  `README.md` (the tree + pipeline diagram) and `CLAUDE.md` (the pipeline section).

## How to add or change an agent

- One file per worker in `agents/<name>.md` (auto-discovered). Research workers are **read-only**
  by design — don't give a researcher write/edit tools.
- If `run`'s playbook should spawn it, add it to the fan-out (one message, multiple Agent calls)
  and document its role.

## Templates

- Numbered `NN-<thing>.template.md`, copied by the owning skill and then filled.
- **Headings are a contract.** If you change a template's headings, update the matching
  validator in `scripts/` in the same PR — otherwise valid output starts failing validation.

## Before you open a PR — checklist

Run from the repo root:

```bash
claude --plugin-dir .                       # plugin loads
claude plugin details usecase-factory       # your skill/agent is discovered

# If you touched the dossier/doc contracts, run the validators on a sample run:
bash scripts/validate-dossier.sh doc/ws-<slug>/_research/dossier.md
bash scripts/coverage-check.sh   doc/ws-<slug> <slug>
```

- [ ] Plugin loads and the new/changed skill + agents are discovered.
- [ ] Thin-router + playbook shape kept; paths use `${CLAUDE_PLUGIN_ROOT}`.
- [ ] No runtime output (`doc/`, `output/`, `logs/`) staged.
- [ ] Template heading changes have matching validator changes.
- [ ] Load-bearing evidence rules intact (or the PR explicitly argues a change to them).
- [ ] `CHANGELOG.md` has an entry under `## [Unreleased]`.
- [ ] README.md / CLAUDE.md updated for any user-facing / convention change (see "Docs are part
      of the change").
- [ ] If behavior/contract changed: version bumped per SemVer and synced across `package.json`,
      `.claude-plugin/plugin.json`, and `.claude-plugin/marketplace.json`.

## Versioning (Semantic Versioning)

Version is `MAJOR.MINOR.PATCH`. Decide the bump by **what your change does to a contract**, not by
how big the diff is. A "contract" here = a skill command signature, a `description` trigger, the
dossier heading set (0–9), a template's headings, output file names/paths, or the verdict
vocabulary.

| Bump | When | Examples |
|---|---|---|
| **MAJOR** (`x.0.0`) | You break an existing contract | rename/remove a stage, change a command signature, change dossier headings, rename output files, change a `description` so existing invocations no longer fire |
| **MINOR** (`0.x.0`) | You add capability, backwards-compatible | add a new skill/stage, add an agent, add an optional template or flag |
| **PATCH** (`0.0.x`) | Fixes only, no contract change | playbook wording, validator bug fix, microcopy, doc fixes, typo |

Rules:
- The version lives in **three files and they must always match**: `package.json`,
  `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`.
- A PR that changes behavior **proposes** the new version (bump all three + add a `CHANGELOG.md`
  entry under `## [Unreleased]`). Don't tag a release or `npm publish` — that's maintainer-gated.

## Docs are part of the change, not an afterthought

Every PR updates the docs that its change touches — **in the same PR**:

- **`CHANGELOG.md`** — always. One line under `## [Unreleased]`, in the right category
  (Added / Changed / Fixed / Removed).
- **`README.md`** — if you changed the pipeline, the stage set, the skill tree, inputs/outputs,
  install/usage, or any user-facing behavior.
- **`CLAUDE.md`** — if you changed a developer-facing convention (skill shape, paths, contracts,
  validators, the rules).
- **The matching validator in `scripts/`** — if you changed a template/dossier heading.

A behavior or contract change with no doc update will be asked to add one before merge.

## What maintainers handle (don't do these in a PR)

- **Tagging releases** and **`npm publish`** are maintainer-gated (publishes
  `@clawexperts/claude-usecase-factory`). Propose the version bump + changelog entry in your PR;
  the maintainer cuts the release.

## Commits & PRs

- Small, focused PRs — one skill/stage or one fix per PR.
- Imperative commit subjects (`Add design-a-screen coverage gate`, not `added stuff`).
- In the PR description: what changed, which stage(s) it touches, and how you tested it locally.
