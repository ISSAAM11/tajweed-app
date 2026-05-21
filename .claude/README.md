# `.claude/` — project configuration for Claude Code

This folder configures how [Claude Code](https://claude.com/claude-code) operates on the Tajweed AI repo.

## What's here

- **`settings.json`** — permissions allowlist + denylist. Lets Claude run common dev-loop commands (`flutter analyze`, `git diff`, etc.) without prompting, while still blocking destructive operations (`git push --force`, `git reset --hard`, `gh pr merge`).
- **`README.md`** *(this file)* — quick pointer.

## How to drive Claude Code on this repo

The full methodology lives in [`docs/VIBECODING-GUIDE.md`](../docs/VIBECODING-GUIDE.md). Read it once.

Short version, per feature:

1. **Plan mode** (`Shift+Tab`) → Claude researches and proposes a plan; you approve.
2. **Implement** → Claude edits files; you approve each write (or rely on the allowlist).
3. **`/review`** → quality + design-system + i18n check before commit.
4. **`/verify`** → run the app and exercise the feature on a real device.
5. **`/workflow-git-workflow`** → branch, commit, PR, merge.

## Source of truth

- **What to build** — [`docs/commercial/LISTE-DES-FONCTIONS.md`](../docs/commercial/LISTE-DES-FONCTIONS.md)
- **What's next** — [`docs/IMPLEMENTATION-TRACKER.md`](../docs/IMPLEMENTATION-TRACKER.md)
- **How to write code here** — [`CLAUDE.md`](../CLAUDE.md)
- **Visual tokens** — [`DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md), [`DESIGN-LIGHT-MODE.md`](../DESIGN-LIGHT-MODE.md), [`DESIGN-DARK-MODE.md`](../DESIGN-DARK-MODE.md)
