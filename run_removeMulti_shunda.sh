#!/bin/bash
#SBATCH -J rmMulti
#SBATCH -o out_multi
#SBATCH -e err_multi
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=9000

# submit from shunda/snpArcher/process_out

source activate gatk

python remove_multi.py shunda.var.txt shunda.var.noMulti.txt
