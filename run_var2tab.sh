#!/bin/bash
#SBATCH -J gatkVar
#SBATCH -o process_out/out
#SBATCH -e process_out/err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

source activate gatk

gatk VariantsToTable -Xmx8g -V process_out/muir.filt.recode.vcf -F CHROM -F POS -F AF -F REF -F ALT -O process_out/muir.var.txt
