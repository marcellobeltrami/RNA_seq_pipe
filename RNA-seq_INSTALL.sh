# Create a directory for RNA-seq tools and navigate into it
mkdir RNA-seq
cd RNA-seq

# Download and unzip FastQC
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
unzip fastqc_v0.12.1.zip 

# Download and unzip Trimmomatic
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip

# Clone HISAT2 from the GitHub repository and build it
git clone https://github.com/DaehwanKimLab/hisat2.git
cd hisat2
make

# Install the Subread package using apt
sudo apt install subread

# Create a directory named "Data" in your home directory
mkdir ~/RNA-seq/Data
