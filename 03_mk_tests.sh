# process gasAcu outgroup aligned to punPun with snpArcher from BioProject PRJNA639125
# in /scratch/sjsmith/mk_tests
## based off https://github.com/sjswuitchik/compPopGen_ms/tree/master/MKpipeline

conda activate snpeff
#### Muir #### 
cd muir_gasAcu
vcftools --gzvcf muir.final.vcf.gz --missing-indv 
Rscript --vanilla missingness.R muir.imiss gasAcu.imiss

#### Shunda ####
cd shunda_gasAcu
