# BCM Stigmergic Reinforcement Learning

**Version:** 7.0.0
**Date:** 2026-01-31
**Status:** Academic Pre-Publication Draft

---

## Abstract

This document describes the BCM (Bienenstock-Cooper-Munro) stigmergic learning mechanism introduced in USD Cognitive Substrate v7.0.0. The key innovation is learning from experience while maintaining ThinkingMachines batch-invariance through **queued updates** and **metadata-only confidence**.

**Core Principle: "Trails, Not Orders"**

BCM learning provides metadata about expert effectiveness but NEVER changes the deterministic routing order.

---

## 1. Background: The BCM Learning Rule

The Bienenstock-Cooper-Munro (BCM) rule is a synaptic modification theory from computational neuroscience that addresses the stability-plasticity dilemma.

### 1.1 Original BCM Rule

```
dw/dt = φ(y, θ_m) × x
```

Where:
- `w` = synaptic weight
- `y` = postsynaptic activity
- `x` = presynaptic activity
- `θ_m` = sliding modification threshold
- `φ(y, θ_m)` = modification function: positive when y > θ_m, negative when y < θ_m

### 1.2 The Sliding Threshold

The key innovation in BCM is the **sliding threshold** θ_m that provides homeostatic regulation:

```
θ_m = E[y²]
```

This creates:
- **Potentiation** when y > θ_m (frequent activity → strengthening)
- **Depression** when y < θ_m (rare activity → weakening)
- **Self-stabilization** (θ_m adjusts to prevent runaway)

---

## 2. Adaptation for Cognitive Substrate

### 2.1 Trail-Based Expert Confidence

Instead of synaptic weights, we track "trails" for each expert:

```python
@dataclass
class OrchestraTrail:
    expert_id: str
    strength: float  # 0.01 - 100.0 (pheromone-like)
    success_rate: float  # 0.0 - 1.0
    total_outcomes: int
    successful_outcomes: int
    last_updated: datetime
    theta_m: float  # Sliding threshold
```

### 2.2 Confidence Calculation

```python
@property
def confidence(self) -> float:
    """Composite confidence score (0.0 - 1.0)."""
    strength_normalized = self.strength / 100.0
    return 0.6 * self.success_rate + 0.4 * strength_normalized
```

The 60/40 split prioritizes recent success rate while incorporating trail strength.

### 2.3 BCM Configuration

```python
@dataclass
class BCMConfig:
    base_learning_rate: float = 0.1
    decay_factor: float = 0.95  # θ_m decay
    time_decay_half_life: float = 7200.0  # 2 hours in seconds
    saturation_temperature: float = 10.0
    min_strength: float = 0.01
    max_strength: float = 100.0
```

---

## 3. Mathematical Formulation

### 3.1 Sliding Threshold Update

The threshold θ_m adapts to recent activity:

```
θ_m(t+1) = α × θ_m(t) + (1 - α) × ȳ²(t)
```

Where:
- α = decay_factor (0.95)
- ȳ = recent activity average (outcome signal)

### 3.2 Saturation Factor

The saturation factor prevents unbounded growth:

```
saturation(s) = 1 / (1 + exp(-(s - θ_m) / T))
```

Where:
- s = current trail strength
- θ_m = sliding threshold
- T = temperature (controls sigmoid steepness)

**Properties:**
- Low strength + high activity → Strong updates (potentiation)
- High strength + low activity → Weak updates (saturation)
- Automatic homeostasis

### 3.3 Trail Strength Update

```
Δs = η × (y - θ_m) × x × saturation(s)
s_new = clip(s + Δs, s_min, s_max)
```

Where:
- η = base learning rate
- y = outcome signal (0.0 = failure, 1.0 = success)
- x = activation level (how strongly this expert was used)
- saturation(s) = BCM saturation factor

### 3.4 Time-Based Decay

Trail strength decays exponentially with time:

```
s(t) = s(0) × exp(-t / τ)
τ = half_life / ln(2) ≈ 10,386 seconds for 2-hour half-life
```

This keeps trails responsive to recent performance rather than historical accumulation.

---

## 4. Batch-Invariance Compliance

### 4.1 The Challenge

Traditional reinforcement learning updates during processing:

```
# WRONG - violates batch-invariance
outcome = process(input)
weights = update(weights, outcome)  # Affects CURRENT routing
```

This means:
- Different batch contexts → different weights → different routing
- Learning state affects current decision
- Not reproducible

### 4.2 The Solution: Queued Updates

```
# CORRECT - batch-invariant
outcome = process(input)  # Uses FIXED weights
queue.append(update_request(outcome))  # Queued, not applied

# AFTER response delivered
for update in queue:
    apply(update)  # Now safe to modify
```

### 4.3 Phase Integration

```
Phase 5: UPDATE
  - Hebbian learning (traditional)
  - BCM trail updates QUEUED (not applied)
  - Plasticity window check

[POST] FLUSH
  - Apply all queued BCM updates
  - Happens AFTER response delivered
  - Does NOT affect current routing
```

### 4.4 Formal Guarantee

```
THEOREM: BCM learning is batch-invariant.

GIVEN:
  - Same input signal S
  - Same cognitive state C (before update)
  - Same expert weights W

THEN:
  - Same activation vector A (Phase 1)
  - Same weighted scores A × W (Phase 2)
  - Same bounded scores (Phase 3)
  - Same expert selection argmax(bounded) (Phase 4)
  - Same response generation

REGARDLESS OF:
  - BCM trail state (not used in selection)
  - Queued updates (not applied during processing)
  - Batch context (updates isolated)

PROOF:
  BCM confidence is computed but NOT used in argmax.
  Trail updates are QUEUED, not applied.
  Expert selection uses FIXED priority order.
  Therefore: same inputs → same routing ∎
```

---

## 5. Plasticity Auto-Triggers

### 5.1 Window States

Plasticity windows open/close based on cognitive state:

| Condition | Action | Sigma (σ) |
|-----------|--------|-----------|
| momentum=CRASHED + burnout≥ORANGE | Open | 0.5 |
| burnout=RED | Open | 0.3 |
| converged + stable_exchanges ≥ 3 | Close | 0.0 |
| Default | Closed | 0.0 |

### 5.2 Effective Learning Rate

When plasticity window is open:

```
effective_rate = base_rate × (1 + σ × multiplier)
```

Where:
- σ ∈ [0.0, 1.0] = plasticity sigma
- multiplier = 2.0 (configurable)

### 5.3 Rationale

During crashes (momentum=CRASHED, burnout≥ORANGE):
- The system is failing to serve the user well
- Increased plasticity enables faster adaptation
- Learn from failure without breaking determinism

During convergence (stable for 3+ exchanges):
- The system is working well
- Reduce plasticity to preserve good state
- Exploitation over exploration

---

## 6. Signal Reliability Tracking

### 6.1 Signal Fingerprinting

Compact capture of primary signal per category:

```python
fingerprint = {
    "emotional": "frustrated",  # Primary signal
    "task": "debug",
    "grounding": None,
    "mode": None,
    "domain": "vfx",
    "energy": "low"
}
```

### 6.2 Reliability Correlation

Track correlation between fingerprints and outcomes:

```python
reliability[category] = successful_outcomes[category] / total_outcomes[category]
```

**Lookback window:** 50 recent outcomes (sliding)
**Default:** 1.0 until evidence suggests otherwise

### 6.3 Usage

Reliability is **metadata only** (does not affect routing):

- Logging: "emotional signals have 73% reliability"
- Debugging: Identify weak signal categories
- Future work: Could inform confidence reporting

---

## 7. Integration with ADHD_MoE

### 7.1 Expert Priority Order (FIXED)

```
Pri  Expert       BCM Integration
───  ──────────   ────────────────────────────────────────
1    Validator    Trail tracks validation outcomes
2    Scaffolder   Trail tracks complexity reduction success
3    Restorer     Trail tracks recovery effectiveness
4    Refocuser    Trail tracks redirect success
5    Celebrator   Trail tracks acknowledgment reception
6    Socratic     Trail tracks discovery facilitation
7    Direct       Trail tracks direct execution success
```

### 7.2 What BCM Does NOT Change

- Expert priority order (always 1-7)
- Safety floor enforcement (Validator ≥ 0.10)
- argmax selection logic
- Tiebreaker rules (lower index wins)

### 7.3 What BCM DOES Provide

- Per-expert confidence metadata
- Historical success rate tracking
- Time-decayed trail strength
- Saturation-limited updates
- Plasticity-modulated learning

---

## 8. Implementation Reference

### 8.1 Core Classes

```python
# src/orchestra/bcm.py

@dataclass
class BCMConfig:
    base_learning_rate: float = 0.1
    decay_factor: float = 0.95
    time_decay_half_life: float = 7200.0
    saturation_temperature: float = 10.0
    min_strength: float = 0.01
    max_strength: float = 100.0

@dataclass
class OrchestraTrail:
    expert_id: str
    strength: float
    success_rate: float
    total_outcomes: int
    successful_outcomes: int
    last_updated: datetime
    theta_m: float

    @property
    def confidence(self) -> float:
        return 0.6 * self.success_rate + 0.4 * (self.strength / 100.0)
```

### 8.2 Update Queue

```python
class BCMUpdateQueue:
    """Queued updates for batch-invariance."""

    def __init__(self):
        self._pending: List[TrailUpdate] = []

    def queue_update(self, expert_id: str, outcome: float, activation: float):
        self._pending.append(TrailUpdate(expert_id, outcome, activation))

    def flush(self, trail_store: TrailStore):
        """Apply all queued updates. Call AFTER response delivered."""
        for update in self._pending:
            trail_store.apply_update(update)
        self._pending.clear()
```

### 8.3 Test Validation

```bash
# Run BCM-specific tests
pytest tests/test_bcm.py -v

# Verify batch-invariance
pytest tests/test_bcm.py::test_batch_invariance -v

# Full test suite (1047+ tests)
pytest tests/ -v
```

---

## 9. References

1. Bienenstock, E. L., Cooper, L. N., & Munro, P. W. (1982). "Theory for the development of neuron selectivity: orientation specificity and binocular interaction in visual cortex." *Journal of Neuroscience*, 2(1), 32-48.

2. He, Horace and Thinking Machines Lab. (2025). "Defeating Nondeterminism in LLM Inference." *Thinking Machines Lab: Connectionism*, September 2025.

3. Ibrahim, J. O. (2026). "USD Cognitive Substrate: A Deterministic Architecture for Adaptive AI State Management." *arXiv preprint*.

---

*Date: 2026-01-31*
*Version: 7.0.0*
*Classification: Academic Pre-Publication Draft*
