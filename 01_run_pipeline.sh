## in /home/sjsmith/projects/def-jonmee/sjsmith/mee_proj_stickleVariants on Cedar (CC HPC) 
## FASTQs live in /scratch/sjsmith/muir and /scratch/sjsmith/shunda

# make sample lists and move to working dir
cd /scratch/sjsmith/muir/
ls *_R1.fastq.gz > mR1s.txt
sed 's/\_R1\.fastq\.gz//g' mR1s.txt > muir_samples.txt
mv muir_samples.txt ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/

cd ../shunda
ls *_R1.fastq.gz > sR1s.txt
sed 's/\_R1\.fastq\.gz//g' sR1s.txt > shunda_samples.txt
mv shunda_samples.txt ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/

# download ref genome
cd  ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/
mkdir data/genome/
cd data/genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz
cd ../..

# make sample metadata sheets
python3 write_samples.py muir_samples.txt /scratch/sjsmith/muir/ data/genome/ Pungitius_pungitius

# clone in pipeline repo
git clone https://github.com/harvardinformatics/shortRead_mapping_variantCalling.git





cd shortRead_mapping_variantCalling/


