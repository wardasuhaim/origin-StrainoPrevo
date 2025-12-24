#!/bin/bash
# Kleborate batch script for all assemblies (fixed version)

set -euo pipefail

# Input and output directories
ASM_DIR="02_assembly"
OUT_BASE="03_kleborate_final"
mkdir -p "$OUT_BASE"

# Loop over all assemblies
for ASM in ${ASM_DIR}/*/contigs.fasta; do
    SAMPLE=$(basename $(dirname "$ASM"))
    OUTDIR="${OUT_BASE}/${SAMPLE}"

    echo "🧬 Running Kleborate for $SAMPLE ..."
    mkdir -p "$OUTDIR"

    # Run Kleborate and redirect results into results.tsv
    kleborate \
      -a "$ASM" \
      -o "$OUTDIR" \
      -m general__contig_stats,klebsiella_pneumo_complex__mlst,klebsiella_pneumo_complex__amr,klebsiella_pneumo_complex__kaptive,klebsiella_pneumo_complex__wzi,klebsiella_pneumo_complex__virulence_score,klebsiella_pneumo_complex__resistance_score,klebsiella_pneumo_complex__cipro_prediction \
      -r > "$OUTDIR/results.tsv" \
      || echo "⚠️ Failed for $SAMPLE"
done

# Merge results
echo "📊 Combining all results..."
find "$OUT_BASE" -type f -name "results.tsv" -exec cat {} + > "$OUT_BASE/all_samples_results.tsv"
echo "✅ Done! Results saved in $OUT_BASE/all_samples_results.tsv"

