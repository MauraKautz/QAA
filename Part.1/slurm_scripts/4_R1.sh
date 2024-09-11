#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=4_R1_%j.out
#SBATCH --error=4_R1_%j.err

/usr/bin/time -v ./mean_qual.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R1_001.fastq.gz -l 101 -o 4_R1.png
