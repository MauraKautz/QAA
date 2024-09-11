#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=1-0
#SBATCH --output=htseq_count_%j.out
#SBATCH --error=htseq_count_%j.err

/usr/bin/time -v htseq-count \
    --stranded=yes \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_4Aligned.out.sam \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.112.gtf \
    > 4_stranded.txt

/usr/bin/time -v htseq-count \
    --stranded=reverse \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_4Aligned.out.sam \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.112.gtf \
    > 4_reverse.txt

/usr/bin/time -v htseq-count \
    --stranded=yes \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_34Aligned.out.sam \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.112.gtf \
    > 34_stranded.txt

/usr/bin/time -v htseq-count \
    --stranded=reverse \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/star_output/STAR_alignReads_34Aligned.out.sam \
    /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.112.gtf \
    > 34_reverse.txt

