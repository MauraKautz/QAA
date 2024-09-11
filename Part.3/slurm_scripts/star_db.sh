#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8


/usr/bin/time -v STAR \
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --genomeFastaFiles /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.dna.primary_assembly.fa \
    --sjdbGTFfile /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.112.gtf