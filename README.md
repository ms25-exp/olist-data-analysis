# Olist E-commerce Data Analysis
**Python | MySQL | Power BI**

## Overview
This project analyzes the Olist e-commerce dataset through an end-to-end data analytics workflow covering data preparation, SQL-based validation, business logic verification, and dashboard-ready reporting.

The objective is not only to clean and load the data, but also to validate whether the dataset is reliable enough for KPI reporting and business decision-making. The project follows a structured analyst approach: prepare the data, validate the logic, and then build reporting outputs with confidence.

---

## Business Objective
The purpose of this project is to generate meaningful business insights related to:

- sales performance
- customer behavior
- delivery efficiency
- payment patterns
- seller contribution
- product category performance
- customer reviews and feedback trends

The final output is intended to support business reporting through SQL analysis and Power BI dashboards.

---

## Tools and Technologies
- **Python**: Pandas, NumPy, OS, MySQL Connector
- **SQL**: MySQL
- **Visualization**: Power BI
- **Version Control**: Git and GitHub

---

## Project Structure
```text
Olist_Project/
│
├── data/
│   ├── raw/        # Original source datasets
│   └── cleaned/    # Cleaned and SQL-safe datasets
│
├── notebooks/      # Python cleaning, preprocessing, and workflow documentation
├── sql/            # Schema, load scripts, validation queries, and business SQL
└── README.md
```
---

## 🚀 Project Progress

### 1. Project Setup and Data Understanding
- organized the project into raw data, cleaned data, notebooks, and SQL layers
- reviewed source datasets to understand structure, grain, and initial data quality
- established the workflow for Python, SQL, and Power BI integration

### 2. Data Cleaning and Preprocessing
- standardized column names and formats
- handled missing values using business-aware logic
- removed duplicates where appropriate
- converted date and numeric columns into analysis-ready format
- prepared cleaned CSV files for MySQL loading
- created SQL-safe files for tables requiring special handling during load

### 3. Relational Modeling and Schema Design
- identified the analytical role of each table
- defined key fields and business grain across major datasets
- generated SQL schema for MySQL table creation
- aligned data types to support analysis and dashboarding

### 4. SQL Loading and Technical Validation
- Created SQL-safe cleaned files for database loading
- Worked on `LOAD DATA INFILE` process for multiple tables
- Resolved issues related to:
  - duplicate records
  - column length limits
  - datatype mismatches
  - geolocation load checks
- Validated row counts between CSV files and SQL tables
- checked duplicates, nulls, and structural consistency

### 5. Business Validation Before Dashboarding
Before building the dashboard, the dataset is being validated from a business reporting perspective to ensure KPI calculations are trustworthy.
This includes checks such as:
- order grain validation
- revenue sanity checks
- orders without payment
- orders without review
- delivery timeline consistency
- delayed order logic
- category translation coverage
- monthly order and revenue trend readiness
This step helps ensure that reporting logic is based on reliable and interpretable data.

---

## ✅ Validation Approach
### Technical Validation
Technical validation ensures that the data has been loaded and structured correctly.
Examples:
- row count comparison between CSV files and SQL tables
- duplicate checks on key columns
- null checks on important fields
- datatype and loading issue resolution

### Business Validation
Business validation ensures that the dataset is ready for KPI reporting and dashboard interpretation.
Examples:
- validating order grain before calculating total orders
- checking payment coverage before reporting revenue
- checking review coverage before analyzing customer feedback
- validating delivery dates before calculating delivery KPIs
- checking category translation completeness before category-level reporting
- validating monthly trends before building time-based visuals
  
---

## 📈 Current Status
- core datasets cleaned and prepared in Python
- SQL schema generated and refined
- major tables loaded into MySQL
- technical validation completed for core tables
- business validation in progress for dashboard readiness
- project documentation and Git version control actively maintained

---

## 📊 Planned Dashboard Focus
The Power BI dashboard will aim to answer questions such as:
- How are orders and revenue trending over time?
- Which product categories contribute most to sales?
- What does delivery performance look like across orders?
- Which payment methods are most commonly used?
- How do review scores and written feedback behave?
- Which sellers and customer regions contribute most to performance?

---

## 🎯 Expected Outcomes
The final deliverable will be an end-to-end analytics project that demonstrates:
- data cleaning and preparation in Python
- SQL-based data loading and validation
- business-focused data quality checks
- KPI-driven dashboard development in Power BI
- clear documentation and version-controlled project workflow