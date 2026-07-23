import pandas as pd


# ============================================================
# STEP 1: LOAD DATA
# ============================================================

# Load the raw Mercedes sales dataset
df = pd.read_csv("../data/raw/Mercedes_Sales_Data.csv")

print("=" * 60)
print("DATA LOADING")
print("=" * 60)
print("Data loaded successfully.")
print(f"Dataset shape: {df.shape}")
print("\nFirst 5 rows:")
print(df.head())


# ============================================================
# STEP 2: DATA VALIDATION (BEFORE CLEANING)
# ============================================================

print("\n" + "=" * 60)
print("DATA VALIDATION")
print("=" * 60)


# ------------------------------------------------------------
# 2.1 Check Missing Values
# ------------------------------------------------------------

print("\nMissing values in each column:")
null_counts = df.isnull().sum()
print(null_counts)


# ------------------------------------------------------------
# 2.2 Check Duplicate Record IDs
# ------------------------------------------------------------

duplicate_count = df.duplicated(subset=["Record_ID"]).sum()
print(f"\nDuplicate Record_IDs found: {duplicate_count}")


# ------------------------------------------------------------
# 2.3 Check Negative or Zero Profit
# ------------------------------------------------------------

negative_zero_profit_count = (df["Profit"] <= 0).sum()
print(f"Negative or zero Profit records: {negative_zero_profit_count}")


# ------------------------------------------------------------
# 2.4 Check Negative or Zero Units Sold
# ------------------------------------------------------------

negative_zero_units_sold = (df["Units_Sold"] <= 0).sum()
print(f"Negative or zero Units_Sold records: {negative_zero_units_sold}")


# ------------------------------------------------------------
# 2.5 Detect Price Outliers Per Model Using Z-Score
# ------------------------------------------------------------

model_mean = df.groupby("Model")["Price"].transform("mean")
model_std = df.groupby("Model")["Price"].transform("std")

df["Price_Zscore"] = (df["Price"] - model_mean) / model_std

outlier_count = (df["Price_Zscore"].abs() > 2).sum()

print(
    f"Outlier prices flagged "
    f"(per-model Z-score > 2): {outlier_count}"
)


# ============================================================
# STEP 3: DATA CLEANING
# ============================================================

print("\n" + "=" * 60)
print("DATA CLEANING")
print("=" * 60)


# ------------------------------------------------------------
# 3.1 Remove Duplicate Record IDs
# Keep the first occurrence of each duplicate
# ------------------------------------------------------------

before = len(df)

df = df.drop_duplicates(
    subset="Record_ID",
    keep="first"
)

print(
    f"Duplicate Record_IDs removed: "
    f"{before - len(df)}"
)


# ------------------------------------------------------------
# 3.2 Handle Missing Price and Units Sold
# Rows with missing Price or Units_Sold are removed because
# these fields are required for sales and financial analysis.
# ------------------------------------------------------------

before = len(df)

df = df.dropna(
    subset=["Price", "Units_Sold"]
)

print(
    f"Rows removed due to missing Price or Units_Sold: "
    f"{before - len(df)}"
)


# ------------------------------------------------------------
# 3.3 Handle Missing Region Values
# Region is categorical and does not affect financial
# calculations, so missing values are retained as "Unknown".
# ------------------------------------------------------------

df["Region"] = df["Region"].fillna("Unknown")

print("Missing Region values filled with 'Unknown'.")


# ------------------------------------------------------------
# 3.4 Flag Price Outliers
# Outliers are retained in the dataset instead of being removed.
# ------------------------------------------------------------

df["Is_Outlier"] = df["Price_Zscore"].abs() > 2

print(
    f"Price outliers flagged and retained: "
    f"{df['Is_Outlier'].sum()}"
)


# ------------------------------------------------------------
# 3.5 Flag Loss-Making and Zero-Unit Records
# These records are retained for further analysis.
# ------------------------------------------------------------

df["Is_Loss"] = df["Profit"] <= 0
df["Is_Zero_Units"] = df["Units_Sold"] <= 0

print(
    f"Loss-making records flagged: "
    f"{df['Is_Loss'].sum()}"
)

print(
    f"Zero-unit records flagged: "
    f"{df['Is_Zero_Units'].sum()}"
)


# ============================================================
# FINAL CLEANED DATASET SUMMARY
# ============================================================

print("\n" + "=" * 60)
print("CLEANING COMPLETED")
print("=" * 60)

print(f"Final cleaned dataset shape: {df.shape}")


# ============================================================
# STEP 4: FEATURE ENGINEERING
# ============================================================

print("\n" + "=" * 60)
print("FEATURE ENGINEERING")
print("=" * 60)


# ------------------------------------------------------------
# 4.1 Calculate Profit Margin Percentage
# ------------------------------------------------------------

df["Profit_Margin_Pct"] = df["Profit"] / df["Revenue"]


# ------------------------------------------------------------
# 4.2 Create Price Tiers
# ------------------------------------------------------------

price_bins = [0, 45000, 60000, 80000, 110000, 145000, float("inf")]

price_labels = [
    "30K-45K",
    "45K-60K",
    "60K-80K",
    "80K-110K",
    "110K-145K",
    "145K+"
]

df["Price_Tier"] = pd.cut(
    df["Price"],
    bins=price_bins,
    labels=price_labels
)


# ------------------------------------------------------------
# 4.3 Create Units Sold Tiers
# ------------------------------------------------------------

unit_bins = [-1, 4, 8, 12, 16, float("inf")]

unit_labels = [
    "0-4",
    "4-8",
    "8-12",
    "12-16",
    "16+"
]

df["Unit_Tier"] = pd.cut(
    df["Units_Sold"],
    bins=unit_bins,
    labels=unit_labels
)


# ------------------------------------------------------------
# 4.4 Verify Engineered Features
# ------------------------------------------------------------

print("\nFeature engineering completed successfully.")

print(
    df[
        [
            "Price",
            "Price_Tier",
            "Units_Sold",
            "Unit_Tier",
            "Profit_Margin_Pct"
        ]
    ].head(10)
)


# ============================================================
# STEP 5: EXPORT
# ============================================================

print("\n" + "=" * 60)
print("DATA EXPORT")
print("=" * 60)


# ------------------------------------------------------------
# 5.1 Build Models Dimension Table
# ------------------------------------------------------------

models_df = df[["Model"]].drop_duplicates().reset_index(drop=True)
models_df["Model_ID"] = models_df.index + 1


# ------------------------------------------------------------
# 5.2 Build Regions Dimension Table
# ------------------------------------------------------------

regions_df = df[["Region"]].drop_duplicates().reset_index(drop=True)
regions_df["Region_ID"] = regions_df.index + 1


# ------------------------------------------------------------
# 5.3 Build Sales Fact Table
# Replace Model and Region text values with their corresponding IDs
# ------------------------------------------------------------

sales_df = df.merge(
    models_df,
    on="Model"
).merge(
    regions_df,
    on="Region"
)

sales_df = sales_df.drop(
    columns=["Model", "Region"]
)


# ------------------------------------------------------------
# 5.4 Export Cleaned Flat CSV
# Model and Region remain as text for direct analysis in Power BI
# ------------------------------------------------------------

df.to_csv(
    "../data/cleaned/mercedes_cleaned.csv",
    index=False
)


# ------------------------------------------------------------
# 5.5 Export Relational Tables to SQLite Database
# ------------------------------------------------------------

import sqlite3

conn = sqlite3.connect(
    "../data/cleaned/mercedes.db"
)

models_df.to_sql(
    "Models",
    conn,
    if_exists="replace",
    index=False
)

regions_df.to_sql(
    "Regions",
    conn,
    if_exists="replace",
    index=False
)

sales_df.to_sql(
    "Sales",
    conn,
    if_exists="replace",
    index=False
)

conn.close()


# ------------------------------------------------------------
# 5.6 Export Summary
# ------------------------------------------------------------

print(
    f"Exported cleaned flat file: "
    f"mercedes_cleaned.csv ({df.shape[0]} rows)"
)

print("Exported SQLite database: mercedes.db")

print(
    f"  Models table: {models_df.shape[0]} rows"
)

print(
    f"  Regions table: {regions_df.shape[0]} rows"
)

print(
    f"  Sales table: {sales_df.shape[0]} rows"
)