# Mercedes-Benz Sales Analytics

End-to-end **Business Intelligence** project demonstrating a complete analytics workflow from raw sales data to executive dashboards using **Python, SQLite, Microsoft SQL Server (SSMS), SQL, and Power BI**.

![Status](https://img.shields.io/badge/status-complete-brightgreen)
![Python](https://img.shields.io/badge/python-pandas-blue)
![SQLite](https://img.shields.io/badge/database-SQLite-lightgrey)
![SQL Server](https://img.shields.io/badge/database-SQL%20Server-red)
![Power BI](https://img.shields.io/badge/dashboard-Power%20BI-yellow)

---

# 📊 Overview

This project analyzes Mercedes-Benz sales data across models, regions, and time (2023–2025) through a complete Business Intelligence workflow.

Raw sales data is cleaned and feature-engineered using **Python**, normalized into a **SQLite** database, exported as flat CSV files, imported into **Microsoft SQL Server using SQL Server Management Studio (SSMS)** for SQL analysis, and finally visualized through an interactive **7-page Power BI dashboard**.

The objective is to demonstrate a complete analytics workflow—from raw data preparation to business insights and executive reporting—rather than focusing solely on visualization.

---

# ✨ Project Highlights

- End-to-End Business Intelligence Project
- Python ETL Pipeline
- Data Validation & Cleaning
- Feature Engineering
- SQLite Database Design
- CSV Export & SQL Server Import
- SQL Analysis using SSMS
- 50+ Business SQL Queries
- Window Functions (`LAG`, `DENSE_RANK`)
- 7-Page Interactive Power BI Dashboard
- Executive Mercedes-Benz Theme
- Interactive Filter Panel with Bookmarks
- Dynamic DAX Measures
- Executive KPI Reporting

---

# 🏗 Analytics Workflow

```text
                    Raw CSV Dataset
                           │
                           ▼
                Python ETL Pipeline
        (Validation • Cleaning • Feature Engineering)
                           │
                           ▼
                  SQLite Database
                           │
                           ▼
                  Export CSV Files
                           │
                           ▼
     Microsoft SQL Server (SSMS Import)
                           │
                           ▼
                 SQL Business Analysis
                           │
                           ▼
               Power BI Dashboard
```

---

# 🎬 Dashboard Demo

https://github.com/user-attachments/assets/be0abd99-b46f-44f3-8e58-9cf0aeb0e57f

---

# 📸 Dashboard Preview

| Cover Page | Executive Overview |
|------------|--------------------|
| ![](images/Cover_Page.png) | ![](images/Executive_Overview.png) |

| Model Performance | Regional Insights |
|-------------------|------------------|
| ![](images/Model_Performance.png) | ![](images/Regional_Insights.png) |

| Profitability Analysis | Sales Performance |
|------------------------|------------------|
| ![](images/Profitability_Analysis.png) | ![](images/Sales_Performance.png) |

| Strategic Insights |
|--------------------|
| ![](images/Strategic_Insights.png) |

---

# 📈 Key Business Insights

- GLC generated the highest revenue across all Mercedes-Benz models.
- North region contributed the highest overall revenue.
- Profit Margin remained above **28%** across the dataset.
- Revenue consistently increased throughout the three-year period.
- Premium SUV models generated the highest profitability.
- Revenue peaked during **October 2024**.
- Model × Region analysis revealed strong regional buying preferences.

# 📁 Project Structure

```text
Mercedes-Benz-Sales-Analytics/

│
├── images/
│   ├── Cover_Page.png
│   ├── Executive_Overview.png
│   ├── Model_Performance.png
│   ├── Regional_Insights.png
│   ├── Profitability_Analysis.png
│   ├── Sales_Performance.png
│   └── Strategic_Insights.png
│
├── videos/
│   └── Mercedes_Dashboard_Demo.mp4
│
├── data/
│   ├── raw/
│   │   ├── Mercedes_Sales_Data.csv
│   │   └── Mercedes_Sales_Data.xlsx
│   │
│   └── cleaned/
│       ├── mercedes_cleaned.csv
│       ├── mercedes.db
│       ├── Sales.csv
│       ├── Models.csv
│       └── Regions.csv
│
├── scripts/
│   ├── etl_pipeline.py
│   └── export_sqlite_tables.py
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── Mercedes_Sales_Dashboard.pbix
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

# 🔧 ETL Pipeline

The ETL process was built using **Python** and **Pandas** to transform raw sales data into an analysis-ready dataset.

### Load

- Import raw CSV dataset
- Validate schema
- Read sales records

### Validate

The pipeline automatically checks for:

- Missing values
- Duplicate Record IDs
- Invalid profit values
- Invalid units sold
- Price outliers using Z-Score analysis

### Clean

The cleaning process performs:

- Duplicate removal
- Missing value handling
- Standardized region values
- Financial data validation
- Outlier flagging
- Loss-making transaction preservation

### Feature Engineering

Additional business metrics are created including:

- Profit Margin %
- Price Tier
- Unit Tier
- Revenue
- Business Categories

### Export

The ETL pipeline generates:

- Clean analytical CSV
- SQLite Database
- Normalized relational tables

---

# 🗄 Database Schema

The project follows a **star-schema inspired design** with one fact table and two dimension tables.

## Fact Table

### Sales

Contains:

- Revenue
- Profit
- Units Sold
- Date
- Model_ID
- Region_ID
- Profit Margin
- Price Tier
- Unit Tier

---

## Dimension Tables

### Models

- Model_ID
- Model

### Regions

- Region_ID
- Region

This normalized structure minimizes redundancy while supporting efficient SQL analysis.

---

# 🔄 Data Migration Workflow

To demonstrate interoperability across database platforms, the normalized SQLite database was exported into flat CSV files and imported into **Microsoft SQL Server** using **SQL Server Management Studio (SSMS)**.

This approach mirrors a real-world analytics workflow where data is transformed before being migrated into an enterprise database for querying and reporting.

### Migration Pipeline

```text
SQLite Database
        │
        ▼
Export Individual Tables
        │
        ▼
Sales.csv
Models.csv
Regions.csv
        │
        ▼
Microsoft SQL Server
        │
        ▼
SQL Server Management Studio
        │
        ▼
Business SQL Analysis
```

---

# 📂 Generated Outputs

After executing the ETL pipeline, the following files are produced:

| Output | Description |
|---------|-------------|
| mercedes_cleaned.csv | Clean analytical dataset |
| mercedes.db | Normalized SQLite database |
| Sales.csv | Fact table export |
| Models.csv | Dimension table |
| Regions.csv | Dimension table |

These outputs are then imported into SQL Server for analytical querying and Power BI visualization.

# 📝 SQL Business Analysis

After migrating the cleaned data into **Microsoft SQL Server**, analytical SQL queries were executed using **SQL Server Management Studio (SSMS)** to answer business questions and validate the dataset.

The project contains **50+ SQL queries** organized into multiple analytical sections.

---

## SQL Analysis Areas

| Category | Business Objective |
|----------|--------------------|
| Database Exploration | Understand dataset structure |
| Data Validation | Verify table relationships and integrity |
| Sales KPIs | Revenue, Profit, Units Sold |
| Model Performance | Top & Bottom Performing Models |
| Regional Analysis | Compare Regional Performance |
| Model × Region Analysis | Cross-analysis of sales trends |
| Time-Series Analysis | Monthly & Quarterly Trends |
| Price Tier Analysis | Performance across Price Segments |
| Unit Tier Analysis | Sales Distribution |
| Advanced Analytics | Rankings, Contributions & Comparisons |
| SQL Views | Reusable analytical views |
| Final Validation | Cross-check SQL outputs with Power BI |

---

## SQL Concepts Demonstrated

The project demonstrates practical SQL skills including:

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- HAVING
- INNER JOIN
- LEFT JOIN
- CASE
- Common Table Expressions (CTEs)
- Views
- Aggregate Functions
- Window Functions
- DENSE_RANK()
- LAG()
- Date Functions
- Subqueries

---

# 📊 Power BI Dashboard

The final report consists of **7 interactive pages** designed with an executive-style Mercedes-Benz theme.

---

## Dashboard Pages

### 1️⃣ Cover Page

- Mercedes-Benz branding
- Interactive navigation
- Dashboard overview

---

### 2️⃣ Executive Overview

Displays high-level KPIs including:

- Total Revenue
- Total Profit
- Units Sold
- Profit Margin
- Revenue Trend
- Revenue by Region

---

### 3️⃣ Model Performance

Analyze sales performance across vehicle models.

Includes:

- Revenue by Model
- Profit by Model
- Units Sold
- Top Performing Models
- Model Rankings

---

### 4️⃣ Regional Insights

Analyze business performance across geographical regions.

Includes:

- Revenue Distribution
- Profit Distribution
- Units Sold
- Regional Rankings
- Market Contribution

---

### 5️⃣ Profitability Analysis

Focuses on profitability metrics.

Visuals include:

- Profit Margin
- Revenue vs Profit
- Margin Comparison
- Profit Contribution
- Revenue-to-Profit Ratio

---

### 6️⃣ Sales Performance

Time-based performance analysis.

Includes:

- Monthly Revenue
- Quarterly Revenue
- Monthly Profit
- Year-over-Year Trends
- Month-over-Month Growth

---

### 7️⃣ Strategic Insights

Cross-dimensional business analysis.

Visuals include:

- Model × Region Heatmap
- Top Revenue Combinations
- Profit Comparison
- Regional Preferences
- Business Summary

---

# 💡 Dashboard Features

The dashboard includes several interactive capabilities:

- Executive KPI Cards
- Interactive Navigation
- Dynamic Filter Panel
- Bookmark Navigation
- Apply & Reset Filters
- Dynamic DAX Measures
- Interactive Charts
- Consistent Color Palette
- Executive Layout
- Responsive Design
- Professional Mercedes-Benz Branding

---

# 📈 Key Dashboard KPIs

The dashboard tracks:

- Total Revenue
- Total Profit
- Units Sold
- Profit Margin
- Average Selling Price
- Revenue Growth
- Top Performing Model
- Top Performing Region
- Revenue Contribution
- Profit Contribution

---

# 🛠 Tech Stack

| Technology | Purpose |
|------------|----------|
| Python | ETL Pipeline |
| Pandas | Data Cleaning & Feature Engineering |
| SQLite | Intermediate Database |
| Microsoft SQL Server | Business Data Storage |
| SQL Server Management Studio (SSMS) | SQL Development |
| SQL | Business Analysis |
| Power BI | Dashboard Development |
| DAX | KPI Calculations |
| Git | Version Control |
| GitHub | Project Hosting |

---

# 🎯 Skills Demonstrated

This project showcases practical skills in:

- Data Cleaning
- Data Validation
- ETL Development
- Database Design
- SQL Query Writing
- Business Intelligence
- Dashboard Development
- Data Visualization
- DAX
- Data Migration
- Business Analytics
- Git Version Control

# 🚀 How to Run

## 1. Clone the Repository

```bash
git clone https://github.com/ANJALI7203/Mercedes-Benz-Sales-Analytics.git
cd Mercedes-Benz-Sales-Analytics
```

---

## 2. Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 3. Run the ETL Pipeline

Execute the ETL script to clean the raw dataset, perform feature engineering, and generate the analytical outputs.

```bash
python scripts/etl_pipeline.py
```

Generated outputs:

- `mercedes_cleaned.csv`
- `mercedes.db`

---

## 4. Export SQLite Tables

Export normalized SQLite tables into flat CSV files.

```bash
python scripts/export_sqlite_tables.py
```

Generated files:

- Sales.csv
- Models.csv
- Regions.csv

---

## 5. Import into SQL Server

Open **SQL Server Management Studio (SSMS)** and:

- Create a new database
- Import the generated CSV files
- Execute `analysis_queries.sql`

---

## 6. Open Power BI

Open:

```text
powerbi/Mercedes_Sales_Dashboard.pbix
```

Refresh the data source if required.

---

# 📊 Project Statistics

| Metric | Value |
|---------|-------|
| Dataset Period | 2023 – 2025 |
| Dashboard Pages | 7 |
| SQL Queries | 50+ |
| Database Tables | 3 |
| Python Scripts | 2 |
| Dashboard Visuals | 40+ |
| KPIs | 10+ |
| DAX Measures | 25+ |
| Database Platforms | SQLite + SQL Server |
| BI Tool | Power BI |

---

# 📌 Data Notes

- Dataset spans **January 2023 – December 2025**.
- Data is synthetic and intended for educational purposes.
- Missing values were handled during ETL.
- Duplicate records were removed.
- Price outliers were flagged rather than deleted.
- Loss-making transactions were preserved for business analysis.
- "Unknown" regions remain available for auditability while being excluded from dashboard KPIs where appropriate.

---

# 🎓 Learning Outcomes

This project strengthened my understanding of:

- End-to-End ETL Development
- Data Cleaning & Validation
- Feature Engineering
- Relational Database Design
- SQL Query Optimization
- Window Functions
- Business KPI Development
- Data Migration
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Dashboard Design
- DAX Calculations
- Git & GitHub Workflow

---

# 📬 Contact

**Anjali Singh**

- GitHub: https://github.com/ANJALI7203
- LinkedIn: *(Add your LinkedIn profile here)*

---

# 📄 License

This project uses **synthetic/sample data** for educational and portfolio purposes only.

Mercedes-Benz and all related trademarks belong to their respective owners.

This project is **not affiliated with, sponsored by, or endorsed by Mercedes-Benz AG.**

---

## ⭐ Support

If you found this project helpful or interesting, consider giving it a ⭐ on GitHub.

Feedback and suggestions are always welcome!
