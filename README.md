# Mutation Rate Calculator

An exercise using Python that computes the mutation rate of each sequence in a FASTA file relative to a user-selected reference sequence, using Needleman–Wunsch global alignment and Pandas for output.

## Setup

1. Clone the repository:

```
git clone https://github.com/edecocke-uncc/mutation_rate.git
```

2. Go into the project folder:

```
cd mutation_rate
```

3. Create the environment:

```
conda env create -f environment.yml
```

4. Activate the environment:

```
conda activate mutation_rate
```

## Run

```
python3 main.py -i BDNF.fasta -r NM_170735
```

To save results to a CSV file:

```
python3 main.py -i BDNF.fasta -r NM_170735 -o results.csv
```

### Arguments

| Flag | Description |
|------|-------------|
| `-i` / `--input` | Path to the input FASTA file (required) |
| `-r` / `--reference` | Substring matching the reference sequence header (required) |
| `-o` / `--output` | Path to write the output CSV file (optional) |

## What it does

* Parses a multi-sequence FASTA file using a custom `mut_calc` module
* Lets the user specify a reference sequence by providing any substring of its header (e.g. `NM_170735` for the human BDNF mRNA)
* Aligns every other sequence against the reference using **Needleman–Wunsch global alignment** (implemented in NumPy)
* Computes per-sequence mutation statistics: alignment length, number of matches, number of mismatches, mutation rate, and percent identity
* Summarises all results in a Pandas DataFrame

## Output

A `results.csv` file (when `-o` is specified) containing one row per query sequence with the following columns:

| Column | Description |
|--------|-------------|
| `query_id` | Full FASTA header of the query sequence |
| `reference_id` | Full FASTA header of the reference sequence |
| `alignment_length` | Total length of the global alignment |
| `matches` | Number of identical aligned positions |
| `mismatches` | Number of differing positions (substitutions + gaps) |
| `mutation_rate` | `mismatches / alignment_length` (0.0 – 1.0) |
| `identity_pct` | `100 × matches / alignment_length` |
| `alignment_score` | Needleman–Wunsch alignment score |

## Example FASTA file

`BDNF.fasta` is included in the repository and contains two real mRNA sequences retrieved from NCBI:

* **NM_170735.5** — *Homo sapiens* BDNF (brain-derived neurotrophic factor), transcript variant 1
* **NM_007540.4** — *Mus musculus* Bdnf, transcript variant 1

## Testing

A bash script is provided that runs the calculator with both sequences as reference and exercises error-handling paths:

```
bash run_tests.sh
```

## Project structure

```
mutation_rate/
├── main.py              
├── mut_calc/
│   ├── __init__.py
│   ├── fasta_parser.py   
│   └── aligner.py        
├── BDNF.fasta            
├── environment.yml      
├── run_tests.sh        
├── LICENSE
└── README.md
```
