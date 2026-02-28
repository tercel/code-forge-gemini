---
name: port
description: Port a documentation-driven project to a new target language. Initializes project skeleton, analyzes reference implementation, and batch-generates implementation plans for selected features.
---

# Code Forge — Port

Port a project to a new target language by batch-generating implementation plans from shared feature specs.

## When to Use

- Have a documentation project with feature specs (`docs/features/*.md`) and want to implement in a new language.
- Have an existing implementation in one language and want to create another language version.
- Need to batch-plan multiple features for a new language SDK.

## Command Format

```bash
/code-forge:port @<docs-project> --ref <reference-impl> --lang <target-language>
```

## Workflow

```
Step 0 → 1 → 2 → 3 → 4 → 5 → 6 (sub-agent loop) → 7 → 8
```

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Parse Arguments and Discover Feature Specs

Resolve docs project path, reference implementation, target language, and derive target project path.

---

### Step 2: Analyze Reference Implementation (Sub-agent)

**Offload to `codebase_investigator` sub-agent.**

**Sub-agent instruction must include:**
- Path to reference implementation.
- Instruction to analyze `overview.md`, `plan.md`, and `state.json` files.
- Return a structured summary with `REFERENCE_IMPL`, `DEPENDENCY_ORDER`, and `PER_FEATURE` details.

---

### Step 3: Display Feature List and User Selection

Present discovered specs and reference data. Use `ask_user` with `multiSelect: true` to let user select features to port.

---

### Step 4: Confirm Target Tech Stack

Use `ask_user` to confirm build tools, versions, and frameworks for the target language.

---

### Step 5: Initialize Target Project Skeleton

Create target directory, generate `.code-forge.json`, and spawn a sub-agent to create the project skeleton (build file, `.gitignore`, `README.md`).

---

### Step 6: Batch Generate Plans (Sub-agent per Feature)

Process each selected feature. For each:
1. Create feature directory.
2. Dispatch `gsd-planner` sub-agent to generate `plan.md`, task files, and `overview.md`.
3. Verify output and initialize `state.json`.

---

### Step 7: Generate Project Overview

Scan `state.json` files and generate project-level `overview.md`. See [overview-generation.md](references/overview-generation.md).

---

### Step 8: Display Results and Next Steps

Output completion summary and instructions for next steps.
