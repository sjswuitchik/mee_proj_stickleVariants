#!/bin/bash
#SBATCH -J snpEff
#SBATCH -o snpEff_out
#SBATCH -e snpEff_err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=0
#SBATCH --exclusive

# submit from /scratch/sjsmith/mk_tests/snpEff

conda activate snpeff

snpEff ann -Xmx8g -i vcf -o vcf -c snpEff.config punPun /scratch/sjsmith/mk_tests/muir_gasAcu/muir.clean.vcf > muir.ann.vcf
