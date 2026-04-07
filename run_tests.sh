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
echo "Output CSV:"
cat results_human_ref.csv
echo ""
 

echo "TEST 2: Mouse Bdnf (NM_007540) as reference"
echo "------------------------------------------------------------"
python3 "$SCRIPT" -i "$FASTA" -r "NM_007540" -o results_mouse_ref.csv
echo ""
echo "Output CSV:"
cat results_mouse_ref.csv
echo ""
 

echo "TEST 3: Error handling — non-existent file"
echo "------------------------------------------------------------"
python3 "$SCRIPT" -i "does_not_exist.fasta" -r "NM_170735" && echo "FAIL: should have errored" || echo "PASS: error handled gracefully"
echo ""
 
echo "TEST 4: Error handling — unrecognised reference"
echo "------------------------------------------------------------"
python3 "$SCRIPT" -i "$FASTA" -r "XM_FAKE_ID" && echo "FAIL: should have errored" || echo "PASS: error handled gracefully"
echo ""
 
echo " All tests complete."
