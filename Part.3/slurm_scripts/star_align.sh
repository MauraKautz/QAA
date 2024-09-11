#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/4_1.trimmed.fastq.gz /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/4_2.trimmed.fastq.gz \
    --genomeDir /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --outFileNamePrefix STAR_alignReads_4

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/34_1.trimmed.fastq.gz /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.2/trimmomatic_output/34_2.trimmed.fastq.gz \
    --genomeDir /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/Mus_musculus.GRCm39.dna.ens112.STAR_2.7.11b \
    --outFileNamePrefix STAR_alignReads_34