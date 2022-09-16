# process gasAcu outgroup aligned to punPun with snpArcher from BioProject PRJNA639125
# in /scratch/sjsmith/mk_tests
## based off https://github.com/sjswuitchik/compPopGen_ms/tree/master/MKpipeline

conda activate snpeff
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
Rscript --vanilla missingness.R muir.imiss ## double check this




awk -f ../helper_scripts/cds.awk genes.gff > onlyCDS.gff
awk -f ../helper_scripts/gff2bed.awk onlyCDS.gff > onlyCDS.bed
awk -v OFS='\t' 'match($0, /gene=[^;]+/) {print $1, $2, $3, substr($0, RSTART+5, RLENGTH-5)}' onlyCDS.bed > onlyCDS.genes.bed
bedtools intersect -a muir.callable_sites_cov.bed -b gasAcu.callable_sites.bed > callable_sites.bed
bedtools intersect -a callable.bed -b onlyCDS.genes.bed  -wb | cut -f1,2,3,7 | bedtools sort -i - | bedtools merge -i - -c 4 -o distinct > callable.cds.bed


#### Shunda ####
cd shunda_gasAcu
