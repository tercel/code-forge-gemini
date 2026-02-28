---
name: verify
description: Evidence-based completion verification. Use before claiming work is done, fixed, or passing. Requires running verification commands and confirming output before any success claim.
---

# Code Forge — Verify

Evidence-based completion verification. Run before claiming any work is done.

## When to Use

- About to say "tests pass", "build succeeds", "bug is fixed", or "feature is complete".
- Before committing, creating a PR, or marking a task as done.
- After any code change that should be verified.
- When reviewing sub-agent output before trusting it.

**Note:** The main implementation workflow runs verification automatically. This skill is for general use.

## Iron Law

**NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE.**

## Workflow

```
IDENTIFY verification command → RUN fresh → READ full output → VERIFY against claim → CLAIM
```

## The Gate

Every claim must pass through this gate:

1. **IDENTIFY** the verification command (test, build, lint, type-check).
2. **RUN** the command fresh (not from memory, not from a previous run).
3. **READ** the complete output (not skimmed, not truncated).
4. **VERIFY** the output matches the claim (zero failures, exit code 0).
5. **ONLY THEN** make the claim.

## Verification Patterns

### Tests
Run command → See "X passed, 0 failed" → Claim "all tests pass".

### Regression Test
Write test → Run (PASS) → Revert fix → Run (MUST FAIL) → Restore fix → Run (PASS).

### Build
Run build → See exit code 0, no errors → Claim "build passes".

### Sub-Agent Output
Agent claims success → Check VCS diff → Run tests yourself → Verify changes.
NEVER trust agent reports without independent verification.

## Common Mistakes

- Trusting memory of a previous test run instead of running fresh.
- Reading only the last line of output, missing errors above.
- Claiming "build passes" after only running tests (or vice versa).
- Skipping verification because it's a small change.
