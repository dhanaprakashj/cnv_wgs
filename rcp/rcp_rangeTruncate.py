#!/usr/bin/env python

# This script reads the file ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA and truncates the range values with similar ploidy across the entire record.

# Example command
# python rcp_rangeTruncate.py \
#         ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA \
#         ${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate

import sys

inFile = open(sys.argv[1], 'r')
outFile = open(sys.argv[2], "w")

l=1
for line in inFile:
	fields = line.split()
	n = len(fields)
	if l==1:
		column = range(n)
		for i in range(0,n):
			outFile.write(fields[i]+"\t")
		outFile.write("\n")
	elif l == 2:
		for i in range (0,n):
			column[i]  = fields[i]

	else:
			if fields[0] == column[0]:
				for j in range(3,n):
					if fields[j]==column[j]:
						continue
					else:
						for k in range(0,n):
							outFile.write(column[k] + "\t")
						outFile.write("\n")
						for m in range(0,n):
							column[m] = fields[m]
						break
				else:
					for o in range(2,n):
						column[o] = fields[o]
			else:
				for k in range(0,n):
					outFile.write(column[k] + "\t")
				outFile.write("\n")
				for i in range (0,n):
					column[i]  = fields[i]
	l = l+1
for k in range(0,n):
		outFile.write(column[k] + "\t")
outFile.write("\n")

