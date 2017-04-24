#!/usr/bin/env python

# This script takes the files from file ${family}.in and merges with the range file we previously created. The output is written to file ${family}.range_file.cgaJoin

# Example command
# python cnv_cgaJoin.py \
#         ${family}.in \
#         ${family}.range_file \
#         ${family}.range_file.cgaJoin

import subprocess
import sys
import os

referenceRange = sys.argv[2]
a = sys.argv[2] +".temp"
t = "cp" + " " + referenceRange +" " + a
subprocess.call(t,shell=True)
outFile=sys.argv[3]

inFile = open(sys.argv[1],"r")
temp = inFile.read().splitlines()
l =len(temp)
li = 0
for i in temp:
	li = li+1; outFile=sys.argv[3]
	cgaJoin = "cgatools join --beta --input " + a + " " + i + " " + "--match \
		chromosome:chr --overlap begin,end:begin,end \
		--select A.*,B.calledPloidy --always-dump --output-mode compact > " + outFile

	subprocess.call(cgaJoin,shell=True)
	if os.path.isfile(outFile):
		if li != l:
			move = "mv" + " " + outFile +" " + a
			subprocess.call(move,shell = True)
			print("Files merged, removing temporary file \n")
	else:
		print("End of Files \n")
