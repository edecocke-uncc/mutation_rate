# Mutation Rate Calculator

An exercise using Python that computes the mutation rate of each sequence in a FASTA file relative to a user-selected reference sequence, using Needleman–Wunsch global alignment and Pandas for output.

## What it does

*  Loads sequences from a FASTA file
*  Selects a reference sequence based on a header substring
*  Aligns each sequence to the reference using the Needleman-Wunsch algorithm
*  Computes mutation rate as mismatches divided by alignment length
*  Stores results in a structured format using Pandas


## Project structure

```
mutation_rate/
├── main.py              
├── mut_calc/
│   ├── __init__.py
│   ├── mutation_rate_calculator 
│       
├── BDNF.fasta            
├── environment.yml      
├── run_tests.sh        
├── LICENSE
└── README.md
```

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

## Example FASTA file

`BDNF.fasta` is included in the repository and contains two real mRNA sequences retrieved from NCBI:

* **NM_170735.5** — *Homo sapiens* BDNF (brain-derived neurotrophic factor), transcript variant 1
* **NM_007540.4** — *Mus musculus* Bdnf, transcript variant 1
* 
## Run

```
python3 main.py -i BDNF.fasta -r NM_170735
```

To save results to a CSV file:

```
python3 main.py -i BDNF.fasta -r NM_170735 -o results.csv
```

## Testing

A bash script is provided that runs the calculator with both sequences as reference and exercises error-handling paths:

```
bash run_tests.sh
```

### Arguments

| Flag | Description |
|------|-------------|
| `-i` / `--input` | Path to the input FASTA file (required) |
| `-r` / `--reference` | Substring matching the reference sequence header (required) |
| `-o` / `--output` | Path to write the output CSV file (optional) |

## Output

*  Prints mutation rate results to the terminal
*  Optionally writes a results.csv file to the current directory if -o is provided



