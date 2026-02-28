---
name: status
description: Display feature dashboard, progress tracking, and project-level overview. Use to check the current state of implementation plans and overall project progress.
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

1. Resolve the output directory.
2. Search for all `state.json` files using `glob`.
3. Extract feature details from each `state.json`.

#### 2.2 Display Feature Dashboard

Show a table with all features found and their current status. Offer actions via `ask_user`.

#### 2.3 Update Project-Level Overview

After scanning, regenerate `{output_dir}/overview.md`. See [overview-generation.md](references/overview-generation.md).

---

### Step 3: Feature Detail

#### 3.1 Locate Feature

Look for `{output_dir}/{feature_name}/state.json`.

#### 3.2 Display Feature Detail

Read `state.json` and display feature status, source, and a detailed task list with progress.

---

### Step 4: Generate/Update Project-Level Overview

Follow the logic in [overview-generation.md](references/overview-generation.md) to update the project-level overview.
