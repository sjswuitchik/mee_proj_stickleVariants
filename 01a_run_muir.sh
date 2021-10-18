## in /home/sjsmith/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir on Cedar (CC HPC) 
## FASTQs live in /scratch/sjsmith/muir 

# nb: in ~/projects/def-jonmee/sjsmith/
# snakemake can have issues with too many `.` in filenames, so download brename to rename all FASTQs before making sample lists
wget https://github.com/shenwei356/brename/releases/download/v2.11.1/brename_linux_amd64.tar.gz
tar zxvf brename_linux_amd64.tar.gz 
rm brename_linux_amd64.tar.gz


# clone in pipeline repo
git clone https://github.com/harvardinformatics/shortRead_mapping_variantCalling.git
git checkout dev # to work with write_samples.py for metadata creation that's in dev 

# make sample lists and move to working dir
cd /scratch/sjsmith/muir/
ls *_R1.fastq.gz > mR1s.txt
sed 's/\_R1\.fastq\.gz//g' mR1s.txt > muir_samples.txt
mv muir_samples.txt ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir/shortRead_mapping_variantCalling/

# download ref genome
cd  ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir/shortRead_mapping_variantCalling/
mkdir data/genome/
cd data/genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz
cd ../../workflow

# make sample metadata sheets
python3 write_samples.py -s ../muir_samples.txt -f /scratch/sjsmith/muir/ -r ../data/genome/GCF_902500615.1_NSP_V7_genomic.fna.gz -o Pungitius_pungitius
cd ../

# run pipeline - nb: to run on Cedar, removed #SBATCH -p shared from run_pipeline.sh bc that is Cannon specific
sbatch --account=def-jonmee run_pipeline.sh
