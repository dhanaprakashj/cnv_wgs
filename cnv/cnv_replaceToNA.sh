#!/bin/bash --login

# This script takes the values from ${family}.range_list.cgaJoin.namedOut and replaces empty/missing values with NA

# Example command
# sh cnv_replaceToNA.sh \
#     ${family}.range_list.cgaJoin.namedOut \
#     ${family}.range_list.cgaJoin.namedOut.addNA


awk -F"\t" -v OFS="\t" '{
       for (i=1;i<=NF;i++) {
         if ($i == "") $i="NA"
       }
       print $0
 }' "$1" > "$2"
