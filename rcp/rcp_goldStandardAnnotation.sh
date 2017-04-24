#!/bin/bash --login

# This script uses cgatools to annotate the file $family.Genes.
# The output of the script is in file $family.Genomes.

Annotation_Gene=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/scripts/cnv/Dhana_DGV.GoldStandard.July2015.hg19.gff3
cgaInput=$1

cgatools join \
--beta \
--input $cgaInput $Annotation_Gene \
--match chromosome:seqid \
--overlap begin,end:start,end \
--always-dump \
--output-mode compact \
--select 'A.*,B.attributes'
