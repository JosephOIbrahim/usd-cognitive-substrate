# Determinism in USD Cognitive Substrate

**Version:** 7.0.0
**Date:** 2026-01-31

## Overview

The USD Cognitive Substrate achieves deterministic behavior through batch-invariant design principles. This document explains how determinism is enforced and its relationship to the ThinkingMachines research on defeating nondeterminism in LLM inference.

**v7.0.0 Extensions:**
- BCM stigmergic learning with queued updates (batch-invariant)
- Grounding layer determinism (oracle queries are bit-identical)
- Signal reliability tracking (metadata-only, does not affect routing)

## The Problem: Why LLMs Are Non-Deterministic

Common belief: "LLM randomness comes from temperature and sampling."

**Reality**: Even at temperature=0, LLMs produce different outputs. ThinkingMachines (2025) demonstrated **80 unique completions from 1000 identical requests** at temperature=0.

### Root Cause: Batch Invariance Failure

The primary source of nondeterminism is **batch-size variance affecting kernel outputs**:

```
Different batch sizes → Different reduction orders → Different floating-point results
```

This occurs because:
- Matrix multiplication implementations change reduction strategies based on batch dimensions
- Attention kernels apply different split-reduction strategies across varying loads
- Different tensor-core instructions activate at different batch sizes

**Key insight**: `(a + b) + c ≠ a + (b + c)` in floating-point arithmetic. When reduction order changes, numerics change.

## The Solution: Batch-Invariant Design

### Framework Orchestrator's Approach

```python
# DeterminismGuard configuration (framework_orchestrator.py)
determinism_config = {
    "batch_size": 1,                    # Critical: eliminates batch variance
    "cudnn_deterministic": True,        # Deterministic CUDA operations
    "cudnn_benchmark": False,           # Disable autotuning
    "float32_matmul_precision": "highest",
    "seed": seed                        # Reproducible randomness
}
```

### Why `batch_size=1` Matters

| Batch Size | Reduction Order | Determinism |
|------------|-----------------|-------------|
| Variable | Changes with load | **Non-deterministic** |
| Fixed (any) | Consistent | Deterministic within batch |
| **1** | Single element | **Fully deterministic** |

With `batch_size=1`, there's no reduction variance—each inference is independent and reproducible.

## Determinism Guarantees

### What IS Deterministic

| Component | Determinism | How |
|-----------|-------------|-----|
| Task routing | **YES** | Hash-based expert selection |
| Agent activation | **YES** | Fixed keyword matching rules |
| Expert selection | **YES** | `md5(task) % len(experts)` |
| State updates | **YES** | LIVRPS priority resolution |
| Checksum computation | **YES** | Sorted JSON serialization |

### What Requires ThinkingMachines Kernels

| Component | Without TM | With ThinkingMachines |
|-----------|------------|----------------------|
| LLM signal detection | Partial | **Fully deterministic** |
| LLM generation | **NO** | **YES** |
| Semantic parsing | **NO** | **YES** |

### Irreducible Stochasticity

These are inherently non-deterministic and no architecture can fix them:
- Human input (what the user types)
- Human response (how the user reacts)
- Real-world timestamps (unless mocked)

## Reproducibility Contract

```
GIVEN:
  1. Identical user input string
  2. Identical orchestrator state
  3. Identical timestamp (or deterministic mock)
  4. Same model version
  5. Same hardware configuration

GUARANTEE:
  ✓ Identical routing decision
  ✓ Identical agent activation
  ✓ Identical expert selection
  ✓ Identical state update
  ✓ Identical checksum

REQUIRES ThinkingMachines:
  ✓ Identical LLM response
  ✓ Identical signal detection
```

## Implementation Details

### Hash-Based Expert Selection

```python
# MoERouterAgent - Deterministic routing
routing_input = f"{task}:{seed}"
query_hash = hashlib.sha256(routing_input.encode()).hexdigest()

for i, expert in enumerate(self.EXPERTS.keys()):
    segment = query_hash[i*8:(i+1)*8]
    score = int(segment, 16) / (16**8)
    expert_scores[expert] = round(score, 4)
```

Same `task` + `seed` → Same hash → Same expert scores → Same routing.

### Checksum Generation

```python
# Every agent output includes a reproducible checksum
output_str = json.dumps(output, sort_keys=True, default=str)
checksum = hashlib.sha256(output_str.encode()).hexdigest()[:16]
```

`sort_keys=True` ensures dictionary order doesn't affect the hash.

### Master Checksum

```python
# Aggregated checksum across all agents
all_checksums = sorted([r.checksum for r in result_map.values()])
combined = "".join(all_checksums)
master_checksum = hashlib.sha256(combined.encode()).hexdigest()[:32]
```

The master checksum changes if ANY agent's output changes.

## ThinkingMachines Integration

### What ThinkingMachines Provides

Batch-invariant kernels for:
- **RMSNorm**: Data-parallel strategies (one batch element per core)
- **Matrix multiplication**: Consistent tile sizes across all batch sizes
- **Attention**: Fixed split-size (not fixed split count)

### Performance Trade-off

| Configuration | Performance | Determinism |
|---------------|-------------|-------------|
| Standard vLLM | Baseline | Non-deterministic |
| TM initial | 2.1× slower | **Deterministic** |
| TM optimized | 1.6× slower | **Deterministic** |

The 1.6× overhead is acceptable for applications requiring reproducibility.

### Integration Pattern

```python
# Hypothetical ThinkingMachines integration
from thinkingmachines import BatchInvariantEngine

engine = BatchInvariantEngine(
    model="your-model",
    batch_size=1,
    deterministic_attention=True
)

# Guaranteed: same prompt → same output
response = engine.generate(prompt)
```

## Verification

### Testing Determinism

```python
# Run same task twice, compare checksums
result1 = await orchestrator.orchestrate("test task", context)
result2 = await orchestrator.orchestrate("test task", context)

assert result1["master_checksum"] == result2["master_checksum"]
```

### Debugging Non-Determinism

If checksums differ:
1. Check `batch_size` configuration
2. Verify `cudnn_deterministic=True`
3. Ensure fixed `seed` value
4. Compare individual agent checksums to isolate the source

## Code Availability

**Specification Repository:**
https://github.com/JosephOIbrahim/usd-cognitive-substrate

**Reference Implementation:**
https://github.com/JosephOIbrahim/Orchestra

The determinism mechanisms described in this document are implemented in `framework_orchestrator.py`, with verification via `cogroute_bench.py` (100% determinism across runs).

## References

1. He, Horace and Thinking Machines Lab. (2025). "Defeating Nondeterminism in LLM Inference." *Thinking Machines Lab: Connectionism*, September 2025. https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/

2. NVIDIA. (2024). *cuDNN Developer Guide: Reproducibility*. https://docs.nvidia.com/deeplearning/cudnn/developer-guide/index.html

3. PyTorch. (2024). *Reproducibility*. https://pytorch.org/docs/stable/notes/randomness.html

---

---

## BCM Batch-Invariance (v7.0.0)

BCM stigmergic learning is designed to be fully batch-invariant:

### The Problem

Traditional reinforcement learning updates weights during processing. This means:
- Different batch contexts could produce different routing
- Learning state would affect current routing decision
- Batch-invariance would be violated

### The Solution: Queued Updates

```
✓ Trail updates QUEUED during Phase 5 (UPDATE)
✓ Queued updates applied in [POST] FLUSH (after response delivered)
✓ Same inputs → same routing (regardless of trail state)
✓ BCM confidence is METADATA ANNOTATION only
✓ Expert selection order NEVER changes based on trail confidence
```

### Formal Guarantee

```
THEOREM: BCM learning does not affect batch-invariance.

PROOF:
1. Expert selection uses FIXED priority order (Validator > ... > Direct)
2. BCM confidence is computed but NOT used in argmax selection
3. Trail updates are QUEUED, not applied during processing
4. [POST] FLUSH applies updates AFTER response is determined
5. Therefore: same inputs → same routing ∎
```

### What BCM Confidence IS Used For

BCM confidence provides *metadata annotation* for:
- Logging and debugging (which experts are performing well)
- Thinking depth optimization (inform depth selection)
- Human-readable confidence reports
- Post-hoc analysis of routing quality

### What BCM Confidence Is NOT Used For

- Expert selection (argmax uses safety-bounded weights only)
- Routing priority (fixed order: Validator > ... > Direct)
- Safety floor enforcement (always enforced regardless of BCM)

---

## Grounding Determinism (v7.0.0)

The Grounding Layer provides deterministic ground truth via oracle integration.

### Oracle Determinism Theorem

```
THEOREM: Grounded queries produce bit-identical results.

PROOF:
1. Oracle is deterministic (e.g., Bullet physics with fixed seed)
2. Query translation is deterministic (fixed prompt, temperature=0)
3. Cache lookup is deterministic (hash-based, no timing variance)
4. Composition of deterministic functions is deterministic ∎
```

### Empirical Validation

| Experiment | Queries | Identical Results | Determinism |
|------------|---------|-------------------|-------------|
| RBD Physics | 710 | 710 | 100% |
| Constraint Satisfaction | 10 | 10 | 100% |
| USD Unity | 10 | 10 | 100% |

**All 730 grounded queries produced bit-identical results across sessions.**

### Source Mode Routing

| Mode | Oracle Used | Deterministic |
|------|-------------|---------------|
| LEARN | No | Requires ThinkingMachines |
| ACCESS | Yes | **Always deterministic** |
| HYBRID | Yes + LLM | Requires ThinkingMachines for LLM portion |

ACCESS mode provides full determinism without ThinkingMachines (oracle results are authoritative).

### Evidence Warehouse

Evidence tracking is also deterministic:

```
evidence_chain: [
  {source: "oracle_id", query_hash: "abc123", result: "...", timestamp: T}
]
```

- `query_hash` ensures identical queries return cached results
- `timestamp` is metadata only (does not affect routing)
- Evidence composition follows LIVRPS order (deterministic)

---

## Signal Reliability Tracking (v7.0.0)

Signal reliability is tracked as metadata only:

```
✓ Fingerprint capture is deterministic (same signals → same fingerprint)
✓ Reliability scores are READ but not used in routing selection
✓ Correlation updates are QUEUED (applied after processing)
✓ Same inputs → same routing (reliability is metadata only)
```

---

## Summary (v7.0.0)

| Aspect | USD Cognitive Substrate | With ThinkingMachines |
|--------|------------------------|----------------------|
| Routing | Deterministic | Deterministic |
| Expert selection | Deterministic | Deterministic |
| State management | Deterministic | Deterministic |
| BCM learning | Deterministic (queued) | Deterministic (queued) |
| Grounding (ACCESS) | **Deterministic** | **Deterministic** |
| Grounding (HYBRID) | Partial | **Deterministic** |
| LLM generation | Non-deterministic | **Deterministic** |
| **Overall** | **Routing + Grounding deterministic** | **Fully deterministic** |

The USD Cognitive Substrate guarantees deterministic *routing, state management, BCM learning, and grounded queries*. Full end-to-end determinism (including LLM generation) requires ThinkingMachines batch-invariant kernels.
