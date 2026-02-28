---
name: tdd
description: Enforce Red-Green-Refactor cycle with mandatory test-first discipline for any code change outside the main code-forge workflow. Use for ad-hoc development, quick fixes, or when starting new modules without an existing plan.
---

# Code Forge — TDD

Standalone Test-Driven Development enforcement for any code change.

## When to Use

- Writing code outside of the main code-forge:impl workflow.
- Any new feature, bug fix, or behavior change that needs test discipline.
- When you are about to write production code without a test.

**Note:** The main implementation workflow already enforces TDD internally. This skill is for work outside that workflow.

## Iron Law

**NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.**

## Workflow

```
RED (write failing test) → VERIFY RED → GREEN (minimal code) → VERIFY GREEN → REFACTOR → REPEAT
```

## The Cycle

Complete each phase fully before moving to the next.

### 1. RED — Write a Failing Test
One minimal test showing the desired behavior. Real code preferred over mocks.

### 2. VERIFY RED — Watch It Fail
Confirm it fails for the correct reason (missing behavior, not setup issues).

### 3. GREEN — Write Minimal Code
Simplest code that makes the test pass. No extra features.

### 4. VERIFY GREEN — Watch It Pass
Confirm the new test and all existing tests pass.

### 5. REFACTOR — Clean Up
Improve the code without changing behavior. Ensure tests stay green.

### 6. REPEAT
Go back to Step 1 for the next behavior.

## Verification Checklist

- [ ] Every new function/method has at least one test.
- [ ] Watched each test fail before implementing.
- [ ] Wrote minimal code per test.
- [ ] All tests pass with clean output.
- [ ] Edge cases and error paths covered.
