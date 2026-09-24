# Data Automation & Reporting Portfolio
Created by Sri Vani Karthikeyan

This repository contains scratch-built automation scripts and query templates designed to handle large-scale data workflows, system reconciliation, and operational reporting. 

## 🛠️ Repository Contents

### 1. Data Reconciliation Engine ([View VBA Script](./vba_reconciliation_tool.txt))
* **What it does:** Cross-checks records between Oracle and Redshift system dumps to isolate data mismatches.
* **Why it's built this way:** Uses virtual memory arrays and scripting dictionaries (`Scripting.Dictionary`) instead of standard cell loops. This prevents Excel from freezing or crashing when processing datasets with hundreds of thousands of rows.
* **Features:** Includes a built-in execution timer to track script speed and basic error handlers (`On Error GoTo`) to reset application settings automatically if a connection fails.

### 2. Marketplace Risk & SLA Tracking ([View SQL Script](./amazon_risk_analysis.sql))
* **What it does:** Extracts 90 days of seller shipment metrics to track Order Defect Rates (ODR) and SLA delays.
* **Why it's built this way:** Uses Common Table Expressions (CTEs) and window functions (`DENSE_RANK()`) to segment high-volume sellers within specific regions. It includes data protection rules (`NULLIF`) to safely prevent divide-by-zero execution errors on massive data tables.

---
*Note: All data schemas, table names, and record outputs used here are generic/dummy formats to strictly respect corporate NDAs.*

