# Browser practical

Online materials for CNSD course

## Source data
* Source publication: Xiong, Cell, 2023; DOI: 10.1016/j.cell.2023.08.040
* Project website: https://compbio.mit.edu/ad_epigenome
* BigWig files (GRCh38): https://personal.broadinstitute.org/bjames/AD_snATAC/MFC/bigWig_TSS6/
```{bash}
curl -O https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.chrom.sizes
```

## Prep conda environment
```{bash}
conda config --add channels bioconda
conda create -n ucsc_tracks \
    ucsc-bedgraphtobigwig \
    ucsc-bigwigtobedgraph \
    ucsc-fetchchromsizes \
    ucsc-bedtobigbed \
    bedtools \
    coreutils \
    -y
```

## Filter bigWigs to genes of interest
```{bash}
conda activate ucsc_tracks
i=nonAD_Ex-TileSize-50-normMethod-nFrags-ArchR
bash bigWigFilter.sh $i.bw regions_50Kb_padding.GRCh38.bed hg38.chrom.sizes $i.flt.bw
```