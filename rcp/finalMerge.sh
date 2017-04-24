#!/bin/bash --login
#-*- coding: utf-8 -*-

scriptsDir=/home/users/djambulingam/dhana/scripts/rcp
pathDir=/home/users/djambulingam/dhana/isbsequencing/epilepsy/paths

for line in $( ls -1 /home/users/djambulingam/dhana/isbsequencing/epilepsy/sequence/ ); do
   sh ${scriptsDir}/mergeFullRCP.sh ${pathDir}/${line}.rcp.in ${pathDir}/${line}.rcp.unZip
done
