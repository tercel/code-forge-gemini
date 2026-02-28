---
name: finish
description: Complete a development branch by verifying tests, choosing an integration strategy, and cleaning up worktrees. Use after implementation is done and you need to merge or create a PR.
---

# Code Forge — Finish

Complete a development branch by verifying tests, choosing an integration strategy, and cleaning up.

## When to Use

- Implementation is complete and all tasks are done.
- After code-forge:impl finishes all tasks for a feature.
- When you need to integrate a feature branch back to main.
- When you want to discard experimental work cleanly.

## Workflow

```
Verify Tests → Determine Base Branch → Present 4 Options → Execute Choice → Cleanup Worktree
```

## Detailed Steps

### Step 1: Verify Tests
Run the full test suite before proceeding. Follow the `code-forge:verify` discipline.

### Step 2: Determine Base Branch
Identify the upstream branch (default: `main`).

### Step 3: Present Exactly 4 Options
Use `ask_user` to present:
1. **Merge back locally**: Best for solo work.
2. **Push and create Pull Request**: Best for team workflows.
3. **Keep branch as-is**: Preserve worktree for later.
4. **Discard this work**: Permanently remove branch and changes.

### Step 4: Execute Choice
- **Option 1 — Merge**: Checkout base branch and merge with `--no-ff`.
- **Option 2 — Push + PR**: Push branch and use `gh pr create` with generated summary.
- **Option 3 — Keep**: No action, worktree preserved.
- **Option 4 — Discard**: Confirm by asking user to type "discard", then delete branch.

### Step 5: Cleanup Worktree
For options 1, 2, and 4, detect if inside a worktree and remove it using `git worktree remove`.

### Completion Report
Display the finished branch details, action taken, and PR URL if applicable.
