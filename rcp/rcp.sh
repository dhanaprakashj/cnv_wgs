#!/bin/bash

#Input - run the script with sample.in file
#Example command
# sh rcp.sh sample.in


TODAY=$(date)
HOST=$(hostname)
echo "-----------------------------------------------------"
echo "Date: $TODAY  Host:$HOST"
echo "-----------------------------------------------------"

seqPath=$(echo $1 | cut -d "/" -f7,8,9)
out=$(echo $1 | cut -d "/" -f7,8,9 | cut -d "/" -f2)

## To create temporary directoring for storing results ##
mkdir tmp_$out


##  To compute the condensed coverage for the sample. Resulting file named as CGIASM.cov.gz and CGIASM.over.gz along with their tbi format ##
perl /home/users/djambulingam/dhana/coverage/bin/condenseCoverage.pl /work/projects/isbsequencing/epilepsy_lcsb/sequence/$seqPath/ASM/REF tmp_$out/CGIASM


## To compute summary statistics for the sample ##
perl /home/users/djambulingam/dhana/coverage/bin/totalCoverageByGC.pl tmp_$out/CGIASM /home/users/djambulingam/dhana/coverage/GCprofile.hg19.gz


## To Normalize the coverage to the RCP ##
perl /home/users/djambulingam/dhana/coverage/bin/normalizeCoverage.pl tmp_$out/CGIASM /home/users/djambulingam/dhana/coverage/RCPs/CGI-10.rcp.gz


## To Segment the coverage using a hidden Markov model ##
perl /home/users/djambulingam/dhana/coverage/bin/segmentCoverage.pl tmp_$out/CGIASM
