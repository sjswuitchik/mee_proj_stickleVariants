#!/bin/bash
#SBATCH -J snipre
#SBATCH -o snip_out
#SBATCH -e snip_err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=0
#SBATCH --exclusive

# submit from /scratch/sjsmith/mk_tests/shunda_gasAcu

mamba activate r

Rscript --slave --vanilla ../helper_scripts/prep_snipre_shunda.R shunda.final.bed gasAcu.shunda.final.bed shunda.lmiss gasAcu.shunda.lmiss

Rscript --slave --vanilla ../helper_scripts/run_snipre_shunda.R
