# for snpArcher
conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake 
conda install -n snakemake -c conda-forge pandas yappi pyyaml

# for output processing
conda create -n gatk -c bioconda -c conda-forge gatk4 vcftools pandas numpy

# for MK tests - was having issues with conda on Cedar building from the yml files, so doing it this way instead
conda create -n snpeff -c bioconda -c ets snpeff jdk11-ac
conda activate snpeff
conda install -c bioconda -c conda-forge cyvcf2 tqdm bcftools vcftools htslib bedtools 
conda install -c bioconda -c conda-forge -c r r-base r-tidyverse r-r2jags r-lme4 r-arm
