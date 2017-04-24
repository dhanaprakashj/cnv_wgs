#!/bin/bash --login

begin=$(date +"%s")
TODAY=$(date)
HOST=$(hostname)
scriptsDir=/home/users/djambulingam/dhana/scripts/cnv
individualNames="$2"

update()
{
echo "-----------------------------------------------------"
echo "Date: $TODAY  Host:$HOST"
echo "$1"
echo "-----------------------------------------------------"
}

inStatus()
{
    echo "$(tput setaf 1) ➤ "$1" $(tput sgr 0)"
}

outStatus()
{
    echo "$(tput setaf 2) ➤ "$1" "$2" $(tput sgr 0)"
}

cnvAnalysis()
{
    family=$(basename "$1" .in)
    # outdir=/home/users/djambulingam/dhana/isbsequencing/epilepsy_autosomal_recessive/analysis/$family/CNV
    outdir=/home/users/djambulingam/dhana/isbsequencing/epilepsy_autosomal_recessive/analysis/CNV
    mkdir -pv $outdir

    inStatus " Merging files: Creating a range file "
    python ${scriptsDir}/cnv_listCNVDetails.py \
        "$1" \
        > ${outdir}/${family}.range_list
    outStatus " Range file created: Output written to" "${outdir}/${family}.range_list"

    inStatus "Looping files to merge using Complete Genomics Analysis Tools"
    python ${scriptsDir}/cnv_cgaJoin.py \
        "$1" \
        ${outdir}/${family}.range_list ${outdir}/${family}.range_list.cgaJoin
    outStatus "All files Merged: Output written to" "${outdir}/${family}.range_list.cgaJoin"

    ## Use the below two blocks if you want to extract names from the pathfile and append to columns ##
    # inStatus "Extracting names from Infile"
    # sh ${scriptsDir}/cnv_cutNames.sh "$1" ${outdir}/${family}.names
    # outStatus "Names extracted and written to file" "${outdir}/${family}.names"

    # inStatus "Adding extracted names from Infile to ${outdir}/${family}.range_list.cgaJoin"
    # sh ${scriptsDir}/cnv_addNames.sh \
        # ${outdir}/${family}.names \
        # ${outdir}/${family}.range_list.cgaJoin \
        # > ${outdir}/${family}.tmpfile \
        # && mv -f ${outdir}/${family}.tmpfile ${outdir}/${family}.range_list.cgaJoin.namedOut
    # outStatus "Names of respective columns added: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut"


    inStatus "Adding  names from Infile to ${outdir}/${family}.range_list.cgaJoin"
    sh ${scriptsDir}/cnv_addNames.sh \
        $individualNames \
        ${outdir}/${family}.range_list.cgaJoin \
        > ${outdir}/${family}.tmpfile && mv -f ${outdir}/${family}.tmpfile ${outdir}/${family}.range_list.cgaJoin.namedOut
    outStatus "Names of respective columns added: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut"

    inStatus "Replacing missing values with NA"
    sh ${scriptsDir}/cnv_replaceToNA.sh \
        ${outdir}/${family}.range_list.cgaJoin.namedOut \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA
    outStatus "Missing values replaced with NA: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA"

    inStatus "Filtering rows with only NA's"
    sh ${scriptsDir}/cnv_removeFullNA.sh \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA \
        > ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA
    outStatus "Rows with only NA's filtered: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA"

    inStatus "Truncating range values"
    python ${scriptsDir}/cnv_rangeTruncate.py \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate
    outStatus "Range values truncated: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate"

    inStatus "Checking for consistency"
    python ${scriptsDir}/cnv_consistency.py \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency
    outStatus "Range values truncated: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency"

    inStatus "Adding Gene names"
    sh ${scriptsDir}/cnv_geneAnnotation.sh \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency | sed -e '1 s/name2/OverlappingGenes/' \
        > ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes
    outStatus "Gene names added: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes"

    inStatus "Adding ID from dgvGoldStandard"
    sh ${scriptsDir}/goldStandardAnnotation.sh \
        ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes \
        > ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard
    outStatus "ID added: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard"

    inStatus "Filtering out inconsistent values"
    grep -vw 'Consistent' ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard \
        > ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent
    outStatus "Inconsistent values filtered out: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent"

    inStatus "Filtering out Values with NA's"
    grep -vw 'NA' ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent \
        > ${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA
    outStatus "regions with NA values filtered out: Output written to" "${outdir}/${family}.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA"
}

for file in "$1"
do
    update "Running CNV pipeline for $(basename $file .in)"
    cnvAnalysis $file
done

termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(tput setaf 4) Total runtime for the CNV analysis process:  ➤  $(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds $(tput sgr 0)"
