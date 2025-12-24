
#!/bin/bash
# Run SPAdes assembly on all paired trimmed reads in 01_data_trimmed
# Using ~40% of node resources (6 threads, 50 GB RAM)

# Create output folder if not exists
mkdir -p 02_assembly

# Loop through all R1 reads
for R1 in 01_data_trimmed/*_R1_paired.fastq.gz; do
    # Define matching R2
    R2="${R1/_R1_/_R2_}"

    # Extract sample name (everything before _R1)
    sample=$(basename "$R1" | sed 's/_R1.*.fastq.gz//')

    # Define output directory
    outdir="02_assembly/${sample}"
    mkdir -p "$outdir"

    # Skip if assembly already exists
    if [ -f "${outdir}/contigs.fasta" ]; then
        echo "✅ Skipping $sample (assembly already exists)"
        continue
    fi

    echo "🧬 Running SPAdes for $sample ..."

    # Run SPAdes with nohup, 6 threads, 50 GB RAM
    nohup spades.py \
        -1 "$R1" -2 "$R2" \
        -o "$outdir" \
        -t 6 -m 50 \
        > "${outdir}/spades.log" 2>&1 &

    # Wait for this job to finish before moving to next sample
    wait
done

echo "🎉 All assemblies finished!"

