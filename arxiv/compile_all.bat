@echo off
REM Arxiv Paper Compilation Script
REM USD Cognitive Substrate Papers
REM Author: Joseph O. Ibrahim

echo ============================================
echo Compiling Arxiv Papers
echo ============================================

echo.
echo [1/3] Compiling USD Cognitive Substrate...
cd usd-cognitive-substrate
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
cd ..

echo.
echo [2/3] Compiling Persistent State Hypothesis...
cd persistent-state-hypothesis
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
cd ..

echo.
echo [3/3] Compiling Determinism...
cd determinism
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
cd ..

echo.
echo ============================================
echo Compilation Complete!
echo ============================================
echo.
echo Output PDFs:
echo   - usd-cognitive-substrate/main.pdf
echo   - persistent-state-hypothesis/main.pdf
echo   - determinism/main.pdf
echo.

pause
