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
vcftools --gzvcf muir.final.vcf.gz --missing-indv --out muir
Rscript --vanilla missingness.R muir.imiss

#### Shunda ####
cd shunda_gasAcu
