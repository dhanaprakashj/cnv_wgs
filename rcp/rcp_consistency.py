#!/usr/bin/env python

# This script reads the file ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate and checks if the ploidy across a single record is consistent and tags them whether they are consistent/Inconsistent.

# Example command
# python rcp_consistency.py \
#         ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate \
#         ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency

import sys
inFile = open(sys.argv[1], 'r')
outFile = open(sys.argv[2], 'w')

l = 1
for line in inFile:
    fields = line.split()
    n=len(fields)
    column = range(n+1)
    if l == 1:
        for i in range(0,n):
            column[i] = fields[i]
            outFile.write(column[i]+"\t")
        column[n] = "Consistency"
        outFile.write(column[n])
        outFile.write("\n")
    else:
        for i in range(0,n):
            column[i]= fields[i]
            column[n]= "Consistent"
        for i in range(3,n-1):
            if column[i]==column[i+1]:
                continue
            else:
                column[n] = "Inconsistent"
        for i in range(0,n+1):
            outFile.write(column[i]+"\t")
        # outFile.write(column[n])
        outFile.write("\n")
    l= l+1
