
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load cleaned results
df = pd.read_csv("03_kleborate_final/all_samples_results_clean.tsv", sep="\t")

# ================================
# 1. Species Distribution
# ================================
plt.figure(figsize=(8,6))
sns.countplot(y="species", data=df, order=df["species"].value_counts().index)
plt.title("Species Distribution")
plt.xlabel("Count")
plt.ylabel("Species")
plt.tight_layout()
plt.savefig("species_distribution.png", dpi=300)
plt.close()

# ================================
# 2. ST Distribution
# ================================
plt.figure(figsize=(10,6))
sns.countplot(y="ST", data=df, order=df["ST"].value_counts().index)
plt.title("Distribution of Klebsiella pneumoniae Sequence Types (ST)")
plt.xlabel("Count")
plt.ylabel("ST")
plt.tight_layout()
plt.savefig("ST_distribution.png", dpi=300)
plt.close()

# Pie chart
plt.figure(figsize=(8,8))
df["ST"].value_counts().plot.pie(autopct="%1.1f%%")
plt.title("ST Distribution (Proportion)")
plt.ylabel("")
plt.tight_layout()
plt.savefig("ST_piechart.png", dpi=300)
plt.close()

# ================================
# 3. Virulence vs Resistance Heatmap
# ================================
heatmap_data = df.groupby(["virulence_score","resistance_score"]).size().unstack(fill_value=0)
plt.figure(figsize=(8,6))
sns.heatmap(heatmap_data, annot=True, fmt="d", cmap="Blues")
plt.title("Virulence vs Resistance Score Distribution")
plt.xlabel("Resistance Score")
plt.ylabel("Virulence Score")
plt.tight_layout()
plt.savefig("virulence_resistance_heatmap.png", dpi=300)
plt.close()

# ================================
# 4. Summary Table
# ================================
summary = df[["sample","ST","species","virulence_score","resistance_score"]]
summary.to_csv("summary_table.csv", index=False)

print("✅ Analysis complete: plots + summary table saved.")

