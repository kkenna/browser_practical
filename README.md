# Browser practical

Online mterials for CNSD course

## Source data
* Source publication: Xiong, Cell, 2023; DOI: 10.1016/j.cell.2023.08.040
* Project website: https://compbio.mit.edu/ad_epigenome
* BigWig files (GRCh38): https://personal.broadinstitute.org/bjames/AD_snATAC/MFC/bigWig_TSS6/

## Prep conda environment
conda config --add channels bioconda
conda create -n ucsc_tracks \
    ucsc-bedgraphtobigwig \
    ucsc-bigwigtobedgraph \
    ucsc-fetchchromsizes \
    ucsc-bedtobigbed \
    bedtools \
    coreutils \
    -y