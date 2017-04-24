#!/bin/bash --login
#-*- coding: utf-8 -*-

family=$1
father=$2
mother=$3
offspring1=$4
echo "Father -- $father"
echo "Mother -- $mother"
echo "Child1 -- $offspring1"
DGVFile=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy/analysis/${family}/CNV/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA
RCPFile=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy/analysis/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA
outdir=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy/analysis/${family}


## denova CNVs test ##
awk 'BEGIN {FS="\t"} $'${father}'==2 && $'${mother}'==2 && $'${offspring1}'!=2 {print}' ${DGVFile} \
    > ${outdir}/${family}.denovo.tsv
awk 'BEGIN {FS="\t"} $'${father}'==2 && $'${mother}'==2 && $'${offspring1}'!=2 && $NF=="" {print}' ${DGVFile} \
    > ${outdir}/${family}.denovo.DGVFilter.tsv

awk 'BEGIN {FS="\t"} $'${father}'==2 && $'${mother}'==2 && $'${offspring1}'!=2 {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.denovo.tsv
awk 'BEGIN {FS="\t"} $'${father}'==2 && $'${mother}'==2 && $'${offspring1}'!=2 && $NF=="" {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.denovo.DGVFilter.tsv

## autosomal recessive test ##

awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'>2 && $'${offspring1}'>2 && $1!="chrX") || ($'${father}'<2 && $'${mother}'<2 && $'${offspring1}'<2 && $1!="chrX") {print}' ${DGVFile} \
    > ${outdir}/${family}.autosomalRecessive.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1!="chrX") || ($'${father}'<2 && $'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1!="chrX") {print}' ${DGVFile} \
    > ${outdir}/${family}.autosomalRecessive.DGVFilter.tsv

awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'>2 && $'${offspring1}'>2 && $1!="chrX") || ($'${father}'<2 && $'${mother}'<2 && $'${offspring1}'<2 && $1!="chrX") {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.autosomalRecessive.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1!="chrX") || ($'${father}'<2 && $'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1!="chrX") {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.autosomalRecessive.DGVFilter.tsv

## compound heterozygous events ##

awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'<2 && $'${offspring1}'!=2 ) || ($'${father}'<2 && $'${mother}'>2 && $'${offspring1}'!=2 ) {print}' ${DGVFile} \
    > ${outdir}/${family}.compoundEvents.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'<2 && $'${offspring1}'!=2 && $NF=="") || ($'${father}'<2 && $'${mother}'>2 && $'${offspring1}'!=2 && $NF=="") {print}' ${DGVFile} \
    > ${outdir}/${family}.compoundEvents.DGVFilter.tsv

awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'<2 && $'${offspring1}'!=2 ) || ($'${father}'<2 && $'${mother}'>2 && $'${offspring1}'!=2 ) {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.compoundEvents.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${mother}'<2 && $'${offspring1}'!=2 && $NF=="") || ($'${father}'<2 && $'${mother}'>2 && $'${offspring1}'!=2 && $NF=="") {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.compoundEvents.DGVFilter.tsv


# ## X-linked CNVs test ##

# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${DGVFile} \
#     > ${outdir}/${family}.xlinked.tsv
# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${DGVFile} \
#     > ${outdir}/${family}.xlinked.DGVFilter.tsv

# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${RCPFile} \
#     > ${outdir}/${family}.RCP.xlinked.tsv
# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${RCPFile} \
#     > ${outdir}/${family}.RCP.xlinked.DGVFilter.tsv


## X-linked CNVs test ##
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${father}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${DGVFile} \
    > ${outdir}/${family}.xlinked.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${father}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${DGVFile} \
    > ${outdir}/${family}.xlinked.DGVFilter.tsv

awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${father}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.xlinked.tsv
awk 'BEGIN {FS="\t"} ($'${father}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${father}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${RCPFile} \
    > ${outdir}/${family}.RCP.xlinked.DGVFilter.tsv


# ## X-linked CNVs test ##

# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${DGVFile} \
#     > ${outdir}/${family}.xlinked.tsv
# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${DGVFile} \
#     > ${outdir}/${family}.xlinked.DGVFilter.tsv

# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $1=="chrX") {print}' ${RCPFile} \
#     > ${outdir}/${family}.RCP.xlinked.tsv
# awk 'BEGIN {FS="\t"} ($'${mother}'>2 && $'${offspring1}'>2 && $NF=="" && $1=="chrX") || ($'${mother}'<2 && $'${offspring1}'<2 && $NF=="" && $1=="chrX") {print}' ${RCPFile} \
#     > ${outdir}/${family}.RCP.xlinked.DGVFilter.tsv
