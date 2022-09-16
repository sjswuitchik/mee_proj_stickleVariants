#!/bin/bash
#SBATCH -J snpeff_db
#SBATCH -o out
#SBATCH -e err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

conda activate snpeff

snpEff -Xmx8g build -c snpEff.config -gff3 -v -noCheckCds -noCheckProtein punPun
