# Arxiv Submission Package

**USD Cognitive Substrate: A Deterministic Architecture for Adaptive AI State Management**

**Author:** Joseph O. Ibrahim
**Date:** January 2026

---

## Papers Included

| Paper | Directory | Primary Category |
|-------|-----------|------------------|
| **USD Cognitive Substrate** | `usd-cognitive-substrate/` | cs.AI |
| **The Persistent State Hypothesis** | `persistent-state-hypothesis/` | cs.AI |
| **Determinism in Framework Orchestrator** | `determinism/` | cs.LG |

---

## Directory Structure

```
arxiv/
├── README.md                          # This file
├── references.bib                     # Shared bibliography
├── usd-cognitive-substrate/
│   └── main.tex                       # Main specification paper
├── persistent-state-hypothesis/
│   └── main.tex                       # Theoretical foundation paper
└── determinism/
    └── main.tex                       # Determinism analysis paper
```

---

## Compilation Instructions

### Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- BibTeX or Biber for bibliography

### Compile Each Paper

```bash
# USD Cognitive Substrate (main paper)
cd usd-cognitive-substrate
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex

# Persistent State Hypothesis
cd ../persistent-state-hypothesis
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex

# Determinism
cd ../determinism
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

### Using latexmk (Recommended)

```bash
# Compile all papers
cd usd-cognitive-substrate && latexmk -pdf main.tex && cd ..
cd persistent-state-hypothesis && latexmk -pdf main.tex && cd ..
cd determinism && latexmk -pdf main.tex && cd ..
```

---

## Arxiv Submission Checklist

### Required for Each Paper

- [x] LaTeX source file (main.tex)
- [x] Bibliography file (references.bib)
- [x] Abstract in LaTeX document
- [x] Author information
- [x] Code availability statement
- [x] Acknowledgments section

### Arxiv Categories

| Paper | Primary | Secondary |
|-------|---------|-----------|
| USD Cognitive Substrate | cs.AI | cs.LG, cs.SE |
| Persistent State Hypothesis | cs.AI | cs.LG |
| Determinism | cs.LG | cs.AI |

### License

All papers are submitted under **CC BY 4.0** (Creative Commons Attribution).

---

## Code Repositories

- **Specification:** https://github.com/JosephOIbrahim/usd-cognitive-substrate
- **Implementation:** https://github.com/JosephOIbrahim/framework-orchestrator

---

## Key Citations

The papers cite the following foundational work:

1. **ThinkingMachines (2025)** - Batch-invariant LLM inference
   - DOI: 10.64434/tml.20250910
   - URL: https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/

2. **Pixar USD (2016)** - Universal Scene Description
   - URL: https://graphics.pixar.com/usd/

---

## Verification

All ThinkingMachines claims have been verified against the source:

| Claim | Verified |
|-------|----------|
| 80 unique completions from 1000 at temp=0 | ✓ |
| 2.1× overhead (unoptimized) | ✓ |
| 1.6× overhead (optimized attention) | ✓ |
| ~20% MatMul performance loss | ✓ |
| Data-parallel RMSNorm | ✓ |
| Fixed split-SIZE attention | ✓ |

---

**Generated:** 2026-01-21
