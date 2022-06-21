#!/bin/bash
#SBATCH -J gatkVar
#SBATCH -o out
#SBATCH -e err
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

# submit from shunda/snpArcher/process_out

source activate gatk

python remove_multi.py shunda.var.txt shunda.var.noMulti.txt
