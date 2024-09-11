# RNA-seq Quality Assessment - Bi623

## Objective:
 The objectives of this assignment are to use existing tools for quality assessment and adaptor trimming, compare the quality assessments to those from my own software, and to demonstrate my ability to summarize other important information about this RNA-Seq data set in a high-level report.

 ### Data
 Library assignments for demulitplexed pairs are here: ```/projects/bgmp/shared/Bi623/QAA_data_assignments.txt```

 The demultiplexed, gzipped `.fastq` files are here: ```/projects/bgmp/shared/2017_sequencing/demultiplexed/```

 **Do not move, copy, or unzip these fastq files**

 ## Part 1 – Read quality score distributions

 ### August 25, 2024:

- Created my own QAA repository by clicking on "use this template" on [Leslie's QAA repository](https://github.com/Leslie-C/QAA).

- Git cloned the repository onto Talapas in Bi623:
 
    ```$ git clone https://github.com/MauraKautz/QAA.git```

- Moved onto an interactive node for conda environment creation:

    ```$ srun --account=bgmp --partition=bgmp --time=8:00:00 --pty bash```

- Created and activated new conda environment `QAA`:

    ```$ conda create -n QAA```

    ```$ conda activate QAA```

- Installed and checked version of tools package `FastQC`:

    ```$ conda install fastqc```

    ```$ fastqc --version```

    * Version verified as 0.12.1!

- Viewed data assignment in ```/projects/bgmp/shared/Bi623/QAA_data_assignments.txt```:

    ```$ cd /projects/bgmp/shared/Bi623```

    ```$ cat QAA_data_assignments.txt```

    **Data assignment: 4_2C_mbnl_S4_L008, 34_4H_both_S24_L008**

### August 28, 2024:

- Created `fastqc_output` file to hold fastqc files

    ```$ mkdir fastqc_output```

- Run fastqc on both sets of files

    ```$ fastqc -o fastqc_output/ /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R2_001.fastq.gz```

### September 4, 2024:

- Created 4 different sbatch scripts to run the [mean_qual.py](mean_qual.py) script from Demultiplex Part 1 in Bi622 on my assigned files. Here is an example script: using the path to read 1 of file 4, length is equal to 101 nucleotides, and output file is a png.

    ```
    #!/bin/bash
    #SBATCH --account=bgmp
    #SBATCH --partition=bgmp
    #SBATCH --time=1-0
    #SBATCH --output=4_R1_%j.out
    #SBATCH --error=4_R1_%j.err
    
    /usr/bin/time -v ./mean_qual.py -f /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R1_001.fastq.gz -l 101 -o 4_R1.png
    ```

- Output is `4_R1.png` `4_R2.png` `34_R1.png` `34_R2.png`

### September 5, 2024:

- Reran `fastqc` using an sbatch script so that I could include `/usr/bin/time -v` and get an output file including stats on time and CPU usage

- Thoughts on `fastqc` and `mean_qual.py` comparison:

        4_R1: 4:32.35, 97%

        4_R2: 4:25.63, 99%

        34_R1: 2:43.01, 95%

        34_R2: 2:38.91, 99%

        FastQC_4: 1:48.56, 95%

        FastQC_34: 1:32.68, 98%

    - *CPU Usage*: using fastqc

    - *Time*: using fastqc is much more time efficient than using my own python code.  On average, creating a plot for one read using my script takes about 4.5 minutes for sample 4 and 2.5 minutes for sample 34. This is also only creating one plot at a time. Using fastqc is very fast, as it can take in multiple files at once and produce plots in about a minute. I also could have made it even more efficient by adding all four files into one fastqc run, which would produce all necessary data in still around 1 minute.

## Part 2 - Adaptor Trimming Comparison

### September 6, 2024:

- Installed `cutadapt` and `Trimmomatic` in QAA environment using `conda install`

    - `cutadapt --version` confirmed 4.9

    - `trimmomatic -version` confirmed 0.39

### September 7, 2024:

- Started by writing a slurm script for running cutadapt

    - `cutadapt --help` showed documentation for how to run cutadapt

    - used flags -a, -A, -o, -p to add adapter 1, adapter 2, output 1, and output 2 respectively, then the input files of R1 and R2 for both samples

    - ran one slurm script with two sections, one for `4_2C_mbnl_S4_L008` and `34_4H_both_S24_L008`

    - cutadapt output 4 files, that were unzipped. used `gzip` to zip them up.

    - moved on to sanity check
 

- Sanity Check:

    - goal was to use unix commands to make sure that Adapter 1 was only in R1 and Adapter 2 was only in R2. this would confirm the sequence orientation.

        - Adapter 1 in Read 1 (4):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | wc -l ```

            `51173`

        - Adapter 2 in Read 1 (4):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l ```

            `0`

        - Adapter 1 in Read 1 (34):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/34_4H_both_S24_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | wc -l ```

            `138880`

        - Adapter 2 in Read 1 (34):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/34_4H_both_S24_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l ```
 
            `0`

        - Adapter 2 in Read 2 (4):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R2_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l ```

            `51593`

        - Adapter 1 in Read 2 (4):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/4_2C_mbnl_S4_L008_R2_001.fastq.gz | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" | wc -l ```

            `0`

        - Adapter 2 in Read 2 (34):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/34_4H_both_S24_L008_R2_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l ```

            `137879`

        - Adapter 2 in Read 1 (34):
``` zcat /projects/bgmp/shared/2017_sequencing/demultiplexed/34_4H_both_S24_L008_R1_001.fastq.gz | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" | wc -l ```

            `0`

        - these unix commands input the reads for the library files and then checked to see if the adapters were present or not. as expected, adapter 1 was only found in R1 for both libraries and adapter 2 was only found in R2 for both libraries. adapter one must be connected to read 1 to begin sequencing.

- Ran cutadapt.sh again to remake the files in a zipped form, because I think trimmomatic needs zipped files to run

- Wrote a slurm script for trimmomatic

    - used `trimmomatic PE`

    - input the cutadapt output R1 and R2 fastq.gz files for both libraries

    - set the following parameters as listed in the instructions:

        - LEADING: quality of 3
        - TRAILING: quality of 3
        - SLIDING WINDOW: window size of 5 and required quality of 15
        - MINLENGTH: 35 bases

- Used unix commands from ICA4 in Bi621 to calculate the trimmed read length distributions for the paired & trimmed output files

    - ```$ zcat <trimmomatic_trimmed_file> | grep -A1 "^@" | grep -v "^--" | grep -v "^@" | awk '{print length($0)}' | sort -n | uniq -c```

- I put the output from the unix commands into text files:

    - `4_1_dist.txt`
    - `4_2_dist.txt`
    - `34_1_dist.txt`
    - `34_2_dist.txt`

- I downloaded these files onto my laptop and then read them in R to use ggplot and create two plots. One plot had both sample 4 reads and one had both sample 34 reads. The following code chunk is how I made the plot for sample 4:

```
dist_1 <- read.table("~/Downloads/4_1_dist.txt") %>% 
  rename(Distribution = V1, Length = V2)

dist_2 <- read.table("~/Downloads/4_2_dist.txt") %>% 
  rename(Distribution = V1, Length = V2)

dist_plot_4 <- ggplot() +
  geom_line(data=dist_1, aes(x=Length, y=Distribution), color = "#00AFBB", linewidth=2) +
  geom_line(data=dist_2, aes(x=Length, y=Distribution), color = "#FC4E07", linewidth=2) +
  theme_bw() +
  scale_y_log10() +
  ggtitle("4_2C_mbnl Length Distribution")
  ```

- The trimmed read length distributions give insight into how much the data was impacted by adapter removal and quality control. It is observed that R2 for both samples appear to have a larger distribution of reads with a shorter length. This may be because degradation begins to occur on the flow cell as Illumina progresses, such as chemical and imaging errors that result in R2 having overall slightly lower quality and the need for more quality trimming. R2 is also more susceptible to having the sequencer read into the adapter sequence if the DNA fragment is shorter, causing adapter trimming to create this distribution.

- Ran `FastQC` on the trimmed data using slurm script `fastqc_trimmed.sh` which was identical to first `FastQC` script just with the trimmed data as input.

- Plotted the length distribution of R1 for both samples with trimmed and untrimmed data to show the difference in distribution length.

## Part 3 - Alignment and Strand Specificity

### September 7, 2024:

- conda installed `star`

- conda installed `numpy` (already present in environment)

- conda installed `matplotlib` (already present in environment)

- conda installed `htseq`

- Found the mouse genome fasta files on Ensemble and used `wget` to donwload the files onto Talapas

- used a slurm script `star_db.sh` to create a reference database out of the mouse genoke files, following the settings specified in PS8 of Bi621

    ```
    --runThreadN 8
    --runMode genomeGenerate
    --genomeDir <See above...>
    --genomeFastaFiles <???>
    --sjdbGTFfile <???>
    ```
- used another slurm scipt `star_align.sh` to align my trimmed R1 and R2 library files to the newly created database

### September 8, 2024:

- imported python script from PS8 to parse through SAM output files from `star_align.sh` and report number of mapped and unmapped reads

    - changed the python script to use argparse instead of hardcoding

    - did not need to update for bitwise flags, already had flags 4 and 256 in python script

    - wrote a slurm script [read_count.sh](read_count.sh) to run [read_count.py](read_count.py) on the SAM output files for sample 4 and 34 at the same time

    - output in [SAM_read_counts.md](SAM_read_counts.md) show both the mapped and unmapped reads for sample 4 and 34 and also below:

        Output from read_count.py from SAM files:

            Sample 4:
            mapped reads: 17172681
            unmapped reads: 788079

            Sample 34:
            mapped reads: 16822666
            unmapped reads: 483616

- ran `htseq-count` to count the reads that map to stranded and reverse features

    - wrote a slurm script [htseq_count.sh](htseq_count.sh) to run samples 4 and 34 at the same with both reverse and stranded flags

    - output went to text files in folder [htseq_count_output](htseq_count_output)

- trying to figure out if the data are from strand specific RNA-seq libraries. used bash commands from ica4 in Bi621 to determine the percentage of reads mapped to features in both the stranded and reversed output files from htseq-count:

```
grep -v "__" /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/htseq_count_output/4_stranded.txt | awk '{sum+=$2} END {print sum}'

awk '{sum+=$2} END {print sum}' /projects/bgmp/mkautz/bioinfo/Bi623/QAA/Part.3/htseq_count_output/4_stranded.txt
```


    - 4 stranded = 3.71%
    - 4 reverse = 80.58%

    - 34 stranded = 5.46%
    - 34 reverse = 83.37%

- I propose that these data are strand specific because 80.58% of the reads in sample 4 are noted as reverse, versus 3.71% of reads noted as stranded. This indicates that the RNA-seq data is reverse stranded or that the sequences of read 2 align to the RNA strand, not those of read 1.  Similarly, 83.37% of sample 34 features are reverse mapped, compared to 5.46% of the sample features indicating forward strandedness. This helps to confirm that both samples were processed using a reverse stranded approach.







