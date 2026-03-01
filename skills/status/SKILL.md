---
name: status
description: Display feature dashboard, progress tracking, and project-level overview.
---

# Code Forge — Status

Display a dashboard of all features or detailed progress for a specific feature.

## When to Use

- Want to see all features and their progress
- Want to check status of a specific feature
- Need to regenerate the project-level overview

## Workflow

```
Load Config → Scan Features → Display Dashboard or Detail → Update Overview
```

## Detailed Steps

### Step 0: Configuration Detection and Loading

Read and follow [configuration.md](references/configuration.md) for configuration detection and loading.

---

### Step 1: Determine Mode

Based on arguments:
- **No argument** → Global Dashboard (Step 2)
- **Feature name provided** → Feature Detail (Step 3)

---

### Step 2: Global Dashboard

#### 2.1 Scan for Features

1. Resolve the output directory: `<base_dir>/<output_dir>/`.
2. Search for all `state.json` files using `glob`.
3. Extract feature details (name, status, progress, updated).

#### 2.2 Display Feature Dashboard

Show a table with all features found:

```
code-forge — Feature Dashboard

  #  | Feature        | Progress   | Status      | Last Updated
  1  | user-auth      | 3/5 (60%)  | in_progress | 2026-02-14
  2  | file-upload    | 0/3 (0%)   | pending     | 2026-02-13
  3  | notifications  | 4/4 (100%) | completed   | 2026-02-12
```

Offer actions via `ask_user`:
- **"Select Feature to View Detail"** → enter feature name or select from list.
- **"Start a New Plan"** → suggest `/code-forge:plan`.
- **"Exit"**.

#### 2.3 Update Project-Level Overview

Regenerate `{output_dir}/overview.md` (see [overview-generation.md](references/overview-generation.md)).

---

### Step 3: Feature Detail

#### 3.1 Locate Feature
Look for `{output_dir}/{feature_name}/state.json`.

#### 3.2 Display Feature Detail

Read `state.json` and display:
- **Status, Source, Dates**.
- **Task List Table**: #, Task, Status, Dates.
- **Progress Summary**.
- **Commands**: `/code-forge:impl`, `/code-forge:review`, `/code-forge:fixbug`.

---

### Step 4: Generate/Update Project-Level Overview

Follow [overview-generation.md](references/overview-generation.md) to update the bird's-eye view of all features.
