# Code Forge — Gemini CLI Skills

> A comprehensive development workflow for **Gemini CLI** — from TDD-driven implementation plans to execution, debugging, code review, and worktree management.

## Overview

Code Forge transforms your development process into a structured, evidence-based workflow. It leverages Gemini CLI's **Agent Skills** and **Sub-agents** to automate the most repetitive parts of software engineering while maintaining high quality and security standards.

## Core Skills

| Skill | Command | Description |
| :--- | :--- | :--- |
| **Plan** | `/code-forge:plan` | Analyze requirements and generate a TDD-driven implementation plan. |
| **Impl** | `/code-forge:impl` | Execute tasks one by one with TDD discipline and sub-agent isolation. |
| **Fixbug** | `/code-forge:fixbug` | Debug with interactive upstream trace-back to requirements and plans. |
| **Review** | `/code-forge:review` | 14-dimension code review against best practices and design goals. |
| **Status** | `/code-forge:status` | View feature dashboard, progress tracking, and project overview. |
| **Debug** | `/code-forge:debug` | Systematic root cause debugging for any technical issue. |
| **TDD** | `/code-forge:tdd` | Enforce Red-Green-Refactor cycle for ad-hoc development. |
| **Verify** | `/code-forge:verify` | Evidence-based completion verification before claiming work is done. |
| **Worktree** | `/code-forge:worktree` | Isolated feature development with automated setup and safety checks. |
| **Finish** | `/code-forge:finish` | Complete a branch with PR creation and worktree cleanup. |
| **Port** | `/code-forge:port` | Port features to new languages with automated batch planning. |
| **Parallel** | `/code-forge:parallel` | Dispatch independent agents to solve multiple unrelated problems. |

## Installation

### 1. Global Deployment (Recommended)

One-command build and installation for your global Gemini profile:

```bash
npm run deploy
```

Then, in your active Gemini CLI session, run:
```text
/skills reload
/commands reload
```

### 2. Uninstallation

```bash
npm run uninstall:user
```

## Configuration

Code Forge uses a `.code-forge.json` file in your project root to manage directory paths and execution preferences. See [docs/CONFIGURATION.md](docs/CONFIGURATION.md) for details.

## Why Gemini CLI Skills?

- **Context Efficiency**: Heavy lifting (analysis, code generation) is offloaded to specialized sub-agents.
- **Evidence-Based**: No completion claims without fresh test evidence.
- **Standardized**: Enforces team-wide standards for architecture, naming, and testing.
- **Modular**: Self-contained skills that can be easily updated and shared.

---
*Created by [tercel](https://github.com/tercel). Optimized for Gemini CLI.*

---
## Installation Note

This repository uses the `-gemini` suffix in its directory name to distinguish it from Claude-compatible versions in the source workspace.

### Recommended Deployment (via gemini-forge)
If you use [gemini-forge](https://github.com/tercel/gemini-forge), you can deploy directly:
```bash
gemini-forge deploy . user
```

### Manual Installation
If you are installing this skill manually (via `/install:skill` or by moving it to `~/.gemini/skills/`), it is **strongly recommended** to rename the directory to its original name (without the `-gemini` suffix) to ensure correct path authorization and command mapping in the Gemini CLI:

```bash
# Example for manual installation
mv code-forge-gemini code-forge
gemini install:skill .
```
---
