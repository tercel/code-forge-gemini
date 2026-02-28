---
name: debug
description: Systematic root cause debugging for any technical issue. Use when encountering any bug, test failure, or unexpected behavior. For code-forge features, use code-forge:fixbug instead.
---

# Code Forge — Debug

Systematic root cause debugging for any technical issue.

## When to Use

- Any test failure, bug report, or unexpected behavior.
- Performance degradation, build failures, integration issues.
- ESPECIALLY when under time pressure or when "one quick fix" seems obvious.

**For code-forge features:** Use `/code-forge:fixbug` instead.

## Iron Law

**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.**

## Workflow

```
Root Cause Investigation → Pattern Analysis → Hypothesis Testing → Implementation (TDD fix)
```

## Four Phases

Complete each phase before moving to the next.

### Phase 1: Root Cause Investigation
Read error messages, reproduce consistently, check recent changes, and gather evidence.

### Phase 2: Pattern Analysis
Find working examples, compare against references, and understand dependencies.

### Phase 3: Hypothesis and Testing
Form a single hypothesis, test minimally, and change one variable at a time.

### Phase 4: Implementation
Create a failing test case (TDD), implement a single fix, and verify it works.

## When Fixes Fail

- **< 3 attempts:** Return to Phase 1.
- **>= 3 attempts:** **STOP.** It's likely a wrong architecture or mental model. Discuss with the user.

## Red Flags

- Trying the same approach a third time.
- Adding workarounds instead of fixing the actual issue.
- Suppressing error messages.
- Changing things "to see what happens" without a hypothesis.
