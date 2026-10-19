---
name: battle
description: >-
  Activates Antigravity's Colosseum Battle Mode. Pits two rival subagents in isolated
  branched workspaces against each other, stress-tests competing implementations with an
  adversarial referee, and merges the winning solution.
---

# Colosseum Battle Mode Protocol

The `/battle` command activates an adversarial arena between two competing implementations instead of relying on a single agent's code choices.

---

## Arena Architecture

```
                       [User Prompt]
                             │
            ┌────────────────┴────────────────┐
            ▼                                 ▼
   [Competitor Arm Alpha]            [Competitor Arm Beta]
   Workspace: 'branch' (Arm A)       Workspace: 'branch' (Arm B)
            │                                 │
            └────────────────┬────────────────┘
                             │
                             ▼
                 [Colosseum Referee / Critic]
                 Role: critic@colosseum
                 (Adversarial Falser + Benchmark)
                             │
                             ▼
                     [Crown Victor & Merge]
```

---

## Execution Routine

When the user invokes `/battle`:

### Step 1: Forking Competing Arms
Spawn two rival subagents concurrently in isolated git worktrees using `Workspace='branch'`:
1. **Competitor Arm Alpha:**
   ```json
   {
     "TypeName": "self",
     "Role": "Competitor Arm Alpha",
     "Workspace": "branch",
     "Prompt": "Design and implement Approach A for the user's objective. Optimize for safety, correctness, and clean abstraction."
   }
   ```
2. **Competitor Arm Beta:**
   ```json
   {
     "TypeName": "self",
     "Role": "Competitor Arm Beta",
     "Workspace": "branch",
     "Prompt": "Design and implement an alternative Approach B for the user's objective. Optimize for minimal complexity, throughput, and directness."
   }
   ```

### Step 2: Colosseum Referee Audit (`critic@colosseum`)
Once both arms complete their implementations:
1. Dispatch an adversarial referee agent:
   ```json
   {
     "TypeName": "self",
     "Role": "critic@colosseum",
     "Workspace": "inherit",
     "Prompt": "Compare Arm Alpha and Arm Beta. Run fuzzing, boundary tests, edge-case attacks, and empirical benchmarks against both branches. Identify hidden flaws, memory overhead, and unhandled failure modes."
   }
   ```
2. The referee executes both test suites headlessly and records concrete pass/fail metrics.

### Step 3: Crowning the Victor
1. Review the referee's verdict.
2. Fast-forward / merge the winning branch into the main workspace.
3. Eliminate the losing branch and present the full comparative score breakdown to the user.
