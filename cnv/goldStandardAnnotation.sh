#!/bin/bash --login

# The script annotates the file ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes with dgvGoldStandard data.

# Example command
# sh cnv_goldStandardAnnotation.sh \
#     ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes \
#     > ${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard


Annotation_Gene=/home/users/djambulingam/dhana/scripts/cnv/Dhana_DGV.GoldStandard.July2015.hg19.gff3
cgaInput=$1

cgatools join \
--beta \
--input $cgaInput $Annotation_Gene \
--match chromosome:seqid \
--overlap begin,end:start,end \
--always-dump \
--output-mode compact \
--select 'A.*,B.attributes'
