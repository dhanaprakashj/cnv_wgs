#!/bin/bash --login

# This script takes values from extracted ${family}.names files and adds it to the file joined using cnv_cgaJoin.py script.

# Example command
# sh cnv_addNames.sh \
#     ${family}.names \
#     ${family}.range_list.cgaJoin \
#     > ${family}.range_list.cgaJoin.namedOut

tr \\n \\t <"$1" | \
    sed -E 's|\t|.Ploidy&|g;s|(.*).$|1s/calledPloidy.*calledPloidy/\1/|' | \
    sed -f - "$2"
