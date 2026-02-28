---
name: review
description: Comprehensive code review against reference documents and engineering best practices. Covers functional correctness, security, resource management, code quality, architecture, performance, testing, error handling, observability, maintainability, backward compatibility, and dependency safety. Use for features or entire projects.
---

# Code Forge — Review

Comprehensive code review against reference documents and engineering best practices.

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
- Want to post a review directly to a GitHub PR (`--github-pr`)

## Workflow

```
Config → Determine Mode → Locate Reference → Collect Scope → Multi-Dimension Review (sub-agent) → Display Report → Update State → Summary
```

## Context Management

The review analysis is offloaded to a `codebase_investigator` sub-agent to handle large diffs without exhausting the main context.

## Review Severity Levels

All issues use a 4-tier severity system: `blocker`, `critical`, `warning`, `suggestion`.

## Review Dimensions Reference

The review covers 14 dimensions from Functional Correctness (D1) to Accessibility/i18n (D14).

---

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Determine Review Mode

#### 1.0a `--github-pr` Flag Provided

→ **GitHub PR Mode** — Read and follow [github-pr-workflow.md](github-pr-workflow.md).

#### 1.0b `--feedback` Flag Provided

→ **Feedback Mode** — Read and follow [feedback-workflow.md](feedback-workflow.md).

#### 1.1 Feature Name Provided

→ **Feature Mode** — Review a single feature.

#### 1.2 `--project` Flag Provided

→ **Project Mode** — Review the entire project.

#### 1.3 No Arguments

Scan for completed features and use `ask_user` to let user select a feature or project review.

---

### Step 2F/2P: Locate Reference

Determine the reference level: `planning-backed`, `docs-backed`, or `bare`.

---

### Step 3F/3P: Collect Changes and Review (via Sub-agent)

**Offload to `codebase_investigator` sub-agent.**

**Sub-agent instruction must include:**
- Review scope (affected files).
- Reference criteria (plan.md or docs).
- Project type (frontend, backend, etc.).
- Instruction to review across all 14 dimensions and return a structured report with `REVIEW_SUMMARY`, `FUNCTIONAL_CORRECTNESS`, etc.

---

### Step 4F/4P: Display Report

Display the review report in the terminal. Optionally save to file if `--save` is used.

---

### Step 5F: Update state.json

Update feature metadata in `state.json` with review results.

---

### Step 6: Summary and Next Steps

Output a summary of the review and recommended next steps.
