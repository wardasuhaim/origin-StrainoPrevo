import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load data
df = pd.read_csv("03_kleborate_final/all_samples_results_clean.tsv", sep="\t")

# Quick check
print(df.head())
print(df['ST'].value_counts())

# Example 1: Bar plot of ST distribution
plt.figure(figsize=(10,6))
sns.countplot(y="ST", data=df, order=df['ST'].value_counts().index)
plt.title("Distribution of Klebsiella pneumoniae Sequence Types (ST)")
plt.xlabel("Count")
plt.ylabel("ST")
plt.tight_layout()
plt.savefig("ST_distribution.png", dpi=300)  # Save instead of show

# Example 2: Pie chart of ST proportions
plt.figure(figsize=(8,8))
df['ST'].value_counts().plot.pie(autopct='%1.1f%%', startangle=90, counterclock=False)
plt.title("Proportion of Sequence Types (ST)")
plt.ylabel("")
plt.tight_layout()
plt.savefig("ST_piechart.png", dpi=300)

