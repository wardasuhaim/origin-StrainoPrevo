mkdir -p 03_kleborate_all

for asm in 02_assembly/*/contigs.fasta; do
    sample=$(basename $(dirname "$asm"))
    echo "🧬 Running Kleborate for $sample ..."
    mkdir -p 03_kleborate_all/$sample
    kleborate \
      -a "$asm" \
      -o 03_kleborate_all/$sample \
      -m general__contig_stats,klebsiella_pneumo_complex__mlst,klebsiella_pneumo_complex__amr,klebsiella_pneumo_complex__kaptive,klebsiella_pneumo_complex__wzi,klebsiella_pneumo_complex__virulence_score,klebsiella_pneumo_complex__resistance_score,klebsiella_pneumo_complex__cipro_prediction \
      -r
done

