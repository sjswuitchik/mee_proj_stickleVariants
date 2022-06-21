#!/bin/bash
#SBATCH -J gatkVar
#SBATCH -o out
#SBATCH -e err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

# submit from shunda/snpArcher/process_out

source activate gatk

gatk VariantsToTable -Xmx8g -V shunda.filt.recode.vcf -F CHROM -F POS -F AF -F REF -F ALT -O shunda.var.txt
