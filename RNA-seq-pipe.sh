#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check for tool availability
if ! command_exists java || ! command_exists hisat2 || ! command_exists samtools || ! command_exists featureCounts; then
  echo "Error: Required tools are not installed. Please install them and make sure they are in your PATH."
  exit 1
fi

# Function to create a directory if it doesn't exist
create_directory() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Read user input
echo "0/3 Have you used the installation file (Y/N):"
read installation

echo "1/3 Please enter your data file path (e.g., ~/RNA-seq/Data/data.fastq):"
read data_path

echo "2/3 Please enter your base name map genome file path (e.g., ~/RNA-seq/Data/genome):"
read map_genome

echo "3/3 Please enter genome annotation file path (e.g., ~/RNA-seq/Data/gen_annotation.gtf):"
read genome_annotation

# Generate output directories
create_directory ~/RNA-seq/Data/Results
create_directory ~/RNA-seq/Data/Results/fastqc_output
create_directory ~/RNA-seq/Data/Results/fastqc_trim_output
create_directory ~/RNA-seq/Data/Results/hisat2_out

# Step 1: Check quality of reads and trims if required.

./FastQC/fastqc "$data_path" -o ~/RNA-seq/Data/Results/fastqc_output

# Step 2: Trim poor quality reads if needed.
echo "Is trimming required? (Y/N)"
read trimming_req

if [[ "$trimming_req" == "Y" ]]; then
  cd Trimmomatic-0.39
  echo "Trimmomatic running..."
  java -jar trimmomatic-0.39.jar SE -threads 4 -phred33 "$data_path" ~/RNA-seq/Data/Results/fastqc_trim_output/demo_trimmed.fastq TRAILING:10
  echo "Trimmomatic finished!"
  cd ~/RNA-seq

  echo "Running FastQC again..."
  ./FastQC/fastqc ~/RNA-seq/Data/Results/fastqc_trim_output/demo_trimmed.fastq -o ~/RNA-seq/Data/Results/fastqc_trim_output/
fi

# Step 3: Map reads to a genome with hisat2
if [[ "$trimming_req" == "Y" ]]; then
  # Run alignment using trimmed sequences
  hisat2 -q --rna-strandness "$map_genome" -U ~/RNA-seq/Data/Results/fastqc_trim_output/demo_trimmed.fastq | samtools sort -o ~/RNA-seq/Data/Results/hisat2_out/demo_trimmed.bam
else
  # Run with original data
  hisat2 -q --rna-strandness "$map_genome" -U "$data_path" | samtools sort -o ~/RNA-seq/Data/Results/hisat2_out/result_untrimmed.bam
fi

# Step 4: Run featureCounts
featureCounts -S 2 -a "$genome_annotation" -o ~/RNA-seq/Data/Results/output_featurecounts.txt ~/RNA-seq/Data/Results/hisat2_out/result_untrimmed.bam
