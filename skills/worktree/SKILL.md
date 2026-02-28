---
name: worktree
description: Create an isolated git worktree for feature development with automated project setup and safety verification. Use when starting feature work that needs workspace isolation to avoid affecting the main workspace.
---

# Code Forge — Worktree

Create an isolated git worktree for feature development with automated project setup and safety verification.

## When to Use

- Starting feature work that should not affect the main workspace.
- Before running code-forge:impl to isolate implementation changes.
- When you need a clean baseline for testing or experimentation.

## Iron Law

**NEVER create a project-local worktree without verifying it is git-ignored.**

## Workflow

```
Detect Directory → Verify Safety → Create Worktree → Project Setup → Baseline Tests → Report
```

## Detailed Steps

### Step 1: Detect Worktree Directory
Check for existing `.worktrees/` or `worktrees/` in project root. If not found, use `ask_user` to choose between project-local and global configurations.

### Step 2: Verify Safety (Project-Local Only)
Ensure the worktree directory is git-ignored using `git check-ignore`. If not ignored, add it to `.gitignore` and commit immediately.

### Step 3: Create Worktree
Detect project name and create the worktree with a new branch named after the feature.

### Step 4: Project Setup
Auto-detect and run setup commands (e.g., `npm install`, `pip install -r requirements.txt`, `cargo build`) in the worktree directory.

### Step 5: Baseline Tests
Run the project's test command to establish a clean baseline and report results.

### Step 6: Report
Display the worktree details, branch, location, and baseline test results. Provide next steps for implementation and finishing the work.
