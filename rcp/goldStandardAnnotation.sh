#!/bin/bash --login

begin=$(date +"%s")
TODAY=$(date)
HOST=$(hostname)
scriptsDir=/home/users/djambulingam/dhana/scripts/rcp
outdir=/home/users/djambulingam/dhana/isbsequencing/epilepsy/analysis

update()
{
echo "-----------------------------------------------------"
echo "Date: $TODAY  Host:$HOST"
echo "-----------------------------------------------------"
}

for family in $( ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy/sequence/ ); do

    sh ${scriptsDir}/rcp_goldStandardAnnotation.sh \
        ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes \
        > ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard

    echo "dgv"

    grep -vw 'Consistent' \
        ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard \
        > ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent

    echo "Inconsistent"

    grep -vw 'NA' \
        ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent \
        > ${outdir}/${family}/RCP/${family}.RCP.range_list.cgaJoin.namedOut.addNA.filterNA.rangeTruncate.consistency.genes.dgvGoldStandard.inconsistent.noNA

    echo "done"
done

termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(tput setaf 4) ➤ $(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds $(tput sgr 0)"
