#!/bin/bash --login

# The script adds gene names to the file ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency

# Example command
# sh cnv_geneAnnotation.sh \
#     ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency | sed -e '1 s/name2/OverlappingGenes/' \
#     > ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes


Annotation_Gene=/work/projects/isbsequencing/tools/annovar/2014Nov12/humandb/hg19_refGene.txt.wheader
cgaInput=$1
cgatools join \
--beta \
--input $cgaInput $Annotation_Gene \
--match chromosome:chrom \
--overlap begin,end:txStart,txEnd \
--always-dump \
--output-mode compact \
--select 'A.*,B.name2'
