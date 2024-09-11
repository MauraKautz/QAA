#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=34_R2_%j.out
#SBATCH --error=34_R2_%j.err

/usr/bin/time -v ./mean_qual.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/34_4H_both_S24_L008_R2_001.fastq.gz -l 101 -o 34_R2.png
