## in /home/sjsmith/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/shunda on Cedar (CC HPC) 
## FASTQs live in /scratch/sjsmith/shunda

# clone in pipeline repo
git clone https://github.com/harvardinformatics/shortRead_mapping_variantCalling.git
git checkout dev # to work with write_samples.py for metadata creation that's in dev 

# make sample lists and move to working dir
cd /scratch/sjsmith/shunda/
.././brename -e -p "\." -r "_" -R
.././brename -e -p "_fastq" -r ".fastq" -R 
ls *_R1.fastq.gz > sR1s.txt
sed 's/\_R1\.fastq\.gz//g' sR1s.txt > shunda_samples.txt
mv shunda_samples.txt ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/shunda/shortRead_mapping_variantCalling/

# download ref genome
cd  ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/shunda/shortRead_mapping_variantCalling/
mkdir data/genome/
cd data/genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz
cd ../../workflow

# make sample metadata sheets
python3 write_samples.py -s ../shunda_samples.txt -f /scratch/sjsmith/shunda/ -r ../data/genome/GCF_902500615.1_NSP_V7_genomic.fna.gz -o Pungitius_pungitius
cd ..

# run pipeline - nb: to run on Cedar, removed #SBATCH -p shared from run_pipeline.sh bc that is Cannon specific
sbatch --account=def-jonmee run_pipeline.sh
