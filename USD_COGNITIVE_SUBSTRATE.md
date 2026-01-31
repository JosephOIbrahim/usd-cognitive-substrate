# USD Cognitive Substrate: A Deterministic Architecture for Adaptive AI State Management

**Version:** 7.1.0
**Date:** 2026-01-31
**Status:** Academic Pre-Publication Draft
**Authors:** Joseph O. Ibrahim

---

## Abstract

We present the USD Cognitive Substrate, a novel architecture that repurposes Universal Scene Description (USD) composition semantics—originally designed for conflict resolution in visual effects pipelines—for deterministic state management in large language model (LLM) applications. The architecture achieves a previously elusive property: **fully deterministic cognitive behavior** from signal detection through response generation, with stochasticity isolated exclusively to irreducible human input/output boundaries.

The system comprises two orthogonal hierarchies: a USD Composition Hierarchy for state storage with LIVRPS (Local, Inherits, VariantSets, References, Payloads, Specializes) resolution, and a Runtime Service Stack for processing, routing, and adaptation. A novel "Mycelium" mechanism provides neuroplasticity within constitutional bounds, enabling the system to learn while maintaining safety guarantees.

**Version 7.0.0 introduces three major extensions:**
1. **Grounding Layer (L7.5)** — The "ACCESS over LEARN" paradigm: route queries to deterministic oracles (physics simulators, knowledge graphs) when ground truth exists
2. **BCM Stigmergic Learning** — Bienenstock-Cooper-Munro learning with trail-based expert confidence as *metadata annotation only*, preserving ThinkingMachines batch-invariance
3. **Signal Reliability Tracking** — Fingerprint-outcome correlation for routing confidence prediction

When integrated with batch-invariant inference engines (ThinkingMachines), the architecture guarantees: **same user input + same state → same response + same state update**. This enables reproducible sessions, behavioral unit testing, complete audit trails, and formally verifiable cognitive systems.

**Keywords:** Universal Scene Description, cognitive architecture, deterministic AI, state management, neuroplasticity, batch invariance, LIVRPS composition, grounded world models, BCM learning

---

## 1. Introduction

### 1.1 The Problem

Modern LLM applications face a fundamental tension: users expect consistent, personalized behavior, but LLM inference is inherently stochastic. The same prompt can produce different outputs based on:

- Batch size during inference
- Server load affecting reduction order
- Non-deterministic GPU operations
- Temperature and sampling parameters

This non-determinism creates challenges for:

1. **Debugging** — Cannot reproduce reported issues
2. **Testing** — Behavioral tests are flaky
3. **Auditing** — Cannot verify decision traces
4. **Personalization** — Learning is noisy
5. **Safety** — Cannot guarantee behavioral bounds

### 1.2 The Thesis

We propose that **USD (Universal Scene Description) composition semantics are uniquely suited for cognitive state management in LLM applications**. This is not about using USD for 3D graphics—it is about repurposing USD's conflict resolution system for AI state management.

The parallel:

| VFX Problem | AI Problem |
|-------------|------------|
| Multiple departments (model, rig, anim, light) disagree about scene data | Multiple state sources (profile, mood, task, safety) disagree about behavior |
| USD's LIVRPS resolves conflicts deterministically | USD's LIVRPS resolves conflicts deterministically |

Same solution. Different domain.

### 1.3 Contributions

This paper makes the following contributions:

1. **Separation of Storage and Routing** — USD provides state persistence; a separate routing engine provides adaptive behavior

2. **The Mycelium Mechanism** — A neuroplasticity system with four rebalancing avenues (activation spreading, Hebbian learning, attractor dynamics, homeostatic regulation) operating within hard constitutional bounds

3. **The Mycelium Arc** — A novel USD composition arc for horizontal (agent-to-agent) state flow, complementing LIVRPS's vertical composition

4. **Determinism Analysis** — Formal identification of stochastic boundaries and requirements for full reproducibility

5. **Integration with Batch-Invariant Inference** — When combined with ThinkingMachines kernels, the architecture achieves full determinism except for irreducible human I/O

**v7.0.0 Additional Contributions:**

6. **Grounding Layer (L7.5)** — The "ACCESS over LEARN" paradigm for deterministic ground truth via oracle integration (validated: 10/10 experiments, physics + constraint satisfaction)

7. **BCM Stigmergic Learning** — Trail-based expert confidence with Bienenstock-Cooper-Munro saturation, providing learning capability while maintaining batch-invariance through queued updates

8. **Plasticity Auto-Triggers** — Adaptive learning rate windows that open during crashes and close on convergence

9. **Signal Reliability Tracking** — Fingerprint-outcome correlation for predictive routing confidence

---

## 2. Background

### 2.1 Universal Scene Description (USD)

USD is Pixar's open-source framework for describing, composing, and querying hierarchical scene data. Its key properties relevant to our work:

**LIVRPS Composition Order:**
- **L**ocal — Direct opinions on a prim (highest priority)
- **I**nherits — Inherited from parent prims
- **V**ariantSets — Selected variants
- **R**eferences — External file references
- **P**ayloads — Lazy-loaded external content
- **S**pecializes — Base class inheritance (lowest priority)

**Key Properties:**
1. **Native Composition** — Conflict resolution is built into the format
2. **Lazy Loading (Payloads)** — Content loads on demand
3. **First-Class Variants** — Mode switching is a language construct

No other configuration format (JSON, YAML, Protobuf, GraphQL) provides all three properties.

### 2.2 Determinism in LLM Inference

**The Key Insight**: Individual LLM forward passes are run-to-run deterministic. The source of user-visible nondeterminism is that **batch size varies with server load**, and most kernels lack batch-invariance.

ThinkingMachines (2025) demonstrated this empirically: **80 unique completions from 1000 identical requests** at temperature=0. The variation occurs because:

1. **Batch-size-dependent reduction order** — The same matrix operation (`torch.mm(a[:1], b)` vs `torch.mm(a, b)[:1]`) produces different results depending on batch size, even though the mathematical operation is identical
2. **Load-dependent batching** — Server load determines batch size, introducing runtime variation
3. **Kernel optimization switches** — Some kernels change algorithms (e.g., split-K) based on batch size

**What doesn't fully explain it** (common misconceptions):
- Floating-point non-associativity alone (individual kernels can be deterministic)
- GPU thread scheduling (can be controlled)
- Sampling randomness (can be seeded)

ThinkingMachines batch-invariant kernels eliminate these sources at a cost of ~1.6-2.1x performance overhead (1.6x with optimized attention kernel, 2.1x unoptimized).

### 2.3 Cognitive Architectures

Prior cognitive architectures (ACT-R, SOAR, LIDA) provide theoretical frameworks for cognitive modeling but lack:

1. **Deterministic guarantees** — Behavior varies across runs
2. **Persistent composition** — State management is ad-hoc
3. **Lazy expertise loading** — All knowledge must be present
4. **Constitutional bounds** — Safety constraints are not first-class

---

## 3. Architecture Overview

The USD Cognitive Substrate comprises two orthogonal hierarchies:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      RUNTIME SERVICE STACK                               │
│  (Processing, Routing, Adaptation, Dispatch)                            │
│                                                                          │
│  R1: Application Layer ─── External apps reporting signals              │
│  R2: Intervention Dispatch ─── Expert → application-specific actions    │
│  R3: Signal Aggregator ─── Multi-source signal normalization            │
│  R4: Routing Engine ─── Expert selection + neuroplasticity              │
│  R5: Temporal Orchestrator ─── Session lifecycle + pattern learning     │
│  R6: Context Restorer ─── "Where was I?" continuity                     │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
                               ↕ reads/writes
┌─────────────────────────────────────────────────────────────────────────┐
│                      USD COMPOSITION HIERARCHY                           │
│  (State Storage with LIVRPS Resolution)                                 │
│                                                                          │
│  L13: current.usda ─────────────────────────────────── [LOCAL]          │
│  L12: snapshots/*.usda ─────────────────────────────── [LOCAL]          │
│  L11: daily/*.usda ─────────────────────────────────── [INHERITS]       │
│  L10: weekly/*.usda ────────────────────────────────── [INHERITS]       │
│  L9:  calibration.usda ─────────────────────────────── [REFERENCES]     │
│  L8:  profile.usda ─────────────────────────────────── [SPECIALIZES]    │
│  L7:  payloads/*.usda ──────────────────────────────── [PAYLOADS]       │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

**Critical Design Decision:** USD provides storage and composition semantics. USD does NOT provide routing logic. The routing engine is a separate layer that reads from and writes to USD.

---

## 4. USD Composition Hierarchy

### 4.1 Layer Definitions

| Layer | USD Arc | Mutability | Contents |
|-------|---------|------------|----------|
| L13: current.usda | LOCAL | Mutable | Live session state: energy, momentum, expert_weights, active task |
| L12: snapshots/*.usda | LOCAL | Immutable | Context restoration points with task, cognitive, environmental state |
| L11: daily/*.usda | INHERITS | Append-only | Aggregated daily patterns, time-of-day weights |
| L10: weekly/*.usda | INHERITS | Append-only | Day-of-week patterns, weekly rhythms |
| L9: calibration.usda | REFERENCES | Slow-update | Long-term learned weight adjustments, temporal patterns |
| L8: profile.usda | SPECIALIZES | Immutable | Base traits, safety floors, constitutional constraints |
| L7: payloads/*.usda | PAYLOADS | Immutable | Domain specializations (ADHD, Anxiety, VFX, etc.) |

### 4.2 LIVRPS Resolution

**Figure 2: LIVRPS Composition Resolution**

```
                    QUERY: "What is energy?"
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│  LIVRPS RESOLUTION ORDER (Strongest → Weakest)                      │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  L: LOCAL ──────────────► current.usda ──────► energy = 0.3 ✓ WINS │
│     (highest priority)                                              │
│            │                                                        │
│            ▼ if not found                                           │
│  I: INHERITS ──────────► daily/*.usda ───────► (not set)           │
│            │                                                        │
│            ▼ if not found                                           │
│  V: VARIANTSETS ────────► mode_variants ─────► (not set)           │
│            │                                                        │
│            ▼ if not found                                           │
│  R: REFERENCES ─────────► calibration.usda ──► energy = 0.7        │
│            │                                                        │
│            ▼ if not found                                           │
│  P: PAYLOADS ───────────► adhd.usda ─────────► (not set)           │
│            │                                                        │
│            ▼ if not found                                           │
│  S: SPECIALIZES ────────► profile.usda ──────► energy = 0.5        │
│     (lowest priority)        (default)                              │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    RESULT: energy = 0.3
                    (from LOCAL: current.usda)
```

**Resolution Rule:** First layer with a defined value wins. Higher layers shadow lower layers without modifying them.

**Exception:** Constitutional constraints in profile.usda (SPECIALIZES) cannot be overridden by any layer—they are protected by the substrate itself.

### 4.3 State Schema (v7.0.0 — 44 Fields)

```usda
def "CognitiveState" {
    # ═══════════════════════════════════════════════════════════════
    # CORE STATE (preserved from v5.0)
    # ═══════════════════════════════════════════════════════════════

    # Continuous dimensions
    float energy = 0.7
    float cognitive_load = 0.4
    float focus_coherence = 0.8

    # Discrete states
    string momentum = "building"  # cold_start|building|rolling|peak|declining|crashed
    string attractor = "convergent"  # convergent|divergent|recovery|transfer

    # Routing weights (the Mycelium)
    float[] expert_weights = [0.15, 0.15, 0.10, 0.10, 0.10, 0.20, 0.20]
    # [Validator, Scaffolder, Restorer, Refocuser, Celebrator, Socratic, Direct]

    # Safety constraints
    float[] safety_floors = [0.10, 0.05, 0.05, 0.0, 0.0, 0.0, 0.0]

    # Learning parameters
    float learning_rate = 0.1
    float weight_decay = 0.05

    # ═══════════════════════════════════════════════════════════════
    # GROUNDING STATE (v7.0.0)
    # ═══════════════════════════════════════════════════════════════

    string grounding_mode = "LEARN"  # LEARN | ACCESS | HYBRID
    int oracle_cache_age = 0  # seconds since last oracle query (0-86400)
    int evidence_chain_length = 0  # number of oracle results in chain
    float hallucination_score = 0.0  # 0.0=grounded, 1.0=speculation
    int last_oracle_latency = 0  # ms (0-10000)
    int grounding_budget = 5  # depletes like tangent_budget
    string[] active_oracles = []  # list of available oracle IDs

    # ═══════════════════════════════════════════════════════════════
    # BCM STIGMERGIC STATE (v7.0.0)
    # ═══════════════════════════════════════════════════════════════

    int bcm_trail_version = 0  # increments on trail update
    float[] bcm_expert_confidence = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]  # per-expert confidence
    bool bcm_plasticity_active = false  # plasticity window open?
    float bcm_plasticity_sigma = 0.0  # learning rate multiplier (0.0-1.0)
    string bcm_last_update = ""  # ISO timestamp
    string bcm_plasticity_trigger = ""  # which condition opened window
    string bcm_trail_checksum = ""  # for integrity verification

    # ═══════════════════════════════════════════════════════════════
    # SIGNAL RELIABILITY (v7.0.0)
    # ═══════════════════════════════════════════════════════════════

    float[] signal_reliability = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]  # per-category
    # [emotional, grounding, mode, domain, task, energy]
    int signal_total_outcomes = 0  # total tracked outcomes
    string last_fingerprint = ""  # JSON of last signal fingerprint
}
```

**Field Count:** 37 (v5.0) → 44 (v7.0.0) — 7 new fields for grounding, BCM, and signal reliability.

---

## 5. Runtime Service Stack

### 5.1 Signal Aggregator (R3)

Collects signals from multiple applications with priority ordering:

```
Priority  Category    Description
────────  ──────────  ─────────────────────────────
1         SAFETY      Requires immediate protective response
2         AFFECTIVE   Emotional state signals
3         MODE        Cognitive mode transitions
4         DOMAIN      Task-domain triggers (from payloads)
5         CONTENT     Informational/task content
```

**Aggregation Rules:**
1. Temporal weighting (recent > old)
2. Safety signals bypass queue
3. Source trust weighting
4. Consensus detection (multiple sources = higher confidence)
5. Conflict resolution (higher category wins)

### 5.2 Routing Engine (R4) — 8-Phase NEXUS Pipeline (v7.0.0)

Eight-phase routing with deterministic properties and grounding support:

**Figure 1: 8-Phase NEXUS Routing Flow (v7.0.0)**

```
                            USER INPUT
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 0: RETRIEVE (Fast Path)                                        │
│  Knowledge check for factual queries → O(1) retrieval                 │
│  IF confidence ≥ 0.85: Return directly (skip phases 0b-5)             │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 0b: CLASSIFY (v7.0.0 - Grounding)                              │
│  Determine source mode: LEARN | ACCESS | HYBRID                       │
│  Grounding signals: physics, simulate, position, velocity, collision  │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 0c: GROUND (v7.0.0 - Oracle Query)                             │
│  IF source_mode ∈ {ACCESS, HYBRID}:                                   │
│    Query oracle registry → Execute deterministic query                │
│    Cache result with provenance (confidence = 1.0)                    │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 1: DETECT (formerly ACTIVATE)                                  │
│  ┌─────────────┐    ┌──────────────────┐    ┌──────────────────────┐ │
│  │   Signal    │───▶│  PRISM + BCM     │───▶│  Activation Vector   │ │
│  │  "stuck"    │    │  Fingerprinting  │    │  [0,0.8,0,0,0,0.2,0] │ │
│  └─────────────┘    └──────────────────┘    └──────────────────────┘ │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 2: CASCADE (formerly WEIGHT)                                   │
│  Safety gates → ADHD_MoE → GROUNDING_MoE → BCM confidence             │
│  activation × expert_weights × bcm_trail_modifier = weighted_scores   │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 3: LOCK (formerly BOUND)                                       │
│  ┌────────────────────┐  ┌────────────────────┐  ┌────────────────┐  │
│  │  Safety Floors     │  │  Homeostatic Norm  │  │  Parameter +   │  │
│  │  max(w, floor)     │─▶│  w / sum(w) = 1.0  │─▶│  BCM Lock      │  │
│  │  Validator ≥ 0.10  │  │                    │  │  (no variance) │  │
│  └────────────────────┘  └────────────────────┘  └────────────────┘  │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 4: EXECUTE (formerly SELECT)                                   │
│  expert = argmax(bounded_scores)                                      │
│  Tiebreaker: lower priority index wins                                │
│  Generate with locked params + oracle results (if grounded)           │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 5: UPDATE (Mycelium + BCM + Plasticity)                        │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────────┐   │
│  │  Outcome    │───▶│  Hebbian +  │───▶│  BCM Trail Update       │   │
│  │  (0.0-1.0)  │    │  BCM Queue  │    │  (QUEUED, not applied)  │   │
│  └─────────────┘    └─────────────┘    └─────────────────────────┘   │
│  Plasticity auto-trigger check: momentum=CRASHED → open window       │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  [POST] FLUSH (v7.0.0 - BCM Batch-Invariance)                         │
│  Batch apply all queued trail updates AFTER processing completes     │
│  Ensures: same inputs → same routing (trails are metadata only)       │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
                          EXPERT RESPONSE
```

**Determinism Guarantee:** Each phase is individually deterministic. Given identical input signal and state, the routing produces identical expert selection. BCM trail updates are QUEUED and applied AFTER processing, ensuring batch-invariance.

**Phase Details (v7.0.0):**

```
Phase 0: RETRIEVE (Fast Path)
  Factual query detection ("what is", "explain", "define")
  O(1) knowledge graph lookup (~0.001ms)
  Confidence ≥ 0.85 → Return directly (skip remaining phases)
  Deterministic (fixed triggers, fixed graph structure)

Phase 0b: CLASSIFY (Grounding)
  Detect grounding signals (physics, simulate, position, etc.)
  Determine source mode: LEARN | ACCESS | HYBRID
  Deterministic (fixed signal patterns)

Phase 0c: GROUND (Oracle Query)
  If ACCESS/HYBRID: Query oracle registry
  Execute deterministic oracle (e.g., Houdini RBD, Bullet physics)
  Cache result with provenance
  Deterministic (oracle is bit-identical, cache is hash-based)

Phase 1: DETECT
  Signal → PRISM Pattern Match → Activation Vector
  BCM signal fingerprint capture (QUEUED, not used in routing)
  Deterministic given fixed pattern dictionary (L0D)

Phase 2: CASCADE
  Safety gates → ADHD_MoE → GROUNDING_MoE (if applicable)
  weighted = activation × expert_weights
  BCM confidence is METADATA ANNOTATION only (does NOT affect selection)
  Deterministic (element-wise multiplication)

Phase 3: LOCK
  Apply safety floors (expert_weights >= safety_floors)
  Apply homeostatic limits (normalize to sum = 1)
  Lock parameters + grounding sources BEFORE generation
  Deterministic (fixed bounds, explicit locking)

Phase 4: EXECUTE
  expert = argmax(bounded_weighted)
  Tiebreaker: lower index wins
  Generate using locked params + oracle results
  Deterministic

Phase 5: UPDATE
  Hebbian learning, attractor dynamics, RC^+xi convergence
  BCM trail updates QUEUED (not applied during processing)
  Plasticity window check (CRASHED → open, CONVERGED → close)
  Deterministic given outcome

[POST] FLUSH
  Apply queued BCM trail updates
  Apply fingerprint-outcome correlations
  Happens AFTER response delivered
  Ensures batch-invariance: same inputs → same routing
```

### 5.3 Expert Archetypes

Domain-agnostic expert types (ADHD_MoE - first match wins):

| Priority | Expert | Purpose | Safety Floor |
|----------|--------|---------|--------------|
| 1 | Validator | Safety-first, empathy, emotional validation | 0.10 (hard) |
| 2 | Scaffolder | Break down complexity, reduce scope | 0.05 (hard) |
| 3 | Restorer | Recovery facilitation, energy restoration | 0.05 (hard) |
| 4 | Refocuser | Attention management, tangent redirect | 0.00 |
| 5 | Celebrator | Progress recognition, milestone acknowledgment | 0.00 |
| 6 | Socratic | Discovery facilitation, guided exploration | 0.00 |
| 7 | Direct | Direct task execution, minimal intervention | 0.00 |

**First match wins.** Safety experts are always checked first regardless of activation strength.

### 5.4 GROUNDING_MoE (v7.0.0)

When grounding signals are detected (Phase 0b), route to these specialists (first match wins):

| Priority | Expert | Triggers | Response |
|----------|--------|----------|----------|
| 1 | **OracleResolver** | oracle_conflict, mismatch | Reconcile multiple oracle sources |
| 2 | **EvidenceBuilder** | cite_needed, source_request | Build evidence chain from oracle |
| 3 | **ConfidenceAdj** | hallucination_detected | Adjust confidence, flag uncertainty |
| 4 | **AccessGatekeeper** | oracle_required, fresh_need | Route query to grounding layer |

**Source Mode Router:**

```
Mode     When                                  Behavior
───────  ────────────────────────────────────  ────────────────────────────────
LEARN    No oracle, reasoning required         Use LLM inference (default)
ACCESS   Oracle available, ground truth exists Route to oracle, trust result
HYBRID   Oracle + interpretation needed        Query oracle, then reason about result
```

**Grounding Signals (Auto-Detection):**

| Signal Pattern | Detected Mode | Example |
|----------------|---------------|---------|
| "where is X at time T" | ACCESS | "Where is the ball at frame 48?" |
| "will X hit Y" | ACCESS | "Will the ball hit the ground?" |
| "how fast is X moving" | ACCESS | "What's the ball's velocity?" |
| "predict X over time" | ACCESS | "Trace the ball's trajectory" |
| "why did X happen" | HYBRID | "Why did the ball bounce higher?" |
| "what should I do about X" | LEARN | "How should I fix this physics bug?" |

### 5.5 Intervention Dispatch (R2)

Translates expert recommendations to application-specific interventions:

| Strategy | Behavior | Experts |
|----------|----------|---------|
| COORDINATED | All applications respond | Validator |
| EXCLUSIVE | Foreground application only | Scaffolder, Celebrator, Socratic, Direct |
| ENVIRONMENTAL | Background applications | Restorer |
| CASCADING | Primary + environment | Refocuser |

**Adapter Pattern:** Each application registers an adapter that composes interventions for its modality (text, environment changes, notifications).

### 5.5 Temporal Orchestrator (R5)

Manages session lifecycle and cross-session learning:

**Aggregation Chain:**
```
Sessions → Daily (weighted by duration × outcome)
Daily → Weekly (day-of-week patterns)
Weekly → Calibration (long-term adjustments)
```

**Learning Rates:**
```
Within session:  α = 0.10  (fast adaptation)
Session → Daily: α = 0.05  (moderate)
Daily → Weekly:  α = 0.02  (slow)
Weekly → Calib:  α = 0.01  (very slow)
```

### 5.6 Context Restorer (R6)

Enables session continuity with staleness-aware restoration:

| Staleness | Duration | Restoration Protocol |
|-----------|----------|---------------------|
| MICRO | <15 min | Silent refocus |
| SESSION | 15min-4h | Rebuild momentum, offer environment restore |
| DAY | 4-16h | Morning restoration, validate relevance |
| WEEK | 3-10d | Require validation, describe environment |
| DEEP | >10d | May be obsolete, offer fresh start |

**Snapshot Contents:**
- Task state (active, completed, pending, intended next)
- Cognitive state (energy, momentum, weights, attractor)
- Environmental state (files, tabs, cursor position)
- Anchors (decisions made, insights discovered, open questions)

---

## 6. The Mycelium Mechanism

The Mycelium is the substrate's neuroplasticity system—how it learns and adapts while maintaining safety guarantees.

### 6.1 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     HARD BOUNDS (Immutable)                      │
│                                                                  │
│  Safety Floors: expert_weights >= safety_floors                 │
│  Homeostatic Limits: energy ∈ [0,1], sum(weights) = 1          │
│  Constitutional Constraints: Never overridden                   │
│                                                                  │
│                          ↓ constrains                            │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │           DYNAMIC ADAPTATION (Within Bounds)               │  │
│  │                                                            │  │
│  │  Hebbian Learning + Attractor Dynamics + Homeostasis      │  │
│  │                                                            │  │
│  └───────────────────────────────────────────────────────────┘  │
│                          ↑ receives                              │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │              ACTIVATION SPREADING (Input)                  │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2 Rebalancing Avenues

**Avenue 1: Activation Spreading**

Signals spread activation across the expert network:

```
Signal: "frustrated"
Activation: Validator=0.8, Scaffolder=0.3, Restorer=0.4, ...
```

The spreading function is fixed; learned associations are stored in USD.

**Avenue 2: Hebbian Learning**

Routes that lead to positive outcomes strengthen:

```
w_new = w_old + α(outcome - expected) × activation
```

Where:
- α = learning rate (from calibration)
- outcome = measured result [-1, 1]
- expected = baseline expectation
- activation = how strongly this expert was used

**Avenue 3: Attractor Dynamics**

State vectors have gravity toward attractor basins:

```
Basins: convergent, divergent, recovery, transfer

State vector: [energy, momentum, load, coherence]
Distance to each basin computed
Weights drift toward nearest basin's optimal configuration
Transition thresholds prevent oscillation
```

**Avenue 4: Homeostatic Regulation**

System maintains equilibrium:

```
IF energy_spent > energy_recovered for N exchanges:
   → Increase Restorer weight

IF focus_coherence declining:
   → Increase Refocuser weight

IF cognitive_load > threshold:
   → Increase Scaffolder weight
```

### 6.3 Bound Enforcement

All dynamic adaptation is constrained:

1. Safety floors are hard minimums
2. Weights are normalized after every update
3. Constitutional constraints cannot be violated
4. Learning cannot exceed rate limits

### 6.4 Formal Mathematical Specification

**Definition 1 (Weight Space)**
Let W = {w ∈ ℝ^7 | w_i ≥ f_i ∀i ∈ [1,7], Σw_i = 1}
where f = [0.10, 0.05, 0.05, 0, 0, 0, 0] are safety floors.

**Definition 2 (Activation Function)**
A: T × C → ℝ^7 where T is task space, C is context space.
A(t, c)_i = min(|{p ∈ triggers_i : p ⊆ t}| / |triggers_i|, 1.0)

**Definition 3 (Hebbian Update)**
U: W × ℝ × ℝ^7 → W
U(w, o, a)_i = clip(w_i + α(o - e)a_i, f_i, 1.0) / Z
where Z normalizes to sum=1, α ∈ (0, 0.2], o ∈ [-1, 1], e = 0.5

**Theorem 1 (Safety Floor Invariant)**
∀w ∈ W, ∀o, a: U(w, o, a) ∈ W
*Proof*: By construction, clip enforces w_i ≥ f_i, and Z normalizes sum to 1. ∎

**Theorem 2 (Bounded Learning)**
|U(w, o, a)_i - w_i| ≤ α × max(|o - e|) × max(||a||_∞) ≤ 0.2 × 1 × 1 = 0.2
*Proof*: By definition of clip and bounds on α, o, a. ∎

**Theorem 3 (Convergence)**
Under stationary outcome distribution, w converges to E[o × a] / Σ_i E[o × a_i].
*Proof sketch*: Standard Hebbian convergence with decay. Full proof in Appendix D.

### 6.5 BCM Stigmergic Reinforcement Learning (v7.0.0)

**Core Principle: "Trails, Not Orders"**

BCM (Bienenstock-Cooper-Munro) learning provides metadata about expert effectiveness but NEVER changes the deterministic routing order. This maintains ThinkingMachines batch-invariance.

**Trail-Based Expert Confidence:**

Each expert has a Trail tracking success rates:

```python
class OrchestraTrail:
    expert_id: str
    strength: float  # 0.01 - 100.0 (pheromone-like)
    success_rate: float  # 0.0 - 1.0
    total_outcomes: int
    successful_outcomes: int

    @property
    def confidence(self) -> float:
        return 0.6 * self.success_rate + 0.4 * (self.strength / 100.0)
```

**BCM Saturation (Homeostasis):**

The sliding threshold θ_m decreases as activity increases, preventing unbounded growth:

```
θ_m(t) = θ_m(t-1) × decay_factor + (1 - decay_factor) × recent_activity
saturation_factor = 1 / (1 + exp(-(strength - θ_m) / temperature))
update = base_update × saturation_factor
```

**Time-Based Decay:**

Trail strength decays exponentially with a 2-hour half-life:

```
decay = exp(-time_elapsed / half_life)
new_strength = old_strength × decay
```

**ThinkingMachines Compliance (CRITICAL):**

```
✓ Trail updates QUEUED during processing (Phase 5)
✓ Queued updates applied AFTER response delivered ([POST] FLUSH)
✓ Same inputs → same routing (trails are metadata only)
✓ BCM confidence annotates decisions, does NOT affect selection order
✓ Batch-invariant: routing identical regardless of trail state
```

### 6.6 Plasticity Auto-Triggers (v7.0.0)

Plasticity windows open/close automatically based on cognitive state:

| Condition | Action | Effect |
|-----------|--------|--------|
| momentum=CRASHED + burnout≥ORANGE | Open plasticity | Learning rate × 2 |
| burnout=RED | Open plasticity | Learning rate × 1.5 |
| converged + stable_exchanges ≥ 3 | Close plasticity | Normal learning |

**Plasticity State Schema:**

```python
sigma: float  # 0.0 - 1.0, learning rate multiplier
window_trigger: str  # Which condition opened window
window_opened_at: datetime
```

**Applied in Phase 5 (UPDATE):**

```
effective_learning_rate = base_rate × (1 + sigma × plasticity_multiplier)
```

### 6.7 Signal Reliability Tracking (v7.0.0)

**Signal Fingerprinting:**

Compact capture of primary signal per category:

```python
fingerprint = {
    "emotional": "frustrated",  # Primary emotional signal
    "task": "debug",           # Primary task signal
    "grounding": None          # No grounding signal
}
```

**Reliability Score:**

```
reliability = successful_outcomes / total_outcomes
lookback_window = 50  # Recent outcomes only
default = 1.0  # Until evidence suggests otherwise
```

**Purpose:** Correlation between signal fingerprints and routing outcomes enables predictive confidence adjustment.

### 6.8 Worked Example: Complete Routing Trace

**User Input**: "I'm completely stuck on this architecture decision and feeling overwhelmed"

**Step 1: Signal Detection**
```
Pattern matching:
- "stuck" → Scaffolder trigger ✓
- "overwhelmed" → Validator trigger ✓

Activation vector A(task):
  Validator:    1/8 triggers = 0.125 (but "overwhelmed" strong signal)
  Scaffolder:   1/8 triggers = 0.125 (but "stuck" strong signal)
  [others]:     0/n triggers = 0.000
```

**Step 2: Weight Calculation**
```
Current weights w: [0.15, 0.15, 0.10, 0.10, 0.10, 0.20, 0.20]
Activations a:     [0.80, 0.30, 0.00, 0.00, 0.00, 0.00, 0.00]
Weighted w×a:      [0.12, 0.05, 0.00, 0.00, 0.00, 0.00, 0.00]
```

**Step 3: Safety Floor Enforcement (BOUND phase)**
```
Pre-floor:   [0.12, 0.05, 0.00, 0.00, 0.00, 0.00, 0.00]
Floors:      [0.10, 0.05, 0.05, 0.00, 0.00, 0.00, 0.00]
Check:       [✓,    ✓,    ✗,    ✓,    ✓,    ✓,    ✓]
Post-floor:  [0.12, 0.05, 0.05, 0.00, 0.00, 0.00, 0.00]
Normalized:  [0.55, 0.23, 0.23, 0.00, 0.00, 0.00, 0.00]
```

**Step 4: Selection (SELECT phase)**
```
Winner: Validator (0.55)
Tiebreaker: N/A (clear winner)
```

**Step 5: Response Generation**
```
Expert: Validator
Response: "I notice you're feeling stuck and overwhelmed. Let's pause
          the architecture decision and address how you're feeling first.
          What's the main source of the overwhelm?"
```

**Step 6: Outcome & Learning (UPDATE phase)**
```
User feedback: +0.8 (helpful response)
Hebbian update: w_validator += 0.1 × (0.8 - 0.5) × 0.8 = +0.024
New weights: [0.174, 0.15, 0.10, ...] → normalize → [0.18, 0.15, ...]
```

---

## 7. Multi-Agent Composition: The Mycelium Arc

### 7.1 The Problem

LIVRPS provides vertical composition (layers override layers). Multi-agent systems require horizontal composition (agents share state).

### 7.2 The Mycelium Arc

A new composition arc with peer-to-peer semantics:

```usda
def "AgentB" (
    mycelium = </AgentA>
) {
    # FLOWS through mycelium:
    float momentum_phase      # Inherited unless locally overridden
    float epistemic_tension   # Additive (tensions compound)
    string attractor_basin    # Inherited unless divergent

    # SAFETY-MAX through mycelium:
    string burnout_level      # MAX(AgentA, AgentB) - conservative

    # DOES NOT FLOW:
    string[] files_read       # Agent-specific context
    int message_count         # Agent-specific
}
```

**Key Semantic:** Burnout takes MAX, not override. Safety is never diluted by handoff.

### 7.3 Dynamic Resource Routing

The Mycelium arc enables bidirectional flow based on need:

```
Agent A (exploring, high momentum) ←→ Agent B (implementing, cold start)
        └── momentum flows TO Agent B
        └── tangent budget flows FROM Agent B (it needs focus)
```

---

## 8. Grounding Layer (L7.5) — v7.0.0

The Grounding Layer implements the "ACCESS over LEARN" paradigm from the Grounded World Model research.

### 8.1 Core Thesis

> **LLMs don't need to LEARN [X]—they need ACCESS to [X].**
>
> This thesis generalizes beyond physics: For any domain with reliable oracles,
> accessing ground truth is superior to learning approximations.

### 8.2 Experimental Validation

| Experiment | Domain | Oracle | Result |
|------------|--------|--------|--------|
| RBD Verification | Physics | Houdini RBD | 710/710 determinism (100%) |
| Experiment 1 | Constraint Satisfaction | Backtracking Solver | 10/10 determinism (hash: fc23a00c926e) |
| Experiment 2 | USD Unity | LIVRPS Composition | 10/10 determinism (hash: e89e5138077c) |

**Experiment 1 Key Finding**: Graph coloring (NP-complete) — LEARN mode produces 3 violations, ACCESS mode finds valid 3-coloring. Proves ACCESS paradigm generalizes to combinatorics.

**Experiment 2 Key Finding**: USD composition semantics provide identical deterministic resolution for cognitive state AND physical world state. 32/32 edge cases passing, 1.85ms average latency.

### 8.3 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GROUNDING LAYER (L7.5)                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Query → Source Router → ACCESS?                               │
│                              ↓ Yes                              │
│                         Oracle Registry → Query Oracle          │
│                              ↓                                  │
│                         Evidence Warehouse (cache + provenance) │
│                              ↓                                  │
│                         Return deterministic result             │
│                                                                 │
│                              ↓ No (LEARN mode)                  │
│                         Continue to LLM inference               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 8.4 Oracle Registry

Registered oracles provide deterministic ground truth:

| Oracle ID | Domain | Latency | Determinism |
|-----------|--------|---------|-------------|
| `houdini_rbd` | Physics (RBD) | ~26ms | 100% |
| `bullet_physics` | Collision | ~15ms | 100% |
| `knowledge_graph` | Facts | ~0.001ms | 100% |
| `backtrack_solver` | Constraint Satisfaction | ~5ms | 100% |

**Fallback Chain**: Oracle (ACCESS) → Cache (if fresh) → Knowledge (RETRIEVE) → LLM (LEARN)

### 8.5 Evidence Warehouse

When ACCESS mode returns oracle results, evidence is tracked:

```
evidence_chain: [
  {source: "houdini_rbd", query: "position(ball, 48)", result: "Vec3(0,1,0)", timestamp: T}
]
provenance: oracle_id + query_hash + timestamp
confidence: 1.0 (oracle is authoritative)
```

### 8.6 Determinism Guarantees

```
Theorem: Grounded queries produce deterministic results.

Proof:
1. Oracle is deterministic (e.g., Bullet physics with fixed seed)
2. Query translation is deterministic (fixed prompt, temperature=0)
3. Cache lookup is deterministic (hash-based)
4. Composition of deterministic functions is deterministic ∎

Empirical validation: 710/710 queries (100%) bit-identical across sessions
```

### 8.7 Hallucination Detection

When NOT in ACCESS mode, monitor for hallucination signals:

| Signal | Detection | Action |
|--------|-----------|--------|
| Physics claim without oracle | "The ball will land at X" (no query) | Flag, suggest ACCESS |
| Confidence mismatch | High confidence on ungrounded claim | Reduce confidence, caveat |
| Oracle contradiction | LLM output conflicts with cached oracle | Use oracle, note discrepancy |

### 8.8 USD Unity (Unified State Description)

The Grounding Layer achieves a conceptual unification:

```
┌─────────────────────────────────────────────────────────────────┐
│                USD AS UNIVERSAL STATE DESCRIPTION               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   USD (Pixar)        Cognitive Substrate    Grounded World Model│
│   ─────────────────────────────────────────────────────────────│
│   Scene Graph    →   Cognitive Architecture → World State Graph │
│   Prims          →   State Fields          → Physical Objects  │
│   Attributes     →   Parameters            → Position/Velocity │
│   Composition    →   Priority Resolution   → Oracle > Inference│
│   Layers         →   Subsystems (L0-L13)   → Evidence Layers   │
│   Payloads       →   Domain Knowledge      → Simulation Results│
│   Variants       →   Mode Switching        → LEARN/ACCESS/HYBRID│
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**LIVRPS Composition Order** (Oracle overrides Cognitive):
```
LOCAL       → Oracle results (HIGHEST - wins on conflict)
INHERITS    → Grounding context
VARIANTS    → Source mode switching
REFERENCES  → Cache state
PAYLOADS    → Oracle registry
SPECIALIZES → Cognitive base state (LOWEST)
```

---

## 9. Determinism Analysis

**Figure 3: Determinism Boundary**

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         STOCHASTIC (Irreducible)                            │
│                              Human Agency                                   │
│  ┌─────────────────┐                              ┌─────────────────┐      │
│  │   USER INPUT    │                              │  USER RESPONSE  │      │
│  │  (what they     │                              │  (how they      │      │
│  │   type)         │                              │   react)        │      │
│  └────────┬────────┘                              └────────▲────────┘      │
│           │                                                │               │
└───────────┼────────────────────────────────────────────────┼───────────────┘
            │                                                │
            ▼                                                │
┌───────────────────────────────────────────────────────────────────────────┐
│                    DETERMINISTIC (With ThinkingMachines)                   │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │                                                                     │  │
│  │   Signal      5-Phase       Expert        LLM         State        │  │
│  │  Detection → Routing   →  Selection  → Generation → Update        │  │
│  │                                                                     │  │
│  │  ✓ Pattern    ✓ ACTIVATE   ✓ argmax     ✓ Batch-    ✓ USD         │  │
│  │    match      ✓ WEIGHT     ✓ tiebreak     invariant   compose     │  │
│  │  ✓ L0D dict   ✓ BOUND                     kernels                 │  │
│  │               ✓ SELECT                                             │  │
│  │               ✓ UPDATE                                             │  │
│  │                                                                     │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  GUARANTEE: Same input + Same state → Same output + Same state update     │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘
```

The architecture isolates all stochasticity to human agency boundaries. Everything between user input and user response is deterministic when using ThinkingMachines batch-invariant kernels.

### 8.1 Stochastic Boundaries

Without batch-invariant inference:

| Step | Component | Deterministic? |
|------|-----------|----------------|
| 1 | User input | NO (human) |
| 2 | Signal detection (pattern) | YES |
| 2 | Signal detection (semantic) | NO (LLM variance) |
| 3-6 | Routing core | YES |
| 7 | LLM generation | NO (batch variance) |
| 8 | User response | NO (human) |
| 9 | Outcome detection | PARTIAL |
| 10 | State update | YES |

### 8.2 With ThinkingMachines

ThinkingMachines provides batch-invariant kernels that guarantee identical outputs regardless of batch size:

| Operation | Batch-Invariant Strategy | Performance Cost |
|-----------|-------------------------|------------------|
| **RMSNorm** | Data-parallel: assign each batch element to one core, maintaining identical reduction order regardless of batch size | Minimal |
| **Matrix Multiplication** | Fixed tensor-core instructions and tile sizes across all batch sizes; avoid split-K optimization | ~20% vs cuBLAS |
| **Attention** | Fixed split-SIZE (not split-count) for KV dimension; reduction order for a given token doesn't depend on batch | Optimized: 1.6x total |

**Key Implementation Detail**: KV cache and page tables must be updated before the attention kernel to maintain consistent memory layout regardless of token processing strategy.

**Result:** All LLM-dependent operations become deterministic. The same request produces identical output whether batch=1 or batch=1000.

| Step | Component | Deterministic? |
|------|-----------|----------------|
| 1 | User input | NO (human - irreducible) |
| 2 | Signal detection | YES (batch-invariant) |
| 3-6 | Routing core | YES |
| 7 | LLM generation | YES (batch-invariant) |
| 8 | User response | NO (human - irreducible) |
| 9 | Outcome detection | YES (batch-invariant) |
| 10 | State update | YES |

### 8.3 Reproducibility Contract

```
GIVEN:
  1. Identical user input string
  2. Identical USD state
  3. Identical timestamp
  4. Same model version
  5. Same hardware configuration

GUARANTEE:
  ✓ Identical signal detection
  ✓ Identical routing decision
  ✓ Identical LLM response
  ✓ Identical state update
  ✓ Identical checksum

STOCHASTIC (Irreducible):
  - What the user types
  - How the user responds
```

### 8.4 Requirements for Full Determinism

| Requirement | Purpose |
|-------------|---------|
| L0D Specification | Fixed pattern dictionary, activation matrix, tiebreakers |
| Canonical Prompt Templates | Same expert + context → same prompt |
| Fixed Model Version | Model updates change behavior |
| Fixed Hardware Config | Per ThinkingMachines limitation |
| Canonical State Serialization | Deterministic USD → string |
| ThinkingMachines Kernels | Batch-invariant inference (~1.6x overhead) |

### 8.5 Failure Modes and Recovery

The system is designed to fail gracefully:

| Failure Mode | Cause | Detection | Recovery |
|--------------|-------|-----------|----------|
| **FM1: State Corruption** | Disk failure, concurrent write | Checksum mismatch | Load previous snapshot; reset to calibration if all corrupted |
| **FM2: Signal Conflict** | "frustrated" + "just do it" | Multiple high activations | Priority ordering (Protector wins) |
| **FM3: Weight Explosion** | Extreme outcomes without decay | Any w_i > 0.95 | Apply decay, re-normalize |
| **FM4: ThinkingMachines Unavailable** | Fallback to standard inference | Batch-invariance check fails | Mark session non-reproducible, increase logging |
| **FM5: Cold Start** | New user, no history | Uniform weights detected | Calibration wizard for initial preferences |

**Recovery Hierarchy:**
1. Attempt operation with current state
2. Load most recent valid snapshot
3. Reset to calibration defaults
4. Reset to profile defaults (constitutional constraints only)

**Safety Invariant:** At no point in the recovery hierarchy can safety floors be violated.

---

## 9. Payload Architecture

### 9.1 Design Principle

The core substrate is neurotype-agnostic and domain-agnostic. Specializations are loaded as payloads that adjust weights and add signals.

### 9.2 Payload Structure

```usda
def "ADHDPayload" {
    # Weight adjustments
    float[] weight_adjustments = [0.0, +0.05, +0.05, +0.03, 0.0, 0.0, -0.03]
    # Increase Scaffolder, Restorer, Refocuser; decrease Direct

    # Floor adjustments
    float scaffolder_floor = 0.10  # Raised from 0.05

    # Added signals
    string[] additional_signals = [
        "time_blindness",
        "hyperfocus_detection",
        "working_memory_overflow"
    ]

    # Parameter adjustments
    float tangent_budget = 3.0  # Reduced from 5.0
}
```

### 9.3 Available Payloads

| Payload | Adjustments |
|---------|-------------|
| ADHD | Higher Scaffolder/Restorer floors, time signals, reduced tangent budget |
| Anxiety | Higher Validator floor, uncertainty signals, slower state transitions |
| Autism | Higher Direct preference, routine disruption signals, explicit communication |
| VFX Domain | Domain triggers (usd, houdini, render), specialized expertise |
| WebDev Domain | Domain triggers (react, next, api), specialized expertise |

---

## 10. Implementation

### 10.1 Python SDK Interface

```python
from cognitive_substrate import Substrate, Signal

# Initialize
substrate = Substrate(storage_path="~/.cognitive/state.usda")
substrate.load_payload("adhd")

# Signal reporting
substrate.signal(Signal(
    category="affective",
    content="frustrated",
    source="claude_code"
))

# Get routing
expert = substrate.route()  # Deterministic

# Report outcome
substrate.outcome(expert=expert, result=0.7)

# State persists to USD automatically
```

### 10.2 Multi-Application Integration

```python
# Multiple apps share state
browser = Substrate(storage="~/.cognitive/state.usda", source="browser")
editor = Substrate(storage="~/.cognitive/state.usda", source="editor")

# Both report signals
browser.signal(Signal(category="mode", content="15 tabs opened"))
editor.signal(Signal(category="content", content="high keystroke rate"))

# Aggregator combines signals
# Routing uses combined signal vector
```

### 10.3 Storage Layout

```
~/.cognitive/
├── current.usda              # Live session state
├── snapshots/                # Context restoration points
├── sessions/                 # Archived sessions
├── daily/                    # Aggregated daily states
├── weekly/                   # Aggregated weekly states
├── calibration.usda          # Long-term patterns
├── profile.usda              # Base traits
└── payloads/                 # Specializations
    ├── adhd.usda
    ├── anxiety.usda
    └── vfx_domain.usda
```

---

## 11. Evaluation Criteria

### 11.1 Reproducibility

**Metric:** Given identical inputs and state, percentage of runs producing identical outputs.

**Target:** 100% with ThinkingMachines; <100% without.

**Method:** Replay recorded sessions, compare checksums.

### 11.2 Adaptation Quality

**Metric:** Does Hebbian learning improve routing over time?

**Method:** Track outcome distributions before/after calibration updates.

### 11.3 Safety Guarantee

**Metric:** Do safety floors hold under all conditions?

**Method:** Formal verification that update functions cannot violate floors.

### 11.4 Context Restoration Accuracy

**Metric:** After restoration, can users continue without re-establishing context?

**Method:** User study measuring time-to-productivity after breaks.

### 11.5 CogRoute-Bench Results

The reference implementation was evaluated on CogRoute-Bench, a standardized benchmark with 37 routing tasks across 8 categories:

**Figure 4: CogRoute-Bench Results**

```
                           CogRoute-Bench v1.0
    ═══════════════════════════════════════════════════════════════

    OVERALL METRICS
    ────────────────────────────────────────────────────────────────
    Accuracy        ████████████████████████████████████████░░  94.6%
    Determinism     ████████████████████████████████████████████ 100.0%
    Explainability  ████████████████████████████████████████░░░  95.1%

    BY CATEGORY (% correct)
    ────────────────────────────────────────────────────────────────
    safety_critical  ████████████████████████████████████████████ 100%
    recovery         ████████████████████████████████████████████ 100%
    redirection      ████████████████████████████████████████████ 100%
    acknowledgment   ████████████████████████████████████████████ 100%
    exploration      ████████████████████████████████████████████ 100%
    ambiguous        ████████████████████████████████████████████ 100%
    complexity       ████████████████████████████████░░░░░░░░░░░░  80%
    execution        ████████████████████████████████████░░░░░░░░  83%

    PERFORMANCE
    ────────────────────────────────────────────────────────────────
    Average Latency: 0.13ms per routing decision
    Total Tasks:     37
    Correct:         35
    Failures:        2 (complexity → socratic, ambiguous direct)

    ═══════════════════════════════════════════════════════════════
```

**Key Result:** 100% determinism achieved—identical inputs produce identical routing decisions across all runs.

---

## 12. Related Work

### 12.1 Cognitive Architectures

- **ACT-R** (Anderson): Production system with memory modules; no determinism guarantees
- **SOAR** (Laird): Goal-oriented with learning; no composition semantics
- **LIDA** (Franklin): Global workspace theory; no persistent state format

### 12.2 LLM State Management

- **LangChain Memory**: Simple key-value; no composition or conflict resolution
- **MemGPT**: Tiered memory with LLM-controlled paging; not deterministic
- **Anthropic Constitution**: Safety constraints; different layer (content filtering vs. routing)

### 12.3 Deterministic Inference

- **ThinkingMachines**: Batch-invariant kernels; we build upon this
- **vLLM**: Optimized serving; not deterministic
- **TensorRT-LLM**: Compilation; determinism not guaranteed

---

## 13. Future Directions

### 13.1 Near-Term

1. **USDZ Binary Compilation** — 10x parsing performance improvement
2. **Formal Verification** — Prove safety floor invariants
3. **Cross-Platform SDK** — Python, TypeScript, Rust bindings

### 13.2 Medium-Term

1. **Federated Learning** — Aggregate patterns across users while preserving privacy
2. **Natural Language Configuration** — "I want an expert that..." → USD payload
3. **Real-Time Visualization** — 3D cognitive state dashboard

### 13.3 Long-Term

1. **OpenUSD Standardization** — Propose cognitive extensions to USD spec
2. **Hardware Security** — TPM/HSM for PROTECTED data classification
3. **Multi-Model Orchestration** — Route to specialized models based on state

---

## 13.4 Known Limitations

1. **Keyword-Based Signal Detection**: Triggers rely on keyword matching. Semantic understanding requires LLM in the loop, reintroducing non-determinism. Future work: learned embeddings with quantized similarity.

2. **Single-Model Assumption**: Current design assumes one LLM. Multi-model routing (e.g., different models for different experts) adds complexity not addressed in this specification.

3. **Cold Start Problem**: New users have uniform weights. Initial sessions may have suboptimal routing until Hebbian learning accumulates data. Mitigation: Calibration wizard.

4. **Memory vs. Compute Tradeoff**: ThinkingMachines batch-invariance has performance cost: 2.1x slowdown with unoptimized kernels, 1.6x with optimized attention. MatMul specifically costs ~20% vs cuBLAS. For latency-sensitive applications, this may require hybrid mode (deterministic for routing, probabilistic for generation).

5. **USD Ecosystem Maturity**: While USD is an industry standard for VFX, its ecosystem outside VFX is nascent. Python pxr bindings are mature; other languages less so.

---

## 13.5 Falsifiability Criteria

The USD Cognitive Substrate thesis would be **FALSIFIED** if:

1. **Composition Failure**: LIVRPS resolution produces paradoxes or undefined behavior in >1% of real-world state configurations.

2. **Learning Instability**: Mycelium weights oscillate indefinitely or converge to degenerate configurations (all weight on one expert) in normal usage.

3. **Safety Floor Violation**: Any execution path exists that allows expert weights to fall below safety floors.

4. **Determinism Failure**: With ThinkingMachines, identical inputs produce different outputs in >0.01% of cases.

5. **Practical Inferiority**: A simpler system (JSON + rules) achieves equivalent routing accuracy with <50% of the specification complexity.

**Claims NOT Subject to Falsification** (by design):
- Human input stochasticity is irreducible (definitional)
- Constitutional constraints are immutable (axiomatic)

---

## 14. Conclusion

The USD Cognitive Substrate demonstrates that USD composition semantics—designed for visual effects pipeline conflict resolution—are equally applicable to cognitive state management in LLM applications.

The key contributions:

1. **Separation of storage and routing** enables clear architectural boundaries
2. **The Mycelium mechanism** provides bounded neuroplasticity
3. **The Mycelium Arc** enables multi-agent state composition
4. **Integration with batch-invariant inference** achieves full determinism

When deployed with ThinkingMachines kernels, the system provides a formally verifiable guarantee: **same input + same state → same output**. This transforms LLM applications from probabilistic systems into deterministic functions, enabling reproducibility, testing, auditing, and accountability.

The only remaining stochasticity is human agency—what users type and how they respond—which is not a limitation but a feature: the system respects human autonomy while providing consistent, learnable, verifiable AI behavior.

---

## 13. Cognitive Batch Invariance (v7.1.0 Extension)

Version 7.1.0 extends the architecture with formal guarantees for memory-level determinism, applying ThinkingMachines principles from LLM inference to cognitive state operations.

### 13.1 The Parallel Problem

ThinkingMachines identified that LLM non-determinism stems from batch-size-dependent reduction order. We observe an identical problem in cognitive state:

| LLM Inference | Cognitive Assembly |
|---------------|-------------------|
| Batch size varies | # of memories varies |
| ↓ | ↓ |
| Reduction order changes | Template matching order changes |
| ↓ | ↓ |
| Different logits | Different context injection |
| ↓ | ↓ |
| **NONDETERMINISM** | **NONDETERMINISM** |

### 13.2 CognitiveDeterminismAPI

```yaml
schemas:
  CognitiveDeterminismAPI:
    description: |
      Guarantees deterministic behavior for cognitive operations.
      Applied to assembly root to enable determinism constraints.

    attributes:
      cognitive:determinismMode:
        type: "token"
        values: ["strict", "relaxed", "none"]
        default: "strict"
        description: |
          strict: All operations must be deterministic
          relaxed: Best-effort determinism (allows optimizations)
          none: No determinism guarantees (maximum performance)

      cognitive:hashSeed:
        type: "int64"
        default: 0xCAFEBABE
        description: |
          Seed for any randomized operations.
          Same seed + same inputs = same outputs.

      cognitive:templateMatchOrder:
        type: "token"
        values: ["lexicographic", "priority", "chronological", "hash"]
        default: "lexicographic"
        description: |
          How to order template matching when multiple templates could match.
          MUST be fixed regardless of batch size.

      cognitive:aggregationOrder:
        type: "token"
        values: ["id_ascending", "confidence_descending", "chronological", "hash"]
        default: "id_ascending"
        description: |
          Order for aggregating multiple instances into context.
          This is the "reduction order" for cognitive state.

      cognitive:deterministicHash:
        type: "string"
        computed: true
        description: |
          SHA-256 hash of expanded cognitive state.
          Same hash = same state (for verification).
```

### 13.3 Fixed Tile Size Strategy

From ThinkingMachines: "To achieve batch invariance, we must adopt a fixed split-size strategy."

**Constant Definition:**
```python
COGNITIVE_TILE_SIZE = 32  # Fixed, never changes
DETERMINISM_SEED = 0xCAFEBABE  # Fixed seed for any randomized operations
```

**Implementation:**
```python
# WRONG: Adaptive batch size (causes nondeterminism)
def expand_memories(memories, system_load):
    batch_size = 100 / system_load  # NONDETERMINISTIC
    for batch in chunk(memories, batch_size):
        yield expand_batch(batch)

# CORRECT: Fixed tile size (deterministic)
def expand_memories(memories):
    for batch in chunk(memories, COGNITIVE_TILE_SIZE):
        yield expand_batch(batch)  # DETERMINISTIC
```

### 13.4 CognitiveAggregationAPI

```yaml
schemas:
  CognitiveAggregationAPI:
    description: |
      Defines deterministic aggregation rules for confidence combination.
      Equivalent to "reduction strategy" in LLM inference.

    attributes:
      cognitive:aggregationStrategy:
        type: "token"
        values: ["max", "mean", "weighted_mean", "decay_mean", "threshold_filter"]
        default: "max"
        description: |
          max: Highest confidence wins (simple, fast)
          mean: Average all confidences (Kahan summation)
          weighted_mean: Weight by access_count or recency
          decay_mean: Apply temporal decay before averaging
          threshold_filter: Only include above threshold, then max

      cognitive:conflictResolution:
        type: "token"
        values: ["newest_wins", "highest_confidence", "manual", "merge"]
        default: "newest_wins"
        description: "How to handle conflicting memories"

      cognitive:thresholdMinimum:
        type: "float"
        default: 0.5
        description: "Minimum confidence to include in context"
```

**Aggregation Implementations:**

```python
def aggregate_confidences(instances, strategy, config):
    """
    Aggregate confidences with determinism guarantee.
    CRITICAL: Sort FIRST, then aggregate.
    """
    # CRITICAL: Sort first for determinism
    sorted_instances = sorted(
        instances,
        key=lambda i: deterministic_sort_key(i, config.aggregation_order)
    )

    if strategy == "max":
        return max(i.confidence for i in sorted_instances)

    elif strategy == "mean":
        # Kahan summation for batch-invariant accumulation
        return kahan_sum([i.confidence for i in sorted_instances]) / len(sorted_instances)

    elif strategy == "weighted_mean":
        total_weight = sum(i.access_count for i in sorted_instances) or 1
        weighted = [i.confidence * i.access_count / total_weight for i in sorted_instances]
        return kahan_sum(weighted)

    elif strategy == "threshold_filter":
        filtered = [i for i in sorted_instances if i.confidence >= config.threshold]
        return max(i.confidence for i in filtered) if filtered else 0.0


def kahan_sum(values):
    """Kahan summation for numerical stability (batch-invariant)."""
    total = 0.0
    compensation = 0.0
    for value in values:
        y = value - compensation
        t = total + y
        compensation = (t - total) - y
        total = t
    return total
```

### 13.5 CognitiveRetrievalAPI

```yaml
schemas:
  CognitiveRetrievalAPI:
    description: |
      Batch-invariant memory retrieval.
      Same query always returns same results.

    attributes:
      cognitive:retrievalStrategy:
        type: "token"
        values: ["exact", "semantic", "hybrid"]
        default: "exact"

      cognitive:maxResults:
        type: "int"
        default: 100
        description: "Fixed limit (not adaptive to system load)"

      cognitive:sortOrder:
        type: "token"
        values: ["confidence_desc", "recency_desc", "relevance_desc", "id_asc"]
        default: "confidence_desc"
        description: "Deterministic sort order for results"

      cognitive:tileSize:
        type: "int"
        default: 32
        description: |
          Fixed tile size for retrieval batching.
          From ThinkingMachines: "fixed split-size preserves batch invariance"

    invariance_guarantees:
      query_invariance: "Same query + same memory bank = same results"
      batch_invariance: "Result independent of concurrent queries"
      order_invariance: "Results in consistent order regardless of retrieval batch size"
```

### 13.6 CognitiveRelationshipAPI (Cross-Instance References)

```yaml
schemas:
  CognitiveRelationshipAPI:
    description: |
      Inter-instance relationships for complex cognition.
      Enables graph structure, not just flat arrays.

    relationships:
      cognitive:supersedes:
        type: "rel"
        description: "This instance replaces another"
        example: |
          # mem_042 supersedes mem_017
          rel cognitive:supersedes = </Instances/mem_017>

      cognitive:derivedFrom:
        type: "rel[]"
        description: "This instance synthesized from others"
        example: |
          # A conclusion derived from multiple observations
          rel cognitive:derivedFrom = [
              </Instances/obs_001>,
              </Instances/obs_002>,
              </Instances/obs_003>
          ]

      cognitive:contradicts:
        type: "rel"
        description: "This instance conflicts with another"
        resolution: "Use conflictResolution strategy"

      cognitive:supports:
        type: "rel[]"
        description: "This instance corroborates others"
        effect: "Increases confidence of supported instances"
```

### 13.7 CognitiveAuditAPI (Verification Tools)

```yaml
schemas:
  CognitiveAuditAPI:
    description: |
      Audit trail and determinism verification for cognitive operations.

    attributes:
      cognitive:auditEnabled:
        type: "bool"
        default: false

      cognitive:operationLog:
        type: "string[]"
        description: "Log of operations applied to this assembly"

      cognitive:stateHash:
        type: "string"
        computed: true
        description: |
          SHA-256 of canonical expanded state.
          Use for determinism verification:
          same inputs → same hash (GUARANTEED)
```

**Verification Tests:**

```python
def verify_round_trip(memories):
    """Verify compress → expand → compress is identity."""
    assembly = compress(memories)
    expanded = expand(assembly)
    recompressed = compress(expanded)
    assert hash(assembly) == hash(recompressed)

def verify_determinism(memories, n_trials=100):
    """Verify same inputs always produce same outputs."""
    hashes = set()
    for _ in range(n_trials):
        assembly = compress(memories)
        hashes.add(hash(expand(assembly)))
    assert len(hashes) == 1  # Exactly 1 unique hash

def verify_batch_invariance(memories):
    """Verify results don't depend on tile size."""
    results = []
    for tile_size in [1, 8, 32, 128, 1024]:
        result = compress_with_tile_size(memories, tile_size)
        results.append(hash(expand(result)))
    assert len(set(results)) == 1  # All hashes identical
```

### 13.8 Compression Profiles

```yaml
profiles:
  context_injection:
    description: "For injecting into LLM context"
    target: "Maximum compression, minimal tokens"
    settings:
      format: "library_reference"
      maxTokens: 100
      confidenceThreshold: 0.7
      includeMetadata: false
      includeRelationships: false

  persistent_storage:
    description: "For disk storage between sessions"
    target: "Lossless, human-readable"
    settings:
      format: "assembly_usda_verbose"
      maxTokens: null  # No limit
      confidenceThreshold: 0.0  # Keep all
      includeMetadata: true
      includeRelationships: true
      includeAuditLog: true

  api_transport:
    description: "For network transmission"
    target: "Balance compression and parse speed"
    settings:
      format: "assembly_compressed_json"
      maxTokens: 1000
      confidenceThreshold: 0.5
      includeMetadata: true
      includeRelationships: false

  archive:
    description: "For rarely-accessed historical state"
    target: "Maximum compression, defer expansion"
    settings:
      format: "assembly_payload"
      usePayloads: true
      deferExpansion: true
      confidenceThreshold: 0.3
```

### 13.9 Performance Budget

| Operation | Target Latency | Notes |
|-----------|---------------|-------|
| Compression (100 memories) | < 10ms | CPU-bound, no GPU required |
| Expansion (100 instances) | < 5ms | Can yield incrementally |
| Exact retrieval | < 2ms | Hash-based lookup |
| Semantic retrieval | < 50ms | Embedding similarity |
| Context injection | 100 tokens max | Default budget |
| Round-trip verification | < 50ms | |
| Determinism test (100 trials) | < 500ms | |
| Target compression | > 5:1 | For typical memory sets |

### 13.10 Formal Guarantees (v7.1.0)

**Theorem 5 (Tile Size Invariance):**
For fixed tile size T and any memory set M:
```
expand(M, T) = expand(M, T)
```
regardless of system load or concurrent operations.

**Theorem 6 (Aggregation Determinism):**
For any aggregation strategy A and instance set I:
```
A(sort(I)) = A(sort(I))
```
when instances are sorted by deterministic key before aggregation.

**Theorem 7 (Retrieval Invariance):**
With fixed tile size and deterministic sorting:
```
retrieve(q, M) = retrieve(q, M)
```
across all invocations for query q and memory bank M.

### 13.11 State Schema Extension (44 → 52 fields)

New fields for v7.1.0:

```
# Batch Invariance Fields
cognitive:tileSize            = 32 (fixed)
cognitive:aggregationStrategy = "max" | "mean" | "weighted_mean" | "decay_mean" | "threshold_filter"
cognitive:aggregationOrder    = "id_ascending" | "confidence_descending" | "chronological" | "hash"
cognitive:templateMatchOrder  = "lexicographic" | "priority" | "chronological" | "hash"
cognitive:deterministicHash   = string (SHA-256 of expanded state)
cognitive:determinismMode     = "strict" | "relaxed" | "none"
cognitive:hashSeed            = 0xCAFEBABE (fixed)
cognitive:conflictResolution  = "newest_wins" | "highest_confidence" | "manual" | "merge"
```

---

## Appendix A: USD Schema Reference

See `cognitive_substrate_v7.usda` for complete schema definitions.

## Appendix D: BCM Learning Mathematics

**Bienenstock-Cooper-Munro Saturation:**

The BCM sliding threshold provides homeostatic regulation:

```
θ_m(t+1) = θ_m(t) × α + (1 - α) × ȳ²(t)
```

Where:
- θ_m = sliding threshold
- α = decay factor (typically 0.95)
- ȳ = recent activity average

**Trail Strength Update:**

```
Δs = η × (y - θ_m) × x × saturation(s)
s_new = clip(s + Δs, 0.01, 100.0)
```

Where:
- η = base learning rate
- y = outcome signal
- x = activation level
- saturation(s) = 1 / (1 + exp(-(s - θ_m) / T))

**Time Decay:**

```
s(t) = s(0) × exp(-t / τ)
τ = 2 hours (half-life)
```

## Appendix E: Grounding Layer Implementation

**Oracle Query Protocol:**

```python
# Deterministic oracle query
result = oracle_registry.query(
    oracle_id="houdini_rbd",
    query="position(ball, frame=48)",
    cache_key=hash(query),
    max_age_seconds=300
)

# Evidence chain construction
evidence = Evidence(
    source=oracle_id,
    query=query,
    result=result,
    timestamp=now(),
    confidence=1.0  # Oracle is authoritative
)
warehouse.append(evidence)
```

## Appendix B: Determinism Specification (L0D)

See `determinism_spec.usda` for pattern dictionaries, activation matrices, and tiebreaker rules.

## Appendix C: API Reference

See SDK documentation for complete interface specifications.

---

## Acknowledgments

The author thanks Pixar Animation Studios for creating and open-sourcing Universal Scene Description (USD), whose composition semantics inspired this architecture. The author also acknowledges the ThinkingMachines Lab for their foundational work on batch-invariant LLM inference, which enables the determinism guarantees central to this system.

---

## Code and Data Availability

The specification and reference implementation are available under the MIT License:

**Specification Repository:**
https://github.com/JosephOIbrahim/usd-cognitive-substrate

**Reference Implementation:**
https://github.com/JosephOIbrahim/Orchestra

The reference implementation (Orchestra v7.0.0) includes:
- Full cognitive orchestration system with 7 intervention experts + 4 grounding experts
- Grounding Layer with oracle registry and evidence warehouse
- BCM stigmergic learning with trail-based confidence
- Plasticity auto-triggers and signal reliability tracking
- `cogroute_bench.py` — CogRoute-Bench standardized benchmark suite
- Complete test suite with 1047+ unit tests
- PyPI package: `pip install cognitive-orchestra`

Benchmark results: 94.6% routing accuracy, 100% determinism, 0.13ms average latency.

**v7.0.0 Experimental Validation:**
- Grounding: 710/710 physics queries bit-identical (100%)
- Constraint Satisfaction: 10/10 determinism (hash: fc23a00c926e)
- USD Unity: 10/10 determinism (hash: e89e5138077c), 32/32 edge cases

---

## References

1. Pixar Animation Studios. (2016). *Universal Scene Description*. https://graphics.pixar.com/usd/

2. He, Horace and Thinking Machines Lab. (2025). "Defeating Nondeterminism in LLM Inference." *Thinking Machines Lab: Connectionism*, September 2025. https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/

3. Anderson, J. R. (2007). *How Can the Human Mind Occur in the Physical Universe?* Oxford University Press.

4. Laird, J. E. (2012). *The Soar Cognitive Architecture*. MIT Press.

5. Franklin, S., Madl, T., D'Mello, S., and Snaider, J. (2016). "LIDA: A Systems-level Architecture for Cognition, Emotion, and Learning." *IEEE Transactions on Autonomous Mental Development*, 6(1):19-41.

---

*Date: 2026-01-31*
*Version: 7.1.0*
*Classification: Academic Pre-Publication Draft*
