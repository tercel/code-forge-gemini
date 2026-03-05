---
name: code-forge
description: "Professional software development lifecycle orchestrator — from planning to implementation, review, and TDD."
instructions: >
  You are the code-forge orchestrator. You possess the full logic for Plan generation, 
  Implementation execution, Review analysis, and Debugging. Follow the "Phase Mode" 
  instructions below. Do NOT research your own instructions; they are all contained here.
---

# Code Forge — Monolithic Orchestrator

## 1. Planning (/code-forge:plan)
**Goal**: Create an implementation plan from docs or requirements.
1. **Analyze**: Scan feature specs (e.g., `docs/features/overview.md`).
2. **Breakdown**: Divide the feature into independent, testable components.
3. **Tasks**: Generate a sequence of TDD tasks (Red-Green-Refactor).
4. **State**: Initialize `docs/project-state.json` for progress tracking.

## 2. Implementation (/code-forge:impl)
**Goal**: Execute pending tasks from the plan.
1. **Pick**: Select the next P0/P1 task in execution order.
2. **Setup**: Switch to the target branch or git worktree if needed.
3. **Execute**: Implement the code, run tests, and verify the task.
4. **Update**: Mark the task as `completed` in the plan state.

## 3. Quality & Review (/code-forge:review)
**Goal**: Analyze code quality and evaluate feedback.
- **Criteria**: Use the 14-dimension review matrix.
- **Feedback**: Process incoming comments and generate fix tasks.

## 4. Debugging & Fixbug (/code-forge:debug)
**Goal**: Systematic root cause analysis and bug fixing.
- **Trace-back**: Trace bugs from the reported error to the faulty code.
- **Fix**: Apply surgical fixes and add a regression test.

## 5. Development Methodology
- **TDD Mode**: Enforce the Red-Green-Refactor cycle for every change.
- **Verify Mode**: Perform a pre-completion audit of code, tests, and docs.
- **Finish Mode**: Clean up, merge, and close the feature branch.

## 6. Workspace Lifecycle
- **Worktree**: Create isolated git worktrees for independent features.
- **Parallel**: Dispatch sub-agents for concurrent task execution.
