# for snpArcher
conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake 
conda install -n snakemake -c conda-forge pandas yappi pyyaml

# for output processing
conda create -n gatk -c bioconda -c conda-forge gatk4 vcftools pandas numpy

# for MK tests - was having issues with conda on Cedar building from the yml files, so doing it this way instead
conda create -n r -c bioconda -c conda-forge -c r r-base
conda activate r
conda install -c bioconda -c conda-forge -c r r-tidyverse r-r2jags r-lme4 r-arm

conda create -n snpeff -c bioconda -c conda-forge -c ets snpeff
conda activate snpeff
conda install -c bioconda -c conda-forge -c ets cyvcf2 tqdm bcftools vcftools htslib bedtools jdk11-ac
