#!/bin/bash
#SBATCH -J gatkVar
#SBATCH -o out
#SBATCH -e err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

# submit from muir/snpArcher/process_out

source activate gatk

gatk VariantsToTable -V muir.filt.recode.vcf -F CHROM -F POS -F AF -F REF -F ALT -F AF -F DP -F QD -F FS -F MQ -F MQRankSum -F ReadPosRankSum -F TYPE -F FILTER -GF AD -GF DP -GF GQ -GF GT -GF SB -O muir.var.txt --split-multi-allelic
