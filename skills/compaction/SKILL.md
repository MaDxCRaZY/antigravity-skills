---
name: compaction
description: >-
  Triggers on-demand context compaction: persists critical state into durable artifacts,
  flushes obsolete transient turn history, and signals the runtime to compact context.
---

# On-Demand Context Compaction Protocol

The `/compaction` command provides an explicit trigger to compact the active conversation context, preventing context exhaustion during long-running sessions.

---

## Compaction Routine

When the user invokes `/compaction`:

1. **State Preservation (Pre-Compaction Audit):**
   * Before pruning the conversation history, identify all critical ongoing context:
     * Current objective and tasks completed.
     * Active file paths, line numbers, and key symbols under investigation.
     * Ground-truth telemetry, architectural findings, or pending bugs.
   * Write or update this state into a persistent summary artifact in `<artifactDir>/session_state.md`.

2. **Trigger Runtime Compaction:**
   * Invoke internal `/compact` mechanics or on-demand context checkpointing.
   * Format the compaction checkpoint with:
     * **Accomplished So Far:** Summary of completed changes.
     * **Current State:** Active files, ongoing tests, or current build statuses.
     * **Immediate Next Actions:** Clear bullet points for the next prompt turns.

3. **Background Auto-Compaction Configuration:**
   * Antigravity automatically monitors conversation token thresholds in the background.
   * When conversation volume is high, the runtime periodically summarizes earlier steps into `conversation_summaries.db`.
   * Invoking `/compaction` forces this summarization immediately rather than waiting for automatic token limit triggers.
