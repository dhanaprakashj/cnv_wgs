#!/bin/bash --login

# This script takes values from extracted ${family}.RCP.names files and adds it to the file joined using rcp_cgaJoin.py script.

# Example command
# sh rcp_addNames.sh \
#     ${family}.RCP.names \
#     ${family}.RCP.range_list.cgaJoin \
#     > ${family}.RCP.range_list.cgaJoin.namedOut

tr \\n \\t <"$1" | \
    sed -E 's|\t|.rcpState&|g;s|(.*).$|1s/state.*state/\1/|' | \
    sed -f - "$2"
