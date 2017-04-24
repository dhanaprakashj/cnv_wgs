#!/bin/bash --login
#-*- coding: utf-8 -*-

# To count the number of cnv segments
cat \
    /Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy/analysis/*/*.CGI.*.DGVFilter.tsv \
    /Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy_autosomal_recessive/analysis/*/*.CGI.*.DGVFilter.tsv \
    /Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/epilepsy_lcsb/analysis/*/*.CGI.*.DGVFilter.tsv \
    > /Users/jambulingam.dhanapra/Documents/GaiaFiles/dhana/isbsequencing/cgiGenes.txt
