# Changelog

All notable changes to `usecase-factory` are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for how to choose a version bump.

## [Unreleased]

### Added
- `CONTRIBUTING.md` — contribution contract (thin-router + playbook skill shape, read-only
  research agents, template/validator heading contract, SemVer policy, pre-PR checklist).
- `CLAUDE.md` — developer guide for the plugin.
- `CHANGELOG.md` — this file.

## [0.1.0]

### Added
- Initial local plugin MVP: pipeline `[use-case-brief] → run → grill-to-brief →
  design-a-screen → mockup-to-html`, plus the `copy-writer` sub-skill.
- 5 agents: 4 research workers (market-sizing, jtbd-pain, competitor-substitute, persona-wtp)
  and 1 adversarial decision-gate-reviewer.
- Validators `scripts/validate-dossier.sh` and `scripts/coverage-check.sh`.
- Decision Gate: Proceed / Pivot / Narrow / Kill verdict over a single-source-of-truth dossier.
