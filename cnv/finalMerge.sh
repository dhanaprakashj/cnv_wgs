#!/bin/bash --login
#-*- coding: utf-8 -*-

scriptsDir=/home/users/djambulingam/dhana/scripts/cnv
pathDir=/home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/paths

for line in $( ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy_lcsb/sequence/ ); do
   sh ${scriptsDir}/mergeFullCNV.sh ${pathDir}/${line}.in ${pathDir}/${line}.names
done
