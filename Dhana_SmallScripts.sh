#!/bin/bash --login
#-*- coding: utf-8 -*-

# To open the Genome map and extract columns 1,4,5 and ID from attributes column{9th}:
cat /work/projects/isbsequencing/data/dgv/GRCh37_hg19_filtered_2014-10-16.gff3 | awk '{ split($9,a , ";"); printf("%s\t%s\t%s\t%s\n",$1,$4,$5, a[1]); }' > /home/users/djambulingam/dhana/scripts/cnv/GRCh37_hg19_filtered_2014-10-16.gff3


comm -1 -2 <(cat ../epilepsy_autosomal_recessive/analysis/*/*.tsv | rev | cut -f2 | rev | grep -v OverlappingGenes | sed '/^$/d' | sed 's/\;/\n/g' |sort | uniq | less) <(cat /work/projects/isbsequencing/epilepsy/data/candidateGenes/epilepsy.112014.ids | sort) | less

perl -ne 'print if ($seen{$_} .= @ARGV) =~ /10$/' <(cat ../epilepsy_autosomal_recessive/analysis/*/*.tsv | rev | cut -f2 | rev | grep -v OverlappingGenes | sed '/^$/d' | sed 's/\;/\n/g' |sort | uniq | less) <(cat /work/projects/isbsequencing/epilepsy/data/candidateGenes/epilepsy.112014.ids | sort) | less

cat ../../epilepsy_autosomal_recessive/analysis/*/*.tsv | rev | cut -f2 | rev | grep -v OverlappingGenes | sed '/^$/d' | sed 's/\;/\n/g' | sort | uniq -c | sort -nr | less


To cut names from path from pathfile;
while read line
do
(basename "$line" -ASM.tsv.bz2)
done < $1 \
| cut -d"-" -f2 \
| awk '{printf("%s\t", $0)}'


# To cut and join path with name
paste --delimiter='/' <(ls -1 ~/dhana/$family/cnv* | cut -d "/" -f1-6) <(ls -1f /work/projects/isbsequencing/epilepsy/sequence/$family/*/*/ASM/CNV/cnvDetailsDiploidBeta* | cut -d/ -f12) > $family.in

# To re arrange columns and extract the matching ploidy scores in affected samples.
awk -F'\t' -v OFS='\t' '{ print $1, $2, $3, $5, $6, $9, $4, $7, $8, $10, $11, $12, $13, $14, $15, $16 }' <(cat <(head -n1 ~/dhana/Analysis/re-648/CNV/re-648.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes) <(grep "Inconsistent" ~/dhana/Analysis/re-648/CNV/re-648.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes | grep -v "NA" | awk -F '\t' '$5 == $6 && $6 == $9 '))
