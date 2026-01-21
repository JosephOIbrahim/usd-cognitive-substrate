# Handoff Document: Add Graphics to Arxiv Papers

**Project:** USD Cognitive Substrate Arxiv Submission
**Author:** Joseph O. Ibrahim
**Created:** 2026-01-21
**Purpose:** Add publication-quality figures to LaTeX papers

---

## Executive Summary

Three academic papers are ready for Arxiv submission but need graphics converted from ASCII diagrams to publication-quality figures. The LaTeX source files are complete; figures need to be created and inserted.

---

## Repository Location

```
C:\Users\User\usd-cognitive-substrate\
├── arxiv/                              # Arxiv submission package
│   ├── references.bib                  # Shared bibliography
│   ├── usd-cognitive-substrate/
│   │   └── main.tex                    # NEEDS FIGURES
│   ├── persistent-state-hypothesis/
│   │   └── main.tex                    # NEEDS FIGURES
│   └── determinism/
│       └── main.tex                    # NEEDS FIGURES (optional)
├── USD_COGNITIVE_SUBSTRATE.md          # Source with ASCII diagrams
├── PERSISTENT_STATE_HYPOTHESIS.md      # Source with ASCII diagrams
└── DETERMINISM.md                      # Source with ASCII diagrams
```

**GitHub:** https://github.com/JosephOIbrahim/usd-cognitive-substrate

---

## Figures Required

### Paper 1: USD Cognitive Substrate (PRIORITY)

| Figure | Description | Source Location | Format |
|--------|-------------|-----------------|--------|
| **Figure 1** | 5-Phase Routing Flow | USD_COGNITIVE_SUBSTRATE.md lines 266-316 | Flowchart |
| **Figure 2** | LIVRPS Composition Resolution | USD_COGNITIVE_SUBSTRATE.md lines 171-205 | Diagram |
| **Figure 3** | Determinism Boundary | USD_COGNITIVE_SUBSTRATE.md lines 637-670 | Architecture diagram |
| **Figure 4** | CogRoute-Bench Results | USD_COGNITIVE_SUBSTRATE.md lines 904-933 | Bar chart |

### Paper 2: Persistent State Hypothesis

| Figure | Description | Source Location | Format |
|--------|-------------|-----------------|--------|
| **Figure 1** | Energy Comparison by Operation Type | PERSISTENT_STATE_HYPOTHESIS.md lines 100-134 | Comparison chart |

### Paper 3: Determinism (Optional)

| Figure | Description | Source Location | Format |
|--------|-------------|-----------------|--------|
| **Figure 1** | Batch Size vs Determinism | DETERMINISM.md (create new) | Simple diagram |

---

## ASCII Source for Each Figure

### Figure 1: 5-Phase Routing Flow (USD Cognitive Substrate)

```
                            USER INPUT
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 1: ACTIVATE                                                    │
│  ┌─────────────┐    ┌──────────────────┐    ┌──────────────────────┐ │
│  │   Signal    │───▶│  Pattern Match   │───▶│  Activation Vector   │ │
│  │  "stuck"    │    │  (L0D Dictionary)│    │  [0,0.8,0,0,0,0.2,0] │ │
│  └─────────────┘    └──────────────────┘    └──────────────────────┘ │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 2: WEIGHT                                                      │
│  activation × expert_weights = weighted_scores                        │
│  [0,0.8,0,0,0,0.2,0] × [0.15,0.15,0.10,...] = [0,0.12,0,0,0,0.04,0]  │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 3: BOUND                                                       │
│  ┌────────────────────┐  ┌────────────────────┐  ┌────────────────┐  │
│  │  Safety Floors     │  │  Homeostatic Norm  │  │  Constitutional│  │
│  │  max(w, floor)     │─▶│  w / sum(w) = 1.0  │─▶│  Constraints   │  │
│  │  Protector ≥ 0.10  │  │                    │  │  (inviolable)  │  │
│  └────────────────────┘  └────────────────────┘  └────────────────┘  │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 4: SELECT                                                      │
│  expert = argmax(bounded_scores)                                      │
│  Tiebreaker: lower priority index wins                                │
│  Result: "Decomposer" (expert[1])                                     │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌───────────────────────────────────────────────────────────────────────┐
│  PHASE 5: UPDATE (Mycelium)                                           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────────┐   │
│  │  Outcome    │───▶│  Hebbian    │───▶│  Updated Weights        │   │
│  │  (0.0-1.0)  │    │  Learning   │    │  (for next routing)     │   │
│  └─────────────┘    └─────────────┘    └─────────────────────────┘   │
└───────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
                          EXPERT RESPONSE
```

**Visual Style:** Vertical flowchart with 5 distinct phases, arrows showing data flow, color-coded phases (blue→green→orange→purple→red recommended).

---

### Figure 2: LIVRPS Composition Resolution

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

**Visual Style:** Waterfall/cascade diagram showing priority order, highlight winning layer in green, show "shadowed" values in gray.

---

### Figure 3: Determinism Boundary

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

**Visual Style:** Two-zone diagram (stochastic outer zone in red/orange, deterministic inner zone in green/blue), clear boundary line.

---

### Figure 4: CogRoute-Bench Results

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
    complexity       ████████████████████████████████████░░░░░░░░  80%
    execution        ████████████████████████████████████░░░░░░░░  83%

    PERFORMANCE
    ────────────────────────────────────────────────────────────────
    Average Latency: 0.13ms per routing decision
```

**Visual Style:** Horizontal bar chart with percentage labels, highlight 100% bars in green, <100% in yellow/orange.

---

### Figure 5: Energy Comparison (Persistent State Hypothesis)

```
                    ENERGY COST COMPARISON
    ════════════════════════════════════════════════════════════════

    DIRECT FACT LOOKUP ("What is the capital of France?")
    ────────────────────────────────────────────────────────────────
    Transformer │████████████████████████████████████████│ O(L·n²d)
                │        ~10¹³ operations                │
    ────────────────────────────────────────────────────────────────
    USD         │█                                       │ O(1)
    Substrate   │  Path traversal                        │
    ────────────────────────────────────────────────────────────────

    RELATIONSHIP QUERY ("How are X and Y related?")
    ────────────────────────────────────────────────────────────────
    Transformer │████████████████████████████████████████│ O(L·n²d)
    ────────────────────────────────────────────────────────────────
    USD         │████                                    │ O(e)
    Substrate   │  e = edge count in graph               │
    ────────────────────────────────────────────────────────────────

    KNOWLEDGE UPDATE (Learning new fact)
    ────────────────────────────────────────────────────────────────
    Transformer │████████████████████████████████████████│ Retraining
                │  Hours to days                         │
    ────────────────────────────────────────────────────────────────
    USD         │█                                       │ O(1)
    Substrate   │  Opinion insertion                     │
    ────────────────────────────────────────────────────────────────

    Legend: █ = Relative compute cost (log scale)
```

**Visual Style:** Side-by-side comparison bars (Transformer in red, USD in green), logarithmic scale, clear labels.

---

## Graphics Creation Options

### Option A: TikZ/PGF (Recommended for Arxiv)

Create figures directly in LaTeX using TikZ. Advantages:
- Vector graphics (infinite resolution)
- Consistent styling with document
- No external files needed
- Arxiv-friendly

### Option B: External Graphics (PNG/PDF)

Create in external tool (Figma, draw.io, Inkscape) and export. Advantages:
- Easier visual editing
- More design flexibility

### Option C: Python matplotlib/seaborn

Generate programmatically. Best for:
- Figure 4 (bar chart)
- Figure 5 (comparison chart)

---

## LaTeX Figure Insertion Template

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=\textwidth]{figures/figure1.pdf}
    \caption{5-Phase Routing Flow. User input flows through five deterministic
             phases: ACTIVATE (signal detection), WEIGHT (expert weighting),
             BOUND (safety floor enforcement), SELECT (argmax selection),
             and UPDATE (Hebbian learning).}
    \label{fig:routing-flow}
\end{figure}
```

---

## Directory Structure After Graphics

```
arxiv/
├── usd-cognitive-substrate/
│   ├── main.tex
│   └── figures/
│       ├── figure1-routing-flow.pdf
│       ├── figure2-livrps-resolution.pdf
│       ├── figure3-determinism-boundary.pdf
│       └── figure4-cogroute-bench.pdf
├── persistent-state-hypothesis/
│   ├── main.tex
│   └── figures/
│       └── figure1-energy-comparison.pdf
└── determinism/
    ├── main.tex
    └── figures/
        └── figure1-batch-determinism.pdf (optional)
```

---

## Quality Standards

### Visual Consistency
- Use consistent color palette across all figures
- Recommended: Blue (#2563EB), Green (#10B981), Orange (#F59E0B), Red (#EF4444)
- Sans-serif fonts for labels (matches LaTeX default)
- Minimum 10pt font size in figures

### Arxiv Requirements
- Vector formats preferred (PDF, EPS)
- If raster, minimum 300 DPI
- Maximum figure width: 6.5 inches (single column)
- Include in same directory as main.tex or figures/ subdirectory

### ThinkingMachines Consistency
When depicting ThinkingMachines claims, use EXACT values:
- 80 unique completions from 1000 at temp=0
- 2.1× overhead (unoptimized)
- 1.6× overhead (optimized attention)
- ~20% MatMul loss vs cuBLAS

---

## Verification Checklist

After adding graphics:

- [ ] All figures compile without errors
- [ ] Figure captions are descriptive
- [ ] Figure references (\ref{fig:xxx}) work
- [ ] ThinkingMachines claims match source exactly
- [ ] Colors are accessible (colorblind-friendly)
- [ ] Text is readable at intended size
- [ ] Vector format for diagrams, high-res for charts

---

## Compilation Test

After adding figures:

```bash
cd C:\Users\User\usd-cognitive-substrate\arxiv
compile_all.bat
```

Check for:
- No missing figure errors
- No overfull hbox warnings from large figures
- Figures appear on intended pages

---

## Contact/Context

**Author:** Joseph O. Ibrahim
**GitHub:** https://github.com/JosephOIbrahim
**Papers:** USD Cognitive Substrate (AI state management using Pixar USD semantics)

**Key Citation:**
He, Horace and Thinking Machines Lab. (2025). "Defeating Nondeterminism in LLM Inference."
DOI: 10.64434/tml.20250910
URL: https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/

---

## Summary for Next Session

1. **Read this document** for full context
2. **Create 5-6 figures** from ASCII sources above
3. **Insert into LaTeX** using template provided
4. **Test compilation** with compile_all.bat
5. **Commit and push** to GitHub
6. **Notify user** papers are ready for Arxiv submission

---

*Handoff created: 2026-01-21*
*Ready for graphics implementation*
