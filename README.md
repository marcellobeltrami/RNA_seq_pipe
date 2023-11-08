# RNA_seq_pipe 📌

## Overview

This script automates a basic RNA-Seq data analysis workflow. It assumes that you have previously run an installation script.

## Assumptions

1. The `RNA-seq_INSTALL.sh` installation script has been run.
2. You are currently in the `RNA-seq` directory during installation, and three required data files are in the `~/RNA-seq/Data` directory.
3. RNA reads have been generated using a stranded protocol.
4. To run installation and pipeline, make them executable with `chmod +x [script_name]`. 
 
## Usage

1. **Installation Check:**

   - When you run the script, it will first ask if you have used the installation file (`Y/N`). Answer 'Y' if you have, and 'N' if you haven't.

2. **Data File Path:**

   - Next, provide the data file path (e.g., `~/RNA-seq/Data/data.fastq`) when prompted. Ensure this file exists.

3. **Genome File Path:**

   - Enter the base name map genome file path (e.g., `~/RNA-seq/Data/genome`).

4. **Genome Annotation File Path:**

   - Provide the genome annotation file path (e.g., `~/RNA-seq/Data/gen_annotation.gtf`).

## Workflow Steps

### Step 1: Check Quality of Reads

- The script uses FastQC to check the quality of the reads and stores the output in `~/RNA-seq/Data/Results/fastqc_output`.

### Step 2: Trim Poor Quality Reads (Optional)

- The script will ask if trimming is required (`Y/N`). If 'Y' is selected, it uses Trimmomatic to trim the reads and stores the trimmed output in `~/RNA-seq/Data/Results/fastqc_trim_output`.

### Step 3: Map Reads to a Genome

- The script uses HISAT2 to map reads to the genome. If trimming was performed, it uses the trimmed data; otherwise, it uses the original data. The results are saved in `~/RNA-seq/Data/Results/hisat2_out`.

### Step 4: Run FeatureCounts

- Finally, the script uses FeatureCounts to count the mapped reads and generates an output file at `~/RNA-seq/Data/Results/output_featurecounts.txt`.

## Error Handling

- The script checks for the availability of required tools like Java, HISAT2, Samtools, and FeatureCounts. If any of these tools are not available, it will display an error message and exit.

## Directory Structure

The script expects a specific directory structure. It creates required directories if they do not exist.

## To-Do

- Check if all the file names make sense and test the script.

## Disclaimer

This script serves as a basic RNA-Seq analysis template. Make sure to adapt it to your specific data, tools, and file names. Ensure that the necessary tools are correctly configured and available in your system.

**Author:** Marcello Beltrami
**Last Updated:** 26/09/2023

