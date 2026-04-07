"""
main.py
-------
CLI for mutation rate calculation.
"""

import argparse
import sys
import pandas as pd
from dataclasses import dataclass
from typing import List

from mutation_rate_calculator import (
    parse_fasta,
    needleman_wunsch,
    calculate_mutation_rate,
    MutationResult,
)


@dataclass
class MutationRateApp:
    """
    Main application class for mutation rate calculation.
    """
    fasta_path: str
    reference_query: str
    results: List[MutationResult]

    def load_sequences(self) -> dict:
        """Load sequences from FASTA."""
        return parse_fasta(self.fasta_path)

    def find_reference(self, sequences: dict) -> tuple[str, str]:
        """Find reference sequence."""
        matches = [h for h in sequences if self.reference_query.lower() in h.lower()]

        if len(matches) == 0:
            raise ValueError("Reference not found.")
        if len(matches) > 1:
            raise ValueError("Multiple references found.")

        header = matches[0]
        return header, sequences[header]

    def run(self) -> None:
        """Run mutation rate calculation."""
        sequences = self.load_sequences()
        ref_header, ref_seq = self.find_reference(sequences)

        for header, seq in sequences.items():
            if header == ref_header:
                continue

            ref_aln, qry_aln = needleman_wunsch(ref_seq, seq)
            length, matches, mismatches, rate = calculate_mutation_rate(ref_aln, qry_aln)

            self.results.append(
                MutationResult(header, length, matches, mismatches, rate)
            )

    def to_dataframe(self) -> pd.DataFrame:
        """Convert results to DataFrame."""
        return pd.DataFrame([r.__dict__ for r in self.results])


def build_parser() -> argparse.ArgumentParser:
    """Create CLI argument parser."""
    parser = argparse.ArgumentParser(description="Mutation Rate Calculator")
    parser.add_argument("-i", "--input", required=True)
    parser.add_argument("-r", "--reference", required=True)
    parser.add_argument("-o", "--output", required=False)
    return parser


def main() -> None:
    """Entry point."""
    parser = build_parser()
    args = parser.parse_args()

    try:
        app = MutationRateApp(args.input, args.reference, [])
        app.run()

        df = app.to_dataframe()
        print(df.to_string(index=False), file=sys.stdout)

        if args.output:
            df.to_csv(args.output, index=False)
            print(f"Saved to {args.output}", file=sys.stdout)

    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
