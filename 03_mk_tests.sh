# process gasAcu outgroup aligned to punPun with snpArcher from BioProject PRJNA639125
# in /scratch/sjsmith/mk_tests
## based off https://github.com/sjswuitchik/compPopGen_ms/tree/master/MKpipeline

cd snpeff 
mkdir -p data/punPun
cd data/punPun
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.gff.gz
mv GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz sequences.fa.gz
mv GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.gff.gz genes.gff.gz
cp -v genes.gff.gz ../muir_gasAcu
cp -v genes.gff.gz ../shunda_gasAcu

cd ../..
# edit the config to include genome info
sbatch --account=def-jonmee snpeff_db.sh

#### Muir #### 
cd muir_gasAcu
# set up before filtering VCF
gunzip genes.gff.gz
vcftools --gzvcf muir.final.vcf.gz --missing-indv --out muir
conda activate r
Rscript --vanilla missingness.R muir.imiss 
conda deactivate 

awk -f ../helper_scripts/cds.awk genes.gff > onlyCDS.gff
awk -f ../helper_scripts/gff2bed.awk onlyCDS.gff > onlyCDS.bed
awk -v OFS='\t' 'match($0, /gene=[^;]+/) {print $1, $2, $3, substr($0, RSTART+5, RLENGTH-5)}' onlyCDS.bed > onlyCDS.genes.bed

conda activate vcf 
bedtools intersect -a muir.callable_sites_cov.bed -b gasAcu.callable_sites.bed > callable.bed
# troubleshooting issues with Cedar + bedtools 
bedtools intersect -a callable.bed -b onlyCDS.genes.bed  -wb | cut -f1,2,3,7 > inter.bed 
sort -k 1,1 -k2,2n inter.bed > inter2.bed
bedtools merge -i inter2.bed -c 4 -o distinct > callable.cds.bed

vcftools --gzvcf muir.final.vcf.gz --remove-filtered-all --remove-indels --min-alleles 2 --max-alleles 2 --mac 1 --max-missing 0.5 --remove ingroup.remove.indv --recode --recode-INFO-all --out muir
vcftools --gzvcf gasAcu.final.vcf.gz --remove-filtered-all --remove-indels --min-alleles 2 --max-alleles 2 --maf 0 --max-missing 0.5 --recode --recode-INFO-all --out gasAcu


#### Shunda ####
cd shunda_gasAcu
