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


# NB: some gasAcu processing as an outgroup is contained within the Muir workflow below. Shunda workflow will use some gasAcu outputs from Muir workflow 

#### Muir #### 
cd muir_gasAcu
# set up before filtering VCF
gunzip genes.gff.gz
mamba activate vcf
vcftools --gzvcf muir.final.vcf.gz --missing-indv --out muir
mamba deactivate

mamba activate r
Rscript --vanilla missingness.R muir.imiss 
mamba deactivate 

awk -f ../helper_scripts/cds.awk genes.gff > onlyCDS.gff
awk -f ../helper_scripts/gff2bed.awk onlyCDS.gff > onlyCDS.bed
awk -v OFS='\t' 'match($0, /gene=[^;]+/) {print $1, $2, $3, substr($0, RSTART+5, RLENGTH-5)}' onlyCDS.bed > onlyCDS.genes.bed

mamba activate vcf 
bedtools intersect -a muir.callable_sites_cov.bed -b gasAcu.callable_sites.bed > callable.bed
# troubleshooting issues with Cedar + core dumps
bedtools intersect -a callable.bed -b onlyCDS.genes.bed  -wb | cut -f1,2,3,7 > inter.bed 
sort -k 1,1 -k2,2n inter.bed > inter2.bed
bedtools merge -i inter2.bed -c 4 -o distinct > callable.cds.bed

vcftools --gzvcf muir.final.vcf.gz --remove-filtered-all --remove-indels --min-alleles 2 --max-alleles 2 --mac 1 --max-missing 0.5 --remove ingroup.remove.indv --recode --recode-INFO-all --out muir.filter
# kept 3945454 out of a possible 34674028 Sites
vcftools --gzvcf gasAcu.final.vcf.gz --remove-filtered-all --remove-indels --min-alleles 2 --max-alleles 2 --maf 0 --max-missing 0.5 --recode --recode-INFO-all --out gasAcu.filter 
# kept 9009486 out of a possible 13350104 Sites

bedtools intersect -a muir.filter.recode.vcf -b callable.bed -header > muir.clean.vcf
bedtools intersect -a gasAcu.filter.recode.vcf -b callable.bed -header > gasAcu.clean.vcf

sbatch --account=def-jonmee run_snpEff_muir.sh
sbatch --account=def-jonmee run_snpEff_gasAcu.sh

python3 ../helper_scripts/annot_parser.py muir.ann.vcf muir.ann.bed -key missense_variant -key synonymous_variant
python3 ../helper_scripts/annot_parser.py gasAcu.ann.vcf gasAcu.ann.bed -key missense_variant -key synonymous_variant

bedtools intersect -a muir.ann.bed -b onlyCDS.genes.bed -wb | cut -f1,2,3,4,8 | bedtools sort -i - | bedtools merge -i - -d -1 -c 4,5 -o distinct > muir.final.bed
bedtools intersect -a gasAcu.ann.bed -b onlyCDS.genes.bed -wb | cut -f1,2,3,4,8 | bedtools sort -i - | bedtools merge -i - -d -1 -c 4,5 -o distinct > gasAcu.final.bed

vcftools --vcf muir.ann.vcf --missing-site --out muir
vcftools --vcf gasAcu.ann.vcf --missing-site --out gasAcu
mamba deactivate 

sbatch --account=def-jonmee run_snipre_muir.sh


#### Shunda ####
cd shunda_gasAcu
mamba activate vcf 
vcftools --gzvcf shunda.final.vcf.gz --missing-indv --out shunda
mamba deactivate 

mamba activate r
Rscript missingness.R shunda.imiss
mamba deactivate 

cp ../muir_gasAcu/onlyCDS.genes.bed ../muir_gasAcu/gasAcu.filter.recode.vcf .

mamba activate vcf
bedtools intersect -a shunda.callable_sites_cov.bed -b gasAcu.callable_sites.bed > callable.bed
bedtools intersect -a callable.bed -b onlyCDS.genes.bed  -wb | cut -f1,2,3,7 > inter.bed 
sort -k 1,1 -k2,2n inter.bed > inter2.bed
bedtools merge -i inter2.bed -c 4 -o distinct > callable.cds.bed

vcftools --gzvcf shunda.final.vcf.gz --remove-filtered-all --remove-indels --min-alleles 2 --max-alleles 2 --mac 1 --max-missing 0.5 --remove ingroup.remove.indv --recode --recode-INFO-all --out shunda.filter
# 

bedtools intersect -a shunda.filter.recode.vcf -b callable.bed -header > shunda.clean.vcf
bedtools intersect -a gasAcu.filter.recode.vcf -b callable.bed -header > gasAcu.clean.vcf

sbatch --account=def-jonmee run_snpEff_shunda.sh
sbatch --account=def-jonmee run_snpEff_gasAcu_shunda.sh
