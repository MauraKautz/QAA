#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=fastqc_trimmed_%j.out
#SBATCH --error=fastqc_trimmed_%j.err

/usr/bin/time -v fastqc -o /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/fastqc_trimmed/ /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/4_1.trimmed.fastq.gz /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/4_2.trimmed.fastq.gz
/usr/bin/time -v fastqc -o /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/fastqc_trimmed/ /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/34_1.trimmed.fastq.gz /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/34_2.trimmed.fastq.gz