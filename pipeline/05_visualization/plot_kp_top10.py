import pandas as pd
import matplotlib.pyplot as plt

# Load summary table
df = pd.read_csv("kraken2_output/kp_prevalence_summary.tsv", sep="\t")

# Keep only "Klebsiella pneumoniae" rows
df = df[df["Klebsiella_Match"].str.lower() == "klebsiella pneumoniae"]

# Convert percent column to float
df["%_Abundance"] = df["%_Abundance"].astype(float)

# Sort and get top 10
top10 = df.sort_values(by="%_Abundance", ascending=False).head(10)

# Plot
plt.figure(figsize=(10, 6))
plt.barh(top10["Sample"], top10["%_Abundance"], edgecolor="black")
plt.xlabel("% Abundance")
plt.title("Top 10 Samples by Klebsiella pneumoniae Abundance")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.savefig("kraken2_output/kp_top10_barplot.png")
plt.close()

