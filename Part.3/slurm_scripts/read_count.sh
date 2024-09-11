#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=read_count_%j.out
#SBATCH --error=read_count_%j.err

/usr/bin/time -v ./read_count.py \
    -f /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_4Aligned.out.sam

/usr/bin/time -v ./read_count.py \
    -f /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_34Aligned.out.sam