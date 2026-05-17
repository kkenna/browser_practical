
#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./filter_bigwig.sh input.bw regions.bed chrom.sizes output.bw
#
# Example:
#   ./filter_bigwig.sh full_track.bw regions.bed hg38.chrom.sizes filtered_track.bw

INPUT_BW="$1"
REGIONS_BED="$2"
CHROM_SIZES="$3"
OUTPUT_BW="$4"

TMP_BG="$(mktemp)"
TMP_SORTED="$(mktemp)"

cleanup() {
    rm -f "$TMP_BG" "$TMP_SORTED"
}
trap cleanup EXIT

echo "Extracting regions from $INPUT_BW..."

while read -r chrom start end rest
do
    # skip empty/comment lines
    [[ -z "${chrom:-}" || "$chrom" =~ ^# ]] && continue

    bigWigToBedGraph "$INPUT_BW" stdout \
        -chrom="$chrom" \
        -start="$start" \
        -end="$end" >> "$TMP_BG"

done < "$REGIONS_BED"

echo "Sorting bedGraph..."

sort -k1,1 -k2,2n "$TMP_BG" > "$TMP_SORTED"

echo "Converting back to bigWig..."

bedGraphToBigWig "$TMP_SORTED" "$CHROM_SIZES" "$OUTPUT_BW"

echo "Done: $OUTPUT_BW"