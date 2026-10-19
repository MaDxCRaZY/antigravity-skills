---
name: owl
description: >-
  Activates the OWL (Optimized Workforce Learning) decoupled multi-agent pipeline:
  uses DeepInvestigator for root-cause analysis and edge-case attacks, and DeepCoder
  for verified code synthesis and iterative improvement.
---

# OWL (Optimized Workforce Learning) Pipeline

The `/owl` command activates Antigravity's decoupled multi-agent engineering architecture. Instead of single-pass guessing or fixing symptom B with patch A, OWL splits the task into two specialized decoupled pipelines: **DeepInvestigator** and **DeepCoder**.

---

## Architecture Overview

| Specialist Subagent | Focus Area | Invocation Signature | Workspace Mode |
|---|---|---|---|
| **DeepInvestigator** | Root cause analysis, boundary testing, invariant audits, edge-case attacks | `invoke_subagent(TypeName='DeepInvestigator', ...)` | `Workspace='inherit'` |
| **DeepCoder** | Layer-0 code synthesis, compiler verification, regression prevention, iterative refinement | `invoke_subagent(TypeName='DeepCoder', ...)` | `Workspace='inherit'` |

*(Note: `DeepInvestigator` and `DeepCoder` are built-in native subagents supported by the core runtime engine).*

---

## Execution Routine

When the user invokes `/owl`:

### Step 1: Investigation & Hypothesis Falsification (`DeepInvestigator`)
1. For any bug, refactor, architectural choice, or failure investigation, spawn `DeepInvestigator` first before writing any production code:
   ```json
   {
     "TypeName": "DeepInvestigator",
     "Role": "Deep Investigator",
     "Workspace": "inherit",
     "Prompt": "Perform exhaustive root-cause investigation. Map out full call chains, audit invariant constraints, test boundary edge cases, and ask: 'What happens if X, Y, Z, F, G occur?' Formulate verifiable hypotheses."
   }
   ```
2. Do not proceed to implementation until `DeepInvestigator` reports findings, identified pitfalls, and hard invariant requirements.

### Step 2: Implementation & Refinement (`DeepCoder`)
1. Pass the verified requirements, invariants, and edge cases from Step 1 into `DeepCoder`:
   ```json
   {
     "TypeName": "DeepCoder",
     "Role": "Deep Coder",
     "Workspace": "inherit",
     "Prompt": "Implement solution satisfying all invariants discovered by DeepInvestigator. Enforce compiler gates, verify downstream consumers in the entire call graph, and run test suites."
   }
   ```
2. `DeepCoder` executes iterative improvement cycles until all gates pass without regression.

### Step 3: Synthesis & Verification
1. Verify downstream callers across the entire call-tree.
2. Confirm zero collateral breakage before presenting results to the user.
