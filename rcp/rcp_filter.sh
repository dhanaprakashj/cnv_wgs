#!/bin/bash

# This script reads the files in the CGIASM.seg.gz files and unzips the files in their respective directories.

# Example command 
# sh rcp_filter.sh
#     $samples.rcp.in

cat $1 | while read line
do
    gunzip -c $line > `echo $line | sed s/.gz//`
done
