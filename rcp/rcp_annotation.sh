#!/bin/bash --login

# This script uses cgatools to annotate the file $family.MergedoutNATruncated.
# The output of the script is in file $family.Genes.

Annotation_Gene=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/scripts/cnv/hg19_refGene.txt.wheader
cgaInput=$1

cgatools join \
--beta \
--input $cgaInput $Annotation_Gene \
--match chromosome:chrom \
--overlap begin,end:txStart,txEnd \
--always-dump \
--output-mode compact \
--select 'A.*,B.name2'
