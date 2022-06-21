
conda activate gatk

## in /scratch/sjsmith/shunda/snpArcher
mkdir process_out
cp results/Pungitius_pungitius/GCF_902500615.1_NSP_V7_genomic/Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz* process_out/

# process VCF 
cd process_out
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz shunda.final.vcf.gz
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz.tbi shunda.final.vcf.gz.tbi
zgrep -v '^#' shunda.final.vcf.gz | wc -l 
# 36903496
vcftools --gzvcf shunda.final.vcf.gz --max-missing 0.95 --maf 0.01 --recode --recode-INFO-all --out shunda.filt
# 2701687

# convert filtered VCF to table for use in multiallelic site removal script
sbatch --account=def-jonmee run_var2tab_shunda.sh

# run filtering script
sbatch --account=def-jonmee run_removeMulti_shunda.sh

## in /scratch/sjsmith/muir/snpArcher
mkdir process_out
cp results/Pungitius_pungitius/GCF_902500615.1_NSP_V7_genomic/Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz* process_out/

# process VCF 
cd process_out
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz muir.final.vcf.gz
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz.tbi muir.final.vcf.gz.tbi
zgrep -v '^#' muir.final.vcf.gz | wc -l
# 36242173
vcftools --gzvcf muir.final.vcf.gz --max-missing 0.95 --maf 0.01 --recode --recode-INFO-all --out muir.filt
# 3102019

# convert filtered VCF to table for use in multiallelic site removal script
sbatch --account=def-jonmee run_var2tab_muir.sh

# run filtering script
sbatch --account=def-jonmee run_removeMulti_muir.sh
