#!/bin/bash --login

begin=$(date +"%s")
TODAY=$(date)
HOST=$(hostname)
scriptsDir=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/scripts/rcp
unzippedFilesList="$2"

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

out_status()
{
    echo "$(tput setaf 2) ➤ "$1" "$2" $(tput sgr 0)"
}

rcpAnalysis()
{
    family=$(basename "$1" .rcp.in)
    outdir=/Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy/analysis/$family/RCP
    # mkdir -pv $outdir

    # inStatus " Merging RCP files: Creating a range file "
    # python ${scriptsDir}/rcp_listCNVDetails.py \
    #     "$1" \
    #     > ${outdir}/${family}.RCP.range_list
    # out_status " RCP Range file created: Output written to" "${outdir}/${family}.RCP.range_list"

    # inStatus " Unzipping CGIASM.seg.gz files "
    # sh ${scriptsDir}/rcp_filter.sh \
    #     "$1"
    # out_status " RCP CGIASM.seg.gz files unzipped to CGIASM.seg: Output written to " "respective RCP directories"

    # inStatus "Looping files to merge using Complete Genomics Analysis Tools"
    # python ${scriptsDir}/rcp_cgaJoin.py \
    #     $unzippedFilesList ${outdir}/${family}.RCP.range_list \
    #     ${outdir}/${family}.RCP.range_list.cgaJoin
    # out_status "All files Merged: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin"

    # inStatus "Extracting names from Infile"
    # sh ${scriptsDir}/rcp_cutNames.sh \
    #     "$1" \
    #     > ${outdir}/${family}.RCP.names
    # out_status "Names extracted and written to file" "${outdir}/${family}.RCP.names"

    # inStatus "Adding extracted names from Infile to ${outdir}/${family}.RCP.range_list.cgaJoin"
    # sh ${scriptsDir}/rcp_addNames.sh \
    #     ${outdir}/${family}.RCP.names \
    #     ${outdir}/${family}.RCP.range_list.cgaJoin \
    #     > ${outdir}/${family}.RCP.tmpfile && mv -f ${outdir}/${family}.RCP.tmpfile ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut
    # out_status "Names of respective columns added: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut"

    inStatus "Replacing missing values with NA"
    sh ${scriptsDir}/rcp_replaceToNA.sh \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA
    out_status "Missing values replaced with NA: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA"

    inStatus "Filtering rows with only NA's"
    sh ${scriptsDir}/rcp_removeFullNA.sh \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA \
        > ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA
    out_status "Rows with only NA's filtered: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA"

    inStatus "Truncating range values"
    python ${scriptsDir}/rcp_rangeTruncate.py \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate
    out_status "Range values truncated: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate"

    inStatus "Checking for consistency"
    python ${scriptsDir}/rcp_consistency.py \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency
    out_status "Range values truncated: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency"

    inStatus "Adding Gene names"
    sh ${scriptsDir}/rcp_annotation.sh \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency \
        | sed -e '1 s/name2/OverlappingGenes/' \
        > ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes
    out_status "Gene names added: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes"


    inStatus "Adding ID from dgvGoldStandard"
    sh ${scriptsDir}/rcp_goldStandardAnnotation.sh \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes \
        > ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard
    out_status "ID added: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard"

    inStatus "Filtering out inconsistent values"
    grep -vw 'Consistent' \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard \
        > ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent
    out_status "ID added: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent"


    inStatus "Filtering out Values with NA's"
    grep -vw 'NA' \
        ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent \
        > ${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA
    out_status "ID added: Output written to" "${outdir}/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA"
}

for file in "$1"
do
    update "Running CNV pipeline for $(basename $file .in)"
    rcpAnalysis $file
done

termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(tput setaf 4) Total runtime for the CNV analysis process:  ➤  $(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds $(tput sgr 0)"
