---
name: parallel
description: Dispatch independent sub-agents to solve multiple unrelated problems concurrently. Use when facing 2+ independent problems that can be solved concurrently, such as unrelated test failures or bug reports in different subsystems.
---

# Code Forge — Parallel

Dispatch independent sub-agents to solve multiple unrelated problems concurrently.

## When to Use

- 3+ test files failing with different root causes.
- Multiple independent subsystems broken simultaneously.
- Several unrelated bugs reported at once.

## When NOT to Use

- Failures are related (fix one, others may resolve).
- Problems share state or dependencies.
- Need full system state to diagnose.

**For task execution within a feature:** Use `/code-forge:impl`.

## Core Principle

**One agent per independent problem domain. Let them work concurrently.**

## Workflow

### Step 1: Identify Problems
List all problems and identify if they share any state or modules.

### Step 2: Assess Independence
Build a dependency matrix to group dependent problems. Each independent group gets its own sub-agent.

### Step 3: Dispatch Agents
For each independent problem group, launch a `gsd-executor` or `gsd-debugger` sub-agent.

**Agent instruction structure:**
- Problem description and failing tests.
- Scope (files involved).
- Expected behavior.
- Mandatory TDD and debugging methodologies.

**CRITICAL:** Launch all agents in parallel using multiple sub-agent calls in a single message.

### Step 4: Review and Integrate
1. **Check for conflicts**: Ensure agents didn't modify the same files.
2. **Run full test suite**: Verify all fixes work together.
3. **Report results**: Summarize the root cause and status for each problem resolved.
