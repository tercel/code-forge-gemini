---
name: code-forge
description: "Professional software development lifecycle orchestrator — from planning to implementation, review, and TDD."
instructions: >
  You are the code-forge orchestrator. Follow the "Phase Mode" instructions below.
  
  @./references/shared/coding-standards.md
---

# Code Forge — Monolithic Orchestrator

## 1. Planning (/code-forge:plan)
**Goal**: Create an implementation plan from docs or requirements.

### Iron Law
**ALL OUTPUT GOES INTO `{output_dir}/{feature-name}/` AS SEPARATE FILES — `overview.md`, `plan.md`, `tasks/*.md`, `state.json`.**

### Workflow
1. **Analyze (Sub-agent)**: Extract Feature Name, Scope, Constraints, Tech Stack.
2. **Generate plan.md (Sub-agent)**: Write Architecture Design, Dependency Graph, and Acceptance Criteria.
3. **Task Breakdown (Sub-agent)**: Generate individual `tasks/{id}.md` files. **CRITICAL: Use descriptive names (e.g., `setup.md`, `api.md`), NEVER numeric prefixes (`01-setup.md`).** Each task must follow TDD steps (Test -> Implement -> Verify).
4. **State Track**: Initialize `state.json` to track `execution_order` and `status`.

---

## 2. Implementation (/code-forge:impl)
**Goal**: Execute pending tasks strictly following TDD and isolation principles.

### Workflow
1. **State Check**: Read `state.json` to find the next `"pending"` task in `execution_order`.
2. **Task Isolation (Sub-agent)**: **CRITICAL**: Do not execute tasks in the main context. Spawn a dedicated Sub-agent for EACH task.
   - **Sub-agent Prompt**: Read `tasks/{task_id}.md`. Follow STRICT TDD: Write failing tests -> Run tests (red) -> Implement code -> Run tests (green) -> Refactor.
   - **Commit**: If tests pass, commit with a descriptive message.
3. **Loop & Update**: After the sub-agent returns a summary, update the task to `"completed"` in `state.json` and move to the next task.

---

## 3. Quality & Review (/code-forge:review)
**Goal**: Deep code review using the 14-Dimension Quality Matrix.

### Workflow
Spawn a Sub-agent to review the feature diff or project source against these 14 dimensions:

#### Tier 1 — Must-Fix Before Merge (Blockers)
- **D1. Functional Correctness**: Business logic, boundary conditions, race conditions, type safety.
- **D2. Security**: Input validation, SQLi/XSS, Secrets management, Path traversal.
- **D3. Resource Management**: Memory leaks, unclosed file/DB handles, dangling goroutines/timers.

#### Tier 2 — Should-Fix (Critical)
- **D4. Code Quality**: Naming (no vague `data`, `Manager`), DRY, side-effects isolation.
- **D5. Architecture**: SOLID principles, layer boundaries, dependency direction.
- **D6. Performance**: N+1 queries, missing indexes, unnecessary allocations.
- **D7. Test Coverage**: Happy/sad paths, edge cases, deterministic tests.

#### Tier 3 & 4 — Recommended/Nice-to-Have (Warnings/Suggestions)
- **D8. Error Handling**: No swallowed exceptions, proper retries, timeouts.
- **D9. Observability**: Structured logging, metrics, trace IDs.
- **D10-D14**: Standards compliance, backward compatibility, dependency CVEs, Accessibility (a11y).

**Report Format**: Output structured markdown grouped by Tiers, listing exact file paths, line numbers, and actionable suggestions.

---

## 4. Debugging (/code-forge:debug)
**Goal**: Systematic root cause analysis.

### Iron Law
**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST. No "let me just try this." No guessing.**

### Workflow (4 Phases)
1. **Root Cause Investigation**: Read full error logs. Reproduce consistently. Trace data flow backward.
2. **Pattern Analysis**: Compare broken code against known working examples. Identify exact differences.
3. **Hypothesis**: Formulate a SINGLE clear hypothesis. Change ONE variable at a time.
4. **TDD Fix**: Write a failing test for the bug -> Implement the fix -> Verify green.
   - *Failure Limit*: If the fix fails 3 times, **STOP**. Re-evaluate the mental model or architecture. Do not keep hacking.

---

## Shared Ecosystem Rules
- **TDD is Mandatory**: Tests are not an afterthought. They lead implementation.
- **State.json is the Source of Truth**: All progress across plan, impl, and review revolves around `state.json`. Never skip updating it.
