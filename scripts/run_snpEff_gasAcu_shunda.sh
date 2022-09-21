#!/bin/bash
#SBATCH -J snpEff_gasAcu_shun
#SBATCH -o snpEff_out_gasAcu_shun
#SBATCH -e snpEff_err_gasAcu_shun
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=0
#SBATCH --exclusive

# submit from /scratch/sjsmith/mk_tests/snpEff

mamba activate snpeff

snpEff ann -Xmx8g -i vcf -o vcf -c snpEff.config punPun /scratch/sjsmith/mk_tests/shunda_gasAcu/gasAcu.clean.vcf > gasAcu.shunda.ann.vcf
