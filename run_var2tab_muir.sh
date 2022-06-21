#!/bin/bash
#SBATCH -J gatkVar
#SBATCH -o out
#SBATCH -e err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

# submit from muir/snpArcher/process_out

source activate gatk

gatk VariantsToTable -Xmx8g -V muir.filt.recode.vcf -F CHROM -F POS -F AF -F REF -F ALT -O muir.var.txt
