#!/bin/bash --login

# This script reads the input file line by line and cuts the path of the file to extract the sample name.
# The extracted names are stored in $family.names file.

# Example command
# sh rcp_cutNames.sh
#   ${family}.rcp.in

cut -d"/" -f11 "$1" | cut -d"_" -f2,3
