#!/bin/bash
# =============================================================================
# 01_download_and_filter.sh
# Downloads the NCBI RefSeq assembly summary, filters complete genomes of
# Acinetobacter baumannii, cleans the table and downloads genomes (.fna)
# =============================================================================

set -euo pipefail  # stop script on errors

# --- Directories -------------------------------------------------------------
RAW_DIR="../data/raw"
PROCESSED_DIR="../data/processed"
GENOMES_DIR="../data/raw/genomes"

mkdir -p "$RAW_DIR" "$PROCESSED_DIR" "$GENOMES_DIR"

# --- 1. Download assembly summary --------------------------------------------
echo "[1/4] Downloading assembly_summary_refseq.txt..."
wget -P "$RAW_DIR" \
    https://ftp.ncbi.nlm.nih.gov/genomes/refseq/assembly_summary_refseq.txt

# --- 2. Filter A. baumannii Complete Genomes ---------------------------------
echo "[2/4] Filtering Acinetobacter baumannii Complete Genomes..."

# Clean header (line 2, removing leading #)
sed -n '2p' "$RAW_DIR/assembly_summary_refseq.txt" | \
    sed 's/^#//' > "$PROCESSED_DIR/Assembly_Summary_Ab_CG.tsv"

# Filtered rows
grep "Acinetobacter baumannii" "$RAW_DIR/assembly_summary_refseq.txt" | \
    grep "Complete Genome" >> "$PROCESSED_DIR/Assembly_Summary_Ab_CG.tsv"

echo "    Genomes found: $(wc -l < "$PROCESSED_DIR/Assembly_Summary_Ab_CG.tsv") (including header)"

# --- 3. Remove uninformative columns -----------------------------------------
echo "[3/4] Removing columns with a single unique value..."

python3 - <<'EOF'
import pandas as pd

input_file  = "../data/processed/Assembly_Summary_Ab_CG.tsv"
output_file = "../data/processed/Assembly_Summary_Ab_CG_clean.tsv"

df = pd.read_csv(input_file, sep="\t", low_memory=False)

# Keep columns with more than one unique value
cols_to_keep = [col for col in df.columns if df[col].nunique() > 1]
cols_removed = [col for col in df.columns if df[col].nunique() <= 1]

df[cols_to_keep].to_csv(output_file, sep="\t", index=False)

print(f"    Original columns : {len(df.columns)}")
print(f"    Removed columns  : {len(cols_removed)}")
print(f"    Removed columns  : {cols_removed}")
print(f"    Kept columns     : {len(cols_to_keep)}")
print(f"    Clean table saved to: {output_file}")
EOF

# --- 4. Extract links and download genomes -----------------------------------
echo "[4/4] Downloading .fna genomes..."

# Extract ftp_path (column 20) and build .fna URL
awk -F'\t' 'NR>1 && $20 != "na" {
    gsub(/\/$/, "", $20)
    n=split($20, a, "/")
    print $20 "/" a[n] "_genomic.fna.gz"
}' "$PROCESSED_DIR/Assembly_Summary_Ab_CG.tsv" > "$PROCESSED_DIR/ftp_links.txt"

echo "    Links generated: $(wc -l < "$PROCESSED_DIR/ftp_links.txt")"

# Download each genome
while read -r url; do
    filename=$(basename "$url")
    if [[ ! -f "$GENOMES_DIR/$filename" ]]; then
        wget -P "$GENOMES_DIR" "$url" && echo "    OK: $filename"
    else
        echo "    Already exists, skipping: $filename"
    fi
done < "$PROCESSED_DIR/ftp_links.txt"

echo ""
echo "Done. Genomes downloaded to: $GENOMES_DIR"