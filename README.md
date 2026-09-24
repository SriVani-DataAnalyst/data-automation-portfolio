# Data Analytics & Enterprise Automation Portfolio
Created by Sri Vani Karthikeyan

Welcome! This repository hosts production-ready analytical data models, automated data pipelines, query engines, and risk tracking frameworks. The projects below are built to process multi-million row datasets efficiently, remove manual bottlenecks, and deliver governed data directly to business leaders.

---

## 🛠️ Portfolio Project Index

### 1. Customer Risk & Portfolio Data Mart Architecture ([View SQL Script](./customer_risk_data_mart.sql))
* **Objective:** Transforms raw, unorganized banking and transaction logs into an optimized Star-Schema (Fact and Dimension tables) to accelerate dashboard refreshing and ad-hoc query performance.
* **Core Technical Stack:** Advanced SQL (Amazon Redshift/PostgreSQL layout), CTE Expressions, Complex Joins, Window Functions (`DENSE_RANK()`).
* **Defensive Engineering:** Embedded explicit `COALESCE` statements to handle missing data attributes safely and implemented `NULLIF` parameters across division steps to completely prevent divide-by-zero database crashes.

### 2. Credit Score Migration & Cut-Off Strategy Simulator ([View Python Script](./portfolio_risk_migration.py))
* **Objective:** Simulates portfolio vintage migrations and analyzes historical trends to test alternative credit score cut-off strategies. 
* **Core Technical Stack:** Python (`pandas`, `numpy`), Vectorized Computations, Data Aggregation Matrices.
* **Defensive Engineering:** Utilizes fast NumPy indexing loops instead of heavy standard iterative loops, providing zero data-drop processing across large datasets.

### 3. High-Speed Data Reconciliation & Auditing Engine ([View VBA Script](./vba_reconciliation_tool.txt))
* **Objective:** Cross-checks records between divergent database dumps (Oracle vs. Redshift environment outputs) to instantly catch data drops or mismatches before reporting.
* **Core Technical Stack:** Excel Advanced VBA, Memory Arrays, Scripting Dictionaries (`Scripting.Dictionary`), Output Log Handlers.
* **Defensive Engineering:** Bypasses sluggish spreadsheet cell loops by reading thousands of rows directly into virtual memory arrays, dropping manual data processing times from hours to under 3 minutes without Excel lag.

### 4. Marketplace Performance & SLA Analytics Tracker ([View SQL Script](./amazon_risk_analysis.sql))
* **Objective:** Tracks regional order pipelines, isolating delivery delays and calculating operational performance metrics across heavy seller portfolios.
* **Core Technical Stack:** SQL, Advanced Aggregations, Partitioned Window Functions, Data Window Filtering.
* **Defensive Engineering:** Built with segmented Common Table Expressions (CTEs) to maximize query optimization on large analytical data warehouses.

---

## 🔒 Professional NDA & Governance Compliance
*Note: To strictly protect enterprise data assets and adhere to active corporate Non-Disclosure Agreements (NDAs), all database architectures, source tables, system labels, and variable parameters contained within this repository are structured purely on synthetic, open-source mock schemas.*
