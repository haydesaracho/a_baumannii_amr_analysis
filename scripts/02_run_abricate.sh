#!/bin/bash
# =============================================================================
# 02_run_abricate.sh
# Runs ABRicate on all A. baumannii genomes using 5 antibiotic resistance
# databases (minid=80, mincov=80)
# =============================================================================

set -euo pipefail

# --- Directories -------------------------------------------------------------
GENOMES_DIR="../data/raw/genomes"
RESULTS_DIR="../results"

# --- Databases and output directories ----------------------------------------
declare -A DB_DIRS=(
    ["card"]="CARD"
    ["resfinder"]="ResFinder"
    ["argannot"]="ARG-ANNOT"
    ["megares"]="MEGARES"
    ["ncbi"]="NCBIAMRFinderPlus"
)

# --- Run ABRicate ------------------------------------------------------------
for DB in "${!DB_DIRS[@]}"; do

    DIR="${DB_DIRS[$DB]}"

    echo "========================================="
    echo "Running ABRicate with database: $DB"
    echo "========================================="

    OUTPUT="$RESULTS_DIR/$DIR/${DB}_results.tsv"

    abricate \
        --db "$DB" \
        --minid 80 \
        --mincov 80 \
        --threads 8 \
        --quiet \
        "$GENOMES_DIR"/*.fna.gz \
        > "$OUTPUT"

    echo "    Hits found: $(tail -n +2 "$OUTPUT" | wc -l)"
    echo "    Saved to: $OUTPUT"
    echo ""

done

echo "ABRicate finished. Results saved to: $RESULTS_DIR"