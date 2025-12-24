#!/bin/bash

# Set adapter path
ADAPTERS=$(find $CONDA_PREFIX/share -name TruSeq3-PE.fa | head -n 1)

# Create output folder
mkdir -p trim_output

# Loop through all R1 files
for R1 in blood_samples/*_R1_*.fastq.gz; do
    # Derive R2 file by replacing R1 with R2 in the filename
    R2=${R1/_R1_/_R2_}

    # Check if R2 file exists
    if [[ ! -f "$R2" ]]; then
        echo "Missing R2 for $R1 — skipping"
        continue
    fi

    # Get the base name without path and extension
    sample_name=$(basename "$R1" | sed 's/_R1_.*.fastq.gz//')

    # Set output filenames
    out_p1="trim_output/${sample_name}_R1_paired.fastq.gz"
    out_u1="trim_output/${sample_name}_R1_unpaired.fastq.gz"
    out_p2="trim_output/${sample_name}_R2_paired.fastq.gz"
    out_u2="trim_output/${sample_name}_R2_unpaired.fastq.gz"

    echo "🔧 Processing $sample_name..."

    # Run Trimmomatic
    trimmomatic PE -threads 4 -phred33 \
        "$R1" "$R2" \
        "$out_p1" "$out_u1" \
        "$out_p2" "$out_u2" \
        ILLUMINACLIP:"$ADAPTERS":2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done

