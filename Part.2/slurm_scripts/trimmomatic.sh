#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=trimmomatic_%j.out
#SBATCH --error=trimmomatic_%j.err

/usr/bin/time -v trimmomatic PE \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/cutadapt_output/cutadapt_4_1.fastq.gz \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/cutadapt_output/cutadapt_4_2.fastq.gz \
    4_1.trimmed.fastq.gz 4_1.un.trimmed.fastq.gz \
    4_2.trimmed.fastq.gz 4_2.un.trimmed.fastq.gz \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:5:15 \
    MINLEN:35

/usr/bin/time -v trimmomatic PE \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/cutadapt_output/cutadapt_34_1.fastq.gz \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/cutadapt_output/cutadapt_34_2.fastq.gz \
    34_1.trimmed.fastq.gz 34_1.un.trimmed.fastq.gz \
    34_2.trimmed.fastq.gz 34_2.un.trimmed.fastq.gz \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:5:15 \
    MINLEN:35