## in /home/sjsmith/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir on Cedar (CC HPC) 
## FASTQs live in /scratch/sjsmith/muir 

# clone in pipeline repo
git clone https://github.com/harvardinformatics/snpArcher.git

# make sample lists and move to working dir
cd /scratch/sjsmith/muir/
ls *_R1.fastq.gz > mR1s.txt
sed 's/\_R1\.fastq\.gz//g' mR1s.txt > muir_samples.txt
cp muir_samples.txt ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir/snpArcher/

# download ref genome
cd  ~/projects/def-jonmee/sjsmith/mee_proj_stickleVariants/muir/snpArcher/
mkdir -p data/genome/
cd data/genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/902/500/615/GCF_902500615.1_NSP_V7/GCF_902500615.1_NSP_V7_genomic.fna.gz
cd ../../workflow

# make sample metadata sheets
python3 write_samples.py -s ../muir_samples.txt -f /scratch/sjsmith/muir/ -r ../data/genome/GCF_902500615.1_NSP_V7_genomic.fna.gz -o Pungitius_pungitius
cd ../

# run pipeline - nb: to run on Cedar, removed #SBATCH -p shared from run_pipeline.sh bc that is Cannon specific, added account:  def-jonmee under __default__ in profiles/slurm/cluster_config.yml
sbatch --account=def-jonmee run_pipeline.sh
