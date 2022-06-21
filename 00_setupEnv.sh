conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake 
conda install -n snakemake -c conda-forge pandas yappi pyyaml

conda create -n gatk -c bioconda -c conda-forge gatk4 vcftools pandas numpy
