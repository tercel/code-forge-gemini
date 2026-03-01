---
name: fixbug
description: Debug and fix bugs with interactive upstream trace-back — diagnoses root cause level, confirms upstream document updates, and applies TDD fixes.
---

# Code Forge — Fixbug

Systematically debug and fix bugs with interactive trace-back to upstream documents (task descriptions, plans, requirements).

## When to Use

- Encountered a bug or unexpected behavior in a feature.
- Need to diagnose whether the root cause is in code, task description, plan, or requirements.
- Want to fix the bug with TDD and keep upstream documents in sync.

## Workflow

```
Bug Input → Context Scan → Feature Association → Root Cause Diagnosis → Trace-back Confirmation → TDD Fix → Doc Sync → Summary
```

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Receive Bug Description

Accept prompt text or file reference. If no input provided, use `ask_user` to ask for the bug description.

---

### Step 2: Project Context Scan

Scan the codebase using `glob` and `grep_search`. Identify related files and note the tech stack.

---

### Step 3: Associate Feature (If Exists)

Search `state.json` files and check for file overlap. Use `ask_user` if multiple features match.

---

### Step 4: Root Cause Diagnosis

**Offload to `codebase_investigator`** (or a specialized sub-agent) for deep analysis.

**Sub-agent instruction must include:**
- Bug description and context.
- Feature context (if associated).
- Instruction to identify root cause and classify its level:
  1. Code bug
  2. Incomplete task description
  3. Plan design flaw
  4. Incomplete requirement doc

**Sub-agent must return:** `ROOT_CAUSE_LEVEL`, `ROOT_CAUSE_SUMMARY`, `AFFECTED_FILES`, `UPSTREAM_DOCS_AFFECTED`, `PROPOSED_FIX`, and `REGRESSION_TEST`.

---

### Step 5: Interactive Trace-back Confirmation

**This step only runs if Level >= 2 and the bug is associated with a feature.**

Present the root cause analysis and confirm updates to upstream documents (task, plan, or spec) using `ask_user`. Options: "Yes, update", "No, code fix only", "Show proposed changes".

---

### Step 6: TDD Fix

1. **Write Regression Test**: Test must FAIL with the current code.
2. **Implement Fix**: Minimal code changes to make the test PASS.
3. **Run Full Test Suite**.
4. **Commit Fix**.

---

### Step 7: Upstream Document Sync

Apply confirmed updates to `tasks/*.md`, `plan.md`, or the feature doc. Show diff previews and ask user to apply via `ask_user`.

---

### Step 8: Update state.json

If associated with a feature, append a fix record to the metadata.

---

### Step 9: Summary

Display fix summary: level, summary, code changes, regression test, and document updates.
