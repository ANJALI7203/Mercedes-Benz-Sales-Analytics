# Mercedes-Benz Sales Analytics

End-to-end **Business Intelligence** project taking Mercedes-Benz sales data from raw CSV to executive dashboard using **Python, SQLite, Microsoft SQL Server (SSMS), SQL, and Power BI**.

![Status](https://img.shields.io/badge/status-complete-brightgreen)
![Python](https://img.shields.io/badge/python-pandas-blue)
![SQLite](https://img.shields.io/badge/database-SQLite-lightgrey)
![SQL Server](https://img.shields.io/badge/database-SQL%20Server-red)
![Power BI](https://img.shields.io/badge/dashboard-Power%20BI-yellow)

---

## 📊 Overview

This project analyzes Mercedes-Benz sales data across models, regions, and time (2023–2025) through a complete BI workflow: raw data is cleaned and feature-engineered in **Python**, normalized into **SQLite**, migrated into **Microsoft SQL Server via SSMS** for analysis with 50+ SQL queries, and visualized in a 7-page interactive **Power BI** dashboard.

The goal is to demonstrate a full, reproducible analytics pipeline — not just a dashboard.

```text
Raw CSV ──▶ Python ETL ──▶ SQLite ──▶ CSV Export ──▶ SQL Server (SSMS) ──▶ SQL Analysis ──▶ Power BI
```

---

## 🎬 Demo

https://github.com/user-attachments/assets/be0abd99-b46f-44f3-8e58-9cf0aeb0e57f

| Cover Page | Executive Overview |
|------------|--------------------|
| ![](images/Home_Page.png) | ![](images/Executive_Overview.png) |

| Model Performance | Regional Insights |
|-------------------|------------------|
| ![](images/Model_Performance.png) | ![](images/Regional_Insights.png) |

| Profitability Analysis | Sales Performance (Time Trends) |
|------------------------|------------------|
| ![](images/Profitability_Analysis.png) | ![](images/Sales_Performance.png) |

| Strategic Insights (Model × Region Cross-Analysis) |
|--------------------|
| ![](images/Strategic_Insights.png) |

---

## 📈 Key Insights

- **GLC** generated the highest revenue across all models
- **North** region contributed the highest overall revenue
- Profit margin held **above 28%** across the full dataset
- Revenue trended upward consistently across the 3-year period
- Revenue peaked in **October 2024**
- Model × Region analysis revealed clear regional buying preferences

---

## 📁 Project Structure

```text
Mercedes-Benz-Sales-Analytics/
│
├── images/                          # Dashboard screenshots
├── videos/                          # Demo video
│
├── data/
│   ├── raw/                         # Mercedes_Sales_Data.csv / .xlsx
│   └── cleaned/                     # mercedes_cleaned.csv, mercedes.db,
│                                     # Sales.csv, Models.csv, Regions.csv
│
├── scripts/
│   ├── etl_pipeline.py              # Load → validate → clean → engineer → export
│   └── export_sqlite_tables.py      # Export SQLite tables to CSV
│
├── sql/
│   └── analysis_queries.sql         # 50+ business SQL queries
│
├── powerbi/
│   └── Mercedes_Sales_Dashboard.pbix
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

## 🔧 ETL Pipeline (`scripts/etl_pipeline.py`)

| Stage | What happens |
|---|---|
| **Load** | Read raw CSV, validate schema |
| **Validate** | Check missing values, duplicate Record_IDs, invalid profit/units, Z-score price outliers |
| **Clean** | Remove duplicates, fill missing `Region` with `"Unknown"`, flag (not delete) outliers and loss-making records |
| **Feature Engineer** | `Profit_Margin_Pct`, `Price_Tier`, `Unit_Tier` |
| **Export** | `mercedes_cleaned.csv` + normalized SQLite database (`mercedes.db`) |

**Database schema** (star-schema style):
- **Sales** (fact) — Revenue, Profit, Units Sold, Date, Model_ID, Region_ID, Profit Margin, Price Tier, Unit Tier
- **Models** (dimension) — Model_ID, Model
- **Regions** (dimension) — Region_ID, Region

---

## 🗄 Data Migration: SQLite → SQL Server

To demonstrate cross-platform interoperability, the normalized SQLite tables are exported to CSV and imported into **Microsoft SQL Server via SSMS** for the SQL analysis phase — mirroring a real-world workflow where data lands in an enterprise database before reporting.

```text
SQLite → export Sales/Models/Regions.csv → SQL Server (SSMS) → SQL Analysis
```

---

## 📝 SQL Analysis (`sql/analysis_queries.sql`)

**50+ queries** across 12 sections: database exploration, join validation, sales KPIs, model performance, regional analysis, model × region cross-analysis, time-series trends, price/unit tier analysis, data quality flags, advanced rankings & contributions, a reusable SQL view, and final validation against Python/Power BI outputs.

Demonstrates joins, `GROUP BY`/`HAVING`, `CASE`, CTEs, views, subqueries, and window functions (`DENSE_RANK()`, `LAG()`).

---

## 📊 Power BI Dashboard

7-page interactive report with an executive Mercedes-Benz theme:

| Page | Covers |
|---|---|
| **Cover Page** | Branding, navigation |
| **Executive Overview** | Total Revenue, Profit, Units Sold, Margin, Revenue Trend, Revenue by Region |
| **Model Performance** | Revenue/profit/units by model, rankings |
| **Regional Insights** | Revenue/profit/units by region, market contribution |
| **Profitability Analysis** | Margin, Revenue-to-Profit ratio, profit contribution |
| **Sales Performance** | Monthly/quarterly trends, YoY & MoM growth |
| **Strategic Insights** | Model × Region heatmap, top combinations, regional preferences |

**Interactive features:** bookmark-driven filter panel (Model, Region, Date, Year) with Apply/Reset; consistent region color-coding across all charts; dynamic DAX measures; "Unknown" region retained in tables for auditability but excluded from charts/KPIs.

---

## 🛠 Tech Stack

| Technology | Purpose |
|------------|----------|
| Python (pandas) | ETL, cleaning, feature engineering |
| SQLite | Intermediate relational database |
| Microsoft SQL Server + SSMS | Business data storage & SQL development |
| SQL | Business analysis (joins, window functions, views) |
| Power BI + DAX | Dashboard & KPI calculations |
| Git / GitHub | Version control, hosting |

---

## 🚀 How to Run

```bash
# 1. Clone
git clone https://github.com/ANJALI7203/Mercedes-Benz-Sales-Analytics.git
cd Mercedes-Benz-Sales-Analytics

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run ETL
python scripts/etl_pipeline.py
# → produces mercedes_cleaned.csv and mercedes.db

# 4. Export SQLite tables to CSV
python scripts/export_sqlite_tables.py
# → produces Sales.csv, Models.csv, Regions.csv

# 5. Import into SQL Server via SSMS, then run:
#    sql/analysis_queries.sql

# 6. Open the dashboard
#    powerbi/Mercedes_Sales_Dashboard.pbix
#    (refresh data source if paths have moved)
```

---

## 📊 Project Stats

| Metric | Value |
|---|---|
| Dataset period | 2023 – 2025 |
| Dashboard pages | 7 |
| SQL queries | 50+ |
| Database tables | 3 |
| DAX measures | 25+ |
| Database platforms | SQLite + SQL Server |

---

## 📌 Data Notes

- Data is synthetic, for educational/portfolio purposes
- Duplicate records removed; missing `Price`/`Units_Sold` dropped; missing `Region` filled as `"Unknown"`
- Price outliers and loss-making transactions were **flagged, not deleted** — preserved for impact analysis
- `"Unknown"` region is retained in tables/SQL for auditability, but excluded from dashboard charts and KPIs to keep visuals focused on primary segments

---

## 📬 Contact

**Anjali Singh**
- GitHub: [github.com/ANJALI7203](https://github.com/ANJALI7203)
- LinkedIn: *(add your LinkedIn profile here)*

---

## 📄 License

Synthetic/sample data, for educational and portfolio purposes only. Not affiliated with, sponsored by, or endorsed by Mercedes-Benz AG.

---

⭐ If you found this project useful, consider starring the repo!
