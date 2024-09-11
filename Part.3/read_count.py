#!/usr/bin/env python

import argparse

def get_arg():
   parser = argparse.ArgumentParser(description="")
   parser.add_argument("-f", help="specify sam file", required=True, type=str)
   return parser.parse_args()

args = get_arg()
f=args.f

mapped_reads = 0
unmapped_reads = 0

with open (f, "r") as samfile:

    while True:
        line = samfile.readline()
        if line == '':
            break
        line = line.split("\t")

        if line[0].startswith("@"):
            continue

#statement will check if the current read is mapped
        flag = int(line[1])
        if((flag & 256) != 256):
            if((flag & 4) != 4):
                mapped_reads += 1
            else:
                unmapped_reads += 1

print("mapped reads:", mapped_reads)
print("unmapped reads:", unmapped_reads)