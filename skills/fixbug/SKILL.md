---
name: fixbug
description: Debug and fix bugs with interactive upstream trace-back — diagnoses root cause level, confirms upstream document updates, and applies TDD fixes. Use when a bug is reported in an existing feature or standalone code.
---

# Code Forge — Fixbug

Systematically debug and fix bugs with interactive trace-back to upstream documents (task descriptions, plans, requirements).

## When to Use

- Encountered a bug or unexpected behavior in a feature
- Need to diagnose whether the root cause is in code, task description, plan, or requirements
- Want to fix the bug with TDD and keep upstream documents in sync

## Workflow

```
Bug Input → Context Scan → Feature Association → Root Cause Diagnosis → Trace-back Confirmation → TDD Fix → Doc Sync → Summary
```

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Receive Bug Description

Accept input as prompt text or file reference. If no input provided, use `ask_user` to ask for the bug description.

---

### Step 2: Project Context Scan

Scan the project codebase using `glob` and `grep_search`. Identify related files and note the tech stack.

---

### Step 3: Associate Feature (If Exists)

Attempt to associate the bug with an existing code-forge feature by searching `state.json` files and checking for file overlap. Use `ask_user` if multiple features match.

---

### Step 4: Root Cause Diagnosis

**Offload to `gsd-debugger` sub-agent** for deep analysis.

**Sub-agent instruction must include:**
- Bug description.
- Project context summary.
- Feature context (if associated).
- Instruction to identify root cause and classify its level (1-4).

**Sub-agent must return** `ROOT_CAUSE_LEVEL`, `ROOT_CAUSE_SUMMARY`, `AFFECTED_FILES`, `UPSTREAM_DOCS_AFFECTED`, `PROPOSED_FIX`, and `REGRESSION_TEST`.

---

### Step 5: Interactive Trace-back Confirmation

Present the analysis to the user and confirm upstream updates level by level using `ask_user`.

---

### Step 6: TDD Fix

Execute the fix:
1. Write and run a failing regression test.
2. Implement the fix.
3. Run the regression test and full test suite.
4. Commit the fix.

---

### Step 7: Upstream Document Sync

Update confirmed upstream documents. Show diff previews and ask user to apply changes.

---

### Step 8: Update state.json

If associated with a feature, append a fix record to `state.json`.

---

### Step 9: Summary

Display fix summary and next steps.
