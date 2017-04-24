Introduction

This repository contains all the neccessary codes required to perform a copy number variation analysis from whole genome sequencing (WGS) data sequenced using Complete Genomics Inc.

Prerequisites

1. cgatools
2. Python 2.7
3. R (with ggplot2 package installed)
4. Haplopainter
5. PEDSTATS

3. Scripts directory

    1. CNV:
        1. cnv_listCNVDetails.py
        2. cnv_cgaJoin.py
        3. cnv_addNames.sh
        4. cnv_replaceToNA.sh
        5. cnv_removeFullNA.sh
        6. cnv_rangeTruncate.py
        7. cnv_consistency.py
        8. cnv_geneAnnotation.sh
        9. goldStandardAnnotation.sh
        10. cnv_cutNames.sh
        11. cnv_filter.sh
        12. mergeFullCNV.sh
        13. finalMerge.sh
        
    2. RCP:
        1. rcp_listCNVDetails.py
        2. rcp_filter.sh
        3. rcp_cgaJoin.py
        4. rcp_cutNames.sh
        5. rcp_addNames.sh
        6. rcp_replaceToNA.sh
        7. rcp_removeFullNA.sh
        8. rcp_rangeTruncate.py
        9. rcp_consistency.py
        10. rcp_annotation.sh
        11. rcp_goldStandardAnnotation.sh
        12. mergeFullRCP.sh
        13. finalMerge.sh
        14. rcp.sh
        
    3. count.sh
    4. ggplotR.sh
    5. paths.sh
    6. pathsRCP.sh
    7. offsprinOne.sh
    8. offspringTwo.sh
    9. offspringThree.sh

Implementation

The codes are sufficiently commented to make it easier for others to understand and implement it. Each code file contains a brief description of its function and an example usage to run it from command line. Users need to edit out the respective paths to their files in the script and run the mergeFullCNV.sh/mergeRCP.sh executable file, if they need to generate the candiate events list file for a single family. If they need to run the analysis for muliple families, they can run the finalMerge.sh executable file by changing the path to the location of the data. In the user specified path, the script will generate separate folders for each family and write files in to it. The necessary resources need to be allocated via the OAR resource manager by user depending on the size of the datasets used. 

After obtaining the candidate list of events, the offspring{One/Two/Three}.sh scripts can be used to seggregate the events as per their inheritance patterns. The mode of inheritance for each script can used by commenting or uncommenting specific blocks of codes in the script.

Note: If you wish to generate candidate event list from RCP data, it is necessary to first use the rcp.sh script to perform RCP analysis and then proceed with generating the pipeline.