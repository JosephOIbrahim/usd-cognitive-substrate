# USD Cognitive Substrate Reconciliation

## Status: ✅ ALIGNED (2026-01-26)

The USD Cognitive Substrate specification has been updated to match Orchestra naming conventions.
Both repositories now use identical expert names and are fully compatible.

---

## ThinkingMachines [He2025] Compliance as Source of Truth

**Reference:** He, Horace and Thinking Machines Lab. "Defeating Nondeterminism in LLM Inference."
Thinking Machines Lab: Connectionism, Sep 2025.
https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/

---

## Core Determinism Invariants (From ThinkingMachines)

These MUST be preserved in any implementation:

| Invariant | Definition | Implication |
|-----------|------------|-------------|
| **Batch Invariance** | `output[i] == output[i]` regardless of batch context | Same signal → Same routing |
| **Run-to-Run Determinism** | Identical inputs → Bitwise identical outputs | Reproducible checksums |
| **Fixed Reduction Order** | Deterministic operation ordering | Fixed phase sequence |

---

## Implementations Compared

### Repository Locations

| Implementation | Repository | Status |
|----------------|------------|--------|
| **USD Cognitive Substrate** | github.com/JosephOIbrahim/usd-cognitive-substrate | Academic spec |
| **Orchestra** | github.com/JosephOIbrahim/Orchestra | Production (v5.0.2 on PyPI) |

### Compatibility Matrix

| Component | GitHub Spec | Orchestra | Compatible? |
|-----------|-------------|-----------|-------------|
| LIVRPS Composition | ✓ | ✓ | **YES** |
| Mycelium Learning | ✓ | ✓ | **YES** |
| Deterministic Routing | ✓ | ✓ | **YES** |
| ThinkingMachines Compliance | ✓ | ✓ | **YES** |
| Expert Names | ✓ | ✓ | **YES** (aligned) |
| Layer Count | 7 | 14 | **MAPPING AVAILABLE** |
| Phase Names | ✓ | ✓ | **YES** (aligned) |

**Verdict:** Fully compatible. Both use Orchestra naming conventions.

---

## Expert Archetype Mapping (ALIGNED)

Both implementations now use identical expert names (Orchestra naming convention):

| Priority | Expert Name | Semantic Role |
|----------|-------------|---------------|
| 1 | **Validator** | Safety-first, empathy, emotional validation |
| 2 | **Scaffolder** | Break down complexity, reduce scope |
| 3 | **Restorer** | Recovery facilitation, energy restoration |
| 4 | **Refocuser** | Attention management, tangent redirect |
| 5 | **Celebrator** | Progress recognition, dopamine |
| 6 | **Socratic** | Discovery facilitation, exploration |
| 7 | **Direct** | Task execution, minimal intervention |

**Canonical Naming:**

For ThinkingMachines compliance, we use priority-indexed identifiers:

```
E1_VALIDATE   // Validator - Safety-first validation
E2_DECOMPOSE  // Scaffolder - Complexity reduction
E3_RESTORE    // Restorer - Energy recovery
E4_REDIRECT   // Refocuser - Attention management
E5_ACKNOWLEDGE // Celebrator - Progress recognition
E6_GUIDE      // Socratic - Discovery facilitation
E7_EXECUTE    // Direct - Direct execution
```

---

## Routing Phase Mapping

### GitHub Spec: 5-Phase Routing

```
P1_ACTIVATE → P2_WEIGHT → P3_BOUND → P4_SELECT → P5_UPDATE
```

### Orchestra: 6-Phase Routing

```
P0_RETRIEVE → P1_DETECT → P2_CASCADE → P3_LOCK → P4_EXECUTE → P5_UPDATE
```

### Canonical Mapping (ThinkingMachines-Aligned)

```
Phase   GitHub          Orchestra       Canonical           Purpose
─────   ──────────────  ──────────────  ─────────────────   ─────────────────────────
P0      (not present)   RETRIEVE        P0_RETRIEVE         Knowledge O(1) lookup [OPTIONAL]
P1      ACTIVATE        DETECT          P1_SIGNAL           Signal pattern matching
P2      WEIGHT          CASCADE         P2_ROUTE            Expert weight calculation
P3      BOUND           LOCK            P3_CONSTRAIN        Safety bounds + parameter lock
P4      SELECT          EXECUTE         P4_DISPATCH         Expert selection + execution
P5      UPDATE          UPDATE          P5_LEARN            Mycelium weight update
```

**Key Difference:** Orchestra adds Phase 0 (Knowledge Prims retrieval) as a fast-path optimization.
This is an EXTENSION, not a breaking change. Spec-compliant implementations can skip P0.

---

## Layer Mapping

### GitHub Spec: 7-Layer Temporal Hierarchy

```
L13: current.usda       [LOCAL]       Live session state
L12: snapshots/*.usda   [LOCAL]       Restoration points
L11: daily/*.usda       [INHERITS]    Daily patterns
L10: weekly/*.usda      [INHERITS]    Weekly patterns
L9:  calibration.usda   [REFERENCES]  Learned weights
L8:  profile.usda       [SPECIALIZES] Base traits
L7:  payloads/*.usda    [PAYLOADS]    Domain expertise
```

### Orchestra: 14-Layer Cognitive Stack

```
L13: Session            [LOCAL]       Runtime mutable state
L12: Calibration        [REFERENCES]  Cross-session learning
L11: Resonance          [INHERITS]    RC^+xi convergence
L10: Consistency        [INHERITS]    NEXUS execution
L9:  CognitiveInsights  [INHERITS]    ADHD_MoE experts
L8:  TranslationBinding [INHERITS]    Output formatting
L7:  Payloads           [PAYLOADS]    Domain knowledge
L6:  Variants           [VARIANTSETS] Mode switching
L5:  ExecutiveFunction  [INHERITS]    ADHD support
L4:  Translation        [INHERITS]    Formatting rules
L3:  Paradigm           [INHERITS]    Cortex vs Mycelium
L2:  Architecture       [INHERITS]    PRISM + MAX3
L1:  Profile            [SPECIALIZES] Base traits
L0:  ConsistencyPrimitives [SPECIALIZES] Foundational defs
```

### Canonical Mapping

The GitHub spec optimizes for **temporal aggregation** (session → daily → weekly).
Orchestra optimizes for **cognitive processing** (detection → routing → execution).

Both are valid. For ThinkingMachines compliance, the key constraint is:
**LIVRPS resolution order must be deterministic.**

Canonical layers (minimal viable):

```
LAYER_CANONICAL = {
    "SESSION":     {"usd_arc": "LOCAL",      "mutability": "mutable"},
    "CALIBRATION": {"usd_arc": "REFERENCES", "mutability": "slow"},
    "VARIANTS":    {"usd_arc": "VARIANTSETS","mutability": "session"},
    "PAYLOADS":    {"usd_arc": "PAYLOADS",   "mutability": "immutable"},
    "PROFILE":     {"usd_arc": "SPECIALIZES","mutability": "immutable"},
}
```

Extensions beyond these 5 core layers are implementation-specific.

---

## Convergence Tracking (Orchestra Extension)

Orchestra adds RC^+xi epistemic tension tracking not in the GitHub spec:

```
xi_n = ||A_{n+1} - A_n||_2    // Epistemic tension
epsilon = 0.1                  // Convergence threshold
stable_count >= 3              // Exchanges at xi < epsilon = CONVERGED
```

**Recommendation:** Add to GitHub spec as optional extension.

---

## Knowledge Prims (Orchestra Extension)

Orchestra adds O(1) knowledge retrieval not in the GitHub spec:

```
Phase 0: RETRIEVE
  - 89 prims, 340+ triggers, 17 domains
  - Confidence >= 0.85 → Return directly (skip inference)
  - Confidence < 0.85 → Augment LLM context
```

**Recommendation:** Add to GitHub spec as optional extension (Phase 0).

---

## Sync Strategy (COMPLETED)

**Option A was implemented:** GitHub spec adopted Orchestra naming.

- ✅ GitHub spec updated to use Orchestra expert names (Validator, Scaffolder, etc.)
- ✅ Reference implementation links updated to point to Orchestra
- ✅ LaTeX papers updated with correct repository URLs
- ✅ No breaking changes to Orchestra (777+ tests unaffected)

---

## ThinkingMachines Compliance Checklist

Both implementations MUST satisfy:

| Requirement | GitHub Spec | Orchestra |
|-------------|-------------|-----------|
| Fixed phase order | ✓ P1-P5 | ✓ P0-P5 |
| Deterministic pattern matching | ✓ L0D dictionary | ✓ PRISM detector |
| Safety floors enforced | ✓ Phase 3 BOUND | ✓ Phase 3 LOCK |
| Homeostatic normalization | ✓ sum(weights)=1 | ✓ sum(weights)=1 |
| Reproducible checksums | ✓ sort_keys=True | ✓ sort_keys=True |
| Parameter locking | ✓ Phase 3 | ✓ Phase 3 LOCK |
| Fixed expert priority | ✓ Index tiebreaker | ✓ Priority order |

**Both implementations are ThinkingMachines [He2025] compliant.**

---

## Action Items (COMPLETED)

### For GitHub usd-cognitive-substrate:

- [x] Updated expert names to match Orchestra (Validator, Scaffolder, etc.)
- [x] Updated reference implementation links to Orchestra
- [x] Updated LaTeX papers with correct URLs

### For Orchestra:

- [x] No changes needed - Orchestra is the reference implementation

### For persistent-state-hypothesis:

- [x] LaTeX paper updated with Orchestra URL

---

## Conclusion

**The USD Cognitive Substrate (GitHub) and Orchestra are fully aligned.**

Both share:
- LIVRPS composition semantics
- Mycelium learning algorithm
- ThinkingMachines [He2025] determinism compliance
- 7 intervention experts with **identical naming** (Validator, Scaffolder, Restorer, Refocuser, Celebrator, Socratic, Direct)
- Reference implementation: Orchestra (v5.0.2 on PyPI, 777+ tests)

Layer count difference (GitHub: 7, Orchestra: 14) is documented as extension, not incompatibility.

---

*Document Version: 2.0.0 (Aligned)*
*Date: 2026-01-26*
*Author: Joseph O. Ibrahim + Claude Code*
*Status: Repositories aligned - GitHub spec uses Orchestra naming*
