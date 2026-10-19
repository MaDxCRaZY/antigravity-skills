---
name: benchmark
description: >-
  Replaces guesswork with empirical hardware telemetry: synthesizes ad-hoc stress-test
  harnesses on the fly, executes them headlessly, and proves performance gains with hard numbers.
---

# Empirical Benchmark & Telemetry Protocol

The `/benchmark` command enforces empirical verification. Rather than accepting theoretical claims or synthetic estimates, the agent must construct executable test harnesses, run them headlessly, and measure real hardware performance metrics.

---

## Benchmark Guidelines

1. **Ad-Hoc Harness Synthesis:**
   * Write test scripts or micro-benchmarks in `<appDataDir>/brain/<conversation-id>/scratch/` (or a designated benchmark directory).
   * Warm up the execution runtime before sampling.
   * Run multiple iterations (minimum 10-50 iterations depending on workload duration) to establish statistically reliable percentiles (p50, p90, p99).

2. **Hardware Telemetry Measurement:**
   Execute via `run_command` headlessly and capture:
   * **Latency:** Wall-clock execution time (ms/µs).
   * **Throughput:** Operations per second / frames per second / bytes per second.
   * **Memory:** Peak resident set size (RSS), allocation churn, heap footprint.
   * **Failure Rate:** Error counts or timeout occurrences under stress.

3. **Comparison Matrix:**
   Always generate a side-by-side empirical report comparing Baseline vs. Candidate:

   | Metric | Baseline | Candidate | Delta (% Change) | Confidence |
   |---|---|---|---|---|
   | Median Latency (p50) | `...` | `...` | `...%` | `p < 0.01` |
   | Tail Latency (p99) | `...` | `...` | `...%` | `p < 0.01` |
   | Peak Memory (RSS) | `...` | `...` | `...%` | Verified |
   | Throughput | `...` | `...` | `...%` | Verified |

4. **Absolute Ban on Guesswork:**
   Never declare a function "optimized" without running the benchmark script and reporting raw, reproducible console outputs.
