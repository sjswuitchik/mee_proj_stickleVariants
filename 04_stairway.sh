# in /scratch/sjsmith/stairway/muir

module load vcftools r 
# vcftools version 0.1.16, r v. 4.2.1

git clone https://github.com/xiaoming-liu/stairway-plot-v2.git
unzip stairway_plot_v2.1.1.zip
rm stairway_plot_v2.1.1.zip
mv stairway-plot-v2/ stairway/
mkdir -p stairway/muir
mkdir -p stairway/shunda

cp muir_gasAcu/muir.clean.vcf stairway/muir

vcftools --vcf muir.clean.vcf --max-missing 1 --min-alleles 2 --max-alleles 2 --remove-filtered-all --remove-indels --out muir --counts2

# edit frq.counts header to be CHROM  POS N_ALLELES N_CHR MAJOR MINOR
Rscript calc_sfs.R
