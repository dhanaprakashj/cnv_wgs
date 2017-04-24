#!/bin/bash --login
#-*- coding: utf-8 -*-

outdir=/home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/paths
for line in $( ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/sequence/ ); do
    paste --delimiter='/' \
    <(ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/sequence/$line/cnvDetailsDiploidBeta* | cut -d "/" -f1-9) \
    <(ls -1 /work/projects/isbsequencing/epilepsy_lcsb/sequence/$line/*/*/ASM/CNV/cnvDetailsDiploidBeta* | cut -d/ -f12) \
    > $outdir/$line.in

    ls -1 /work/projects/isbsequencing/epilepsy_lcsb/sequence/$line/*/*/ASM/CNV/cnvDetailsDiploidBeta* | cut -d/ -f8 \
    > $outdir/$line.names
done


# for line in $( ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/sequence/ ); do
#     ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/sequence/$line/cnvDetailsDiploidBeta-*.tsv.bz2  > $outdir/$line.in
# done

# Alternative if used with a samples.in(containing sample names) file
# cat $1 | while read line
# do
#     ls -1 /work/projects/isbsequencing/epilepsy_lcsb/sequence/$line/*/GS*/ASM/CNV/cnvDetailsDiploidBeta-*.tsv.bz2  > $outdir/$line.in
# done
