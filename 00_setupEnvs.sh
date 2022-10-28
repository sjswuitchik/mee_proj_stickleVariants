# for snpArcher
conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake 
conda install -n snakemake -c conda-forge pandas yappi pyyaml perl

# for output processing
conda create -n gatk -c bioconda -c conda-forge gatk4 vcftools pandas numpy

# for MK tests - was having issues with conda on Cedar building from the yml files, so doing it this way instead
mamba create -n snpeff -c bioconda -c ets snpeff jdk11-ac

mamba create -n r -c conda-forge r-tidyverse r-r2jags r-lme4 r-arm

mamba create -n vcf -c bioconda -c conda-forge bcftools vcftools htslib bedtools cyvcf2 tqdm 



