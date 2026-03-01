---
name: review
description: >
  Use when reviewing code, handling review feedback, or posting a review to a Gemini CLI PR —
  14-dimension quality analysis for features or entire projects (generate mode), structured
  evaluation and response to incoming review comments (feedback mode via --feedback flag),
  or automated PR review posted as a Gemini CLI comment (--github-pr flag).
---

# Code Forge — Review

Comprehensive code review against reference documents and engineering best practices. Covers functional correctness, security, resource management, code quality, architecture, performance, testing, error handling, observability, maintainability, backward compatibility, and dependency safety.

Supports four modes:
- **Feature mode:** Review a single feature against its `plan.md`
- **Project mode:** Review the entire project against planning documents or upstream docs
- **Feedback mode:** Evaluate and respond to incoming code review comments (`--feedback`)
- **GitHub PR mode:** Post a 14-dimension review as a comment on a GitHub PR (`--github-pr`)

## When to Use

- Feature implementation is complete or nearly complete
- Want to verify code quality before creating a PR
- Need a structured review against the original plan or documentation
- Received code review feedback (`--feedback`)
- Want to post a code review directly to a GitHub PR (`--github-pr`)

## Workflow

```
Config → Determine Mode → Locate Reference → Collect Scope → Multi-Dimension Review (sub-agent) → Display Report → Update State → Summary
```

## Context Management

The review analysis is offloaded to a sub-agent (using `codebase_investigator`) to handle large diffs without exhausting the main context.

## Review Severity Levels

All issues use a 4-tier severity system: `blocker` 🚫, `critical` ⚠️, `warning` 🟠, `suggestion` 📘.

## Review Dimensions Reference

The review covers 14 dimensions from Functional Correctness (D1) to Accessibility/i18n (D14).

---

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Determine Review Mode

#### 1.0a `--github-pr` Flag Provided
→ **GitHub PR Mode** — Read and follow `github-pr-workflow.md`.

#### 1.0b `--feedback` Flag Provided
→ **Feedback Mode** — Read and follow `feedback-workflow.md`.

#### 1.1-1.3 Feature Selection
Use `ask_user` if no feature name is provided to let user select from completed features.

---

### Step 2F/2P: Locate Reference

Determine the reference level: `planning-backed`, `docs-backed`, or `bare`.

---

### Step 3F/3P: Collect Changes and Review (via Sub-agent)

**Offload to `codebase_investigator`** to handle the full diff/source analysis.

**Sub-agent instruction must include:**
- Review scope (affected files).
- Reference criteria (plan.md or docs).
- Project type detection (frontend, backend, etc.).
- Instruction to review across all 14 dimensions and return a structured report (`REVIEW_SUMMARY`, `FUNCTIONAL_CORRECTNESS`, etc.).

---

### Step 4F/4P: Display Report

Display the review report in the terminal. Optionally save to file if `--save` is used.

---

### Step 5F: Feature Mode — Update state.json

Update feature metadata in `state.json` with review results.

### Step 5P: Project Mode — No State Update

Project mode does not update any `state.json` — there is no single feature state to track.

---

### Step 6: Summary and Next Steps

Output a summary of the review and recommended next steps (e.g., `/code-forge:impl` to fix issues).

## Coordination with Other Skills

- **With /code-forge:impl**: After review → fix blockers/criticals.
- **With /code-forge:status**: View overall feature progress including review state.

## Notes

1. **Review Severity**: Blocker and Critical issues MUST be fixed before merge.
2. **Dimension Application**: D14 is only applied for frontend/fullstack projects.
3. **Iterative Process**: Reviews are often iterative; use `--save` to track history.
