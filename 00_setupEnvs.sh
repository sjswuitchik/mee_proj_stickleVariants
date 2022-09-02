# for snpArcher
conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake 
conda install -n snakemake -c conda-forge pandas yappi pyyaml

# for output processing
conda create -n gatk -c bioconda -c conda-forge gatk4 vcftools pandas numpy

# for MK tests
conda create -n mk -c bioconda -c conda-forge -c ets cyvcf2>=0.30.14 tqdm>=4.63.0 bcftools>=1.15 vcftools>=0.1.16 htslib>=1.14 snpeff==5.1 bedtools>=2.30.0 jdk11-ac r-base>=4.1.2 r-tidyverse>=1.3.1 r-r2jags>=0.7_1 r-lme4>=1.1_21 r-arm>=1.12_2
