#!/bin/bash --login

# This script reads the file ${family}.range_list.cgaJoin.namedOut.addNA and removes the rows which contains just NA (blank/uninformative rows) throught the entire record

# Example command
# sh cnv_removeFullNA.sh \
#     ${family}.range_list.cgaJoin.namedOut.addNA \
#     > ${family}.range_list.cgaJoin.namedOut.addNA.filterNA

awk '{
    val="NA"
    for (i=4; i<=NF; i++)
        if (val != $i) {
            print
            break
        }
}' < "$1"
