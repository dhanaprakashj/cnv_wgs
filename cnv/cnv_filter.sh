#!/bin/bash

# This script reads cnvDetailsDiploidBeta file and filters out ploidy values less than 10.
# Example command
# sh cnv_filter.sh \
#     ${family}.in


TODAY=$(date)
HOST=$(hostname)
echo "-----------------------------------------------------"
echo "Date: $TODAY  Host:$HOST"
echo "-----------------------------------------------------"

family=$(basename $1 .in)
outdir=/home/users/djambulingam/dhana/isbsequencing/epilepsy_autosomal_recessive/sequence/${family}/
mkdir -v ${outdir}

cat $1 | while read line
do
    bzip2 -vdc ${line} | awk -F '\t' 'BEGIN {OFS=FS} { if (($10) > 10)  print $0 }' | bzip2 > ${outdir}/$(basename ${line})
done
