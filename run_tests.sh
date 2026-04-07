#!/usr/bin/env bash
# run_tests.sh

# Runs the mutation rate calculator against the provided BDNF.fasta file
# using each sequence as the reference in turn.
 
set -euo pipefail
 
FASTA="BDNF.fasta"
SCRIPT="main.py"
 
echo "------------------------------------------------------------"
echo " Mutation Rate Calculator — Test Suite"
echo "------------------------------------------------------------"
echo ""

echo "TEST 1: Human BDNF (NM_170735) as reference"
echo "------------------------------------------------------------"
python3 "$SCRIPT" -i "$FASTA" -r "NM_170735" -o results_human_ref.csv
echo ""

echo "TEST 2: Mouse Bdnf (NM_007540) as reference"
echo "------------------------------------------------------------"
python3 "$SCRIPT" -i "$FASTA" -r "NM_007540" -o results_mouse_ref.csv
echo ""
 
echo " All tests complete."
