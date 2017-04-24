#!/bin/bash --login

# This script reads the input file line by line and cuts the path of the file to extract the sample name.
# The extracted names are stored in $family.names file.

# Example command
# sh cnv_cutNames.sh
#   ${family}.in

while read line
do
    (basename "$line" -ASM.tsv.bz2)
done < $1 \
| cut -d"-" -f2 > $2

# while read line
# do
#     (basename "$line" -ASM.tsv.bz2)
# done < $1 \
# | cut -d"-" -f2,3 \
# | cut -d"_" -f1,2 > $2
