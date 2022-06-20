## in /scratch/sjsmith/shunda/snpArcher
# set up a GATK4 conda env to convert VCF outside of the snpArcher pipeline
conda create -n gatk -c bioconda gatk4 vcftools
conda activate gatk 

mkdir process_out
cp results/Pungitius_pungitius/GCF_902500615.1_NSP_V7_genomic/Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz* process_out/

# process VCF 
cd process_out
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz shunda.final.vcf.gz
mv Pungitius_pungitius_GCF_902500615.1_NSP_V7_genomic.final.vcf.gz.tbi shunda.final.vcf.gz.tbi
vcftools --gzvcf shunda.final.vcf.gz --max-missing 0.95 --maf 0.01 --recode --recode-INFO-all --out shunda.filt

# convert filtered VCF to table for use in multiallelic site removal script
gatk VariantsToTable -V shunda.filt.vcf -F CHROM -F POS -F AF -F REF -F ALT -O shunda.var.txt

