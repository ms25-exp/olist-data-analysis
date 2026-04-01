# Olist E-commerce Data Analysis | Python, MySQL, Power BI

## 📌 Objective
This project focuses on analyzing the Olist e-commerce dataset to uncover meaningful business insights related to sales performance, customer behavior, delivery trends, seller activity, and product performance. The goal is to build an end-to-end data analysis project using Python, SQL, and Power BI with an industry-style workflow.

---

## 🛠️ Tools Used
- Python (Pandas, NumPy, OS, MySQL Connector)
- SQL (MySQL)
- Git & GitHub
- Power BI (planned for dashboarding and reporting)

---

## 📂 Project Structure
- `data/raw` → Original source datasets
- `data/cleaned` → Cleaned and SQL-safe datasets
- `notebooks` → Data cleaning, preprocessing, validation, and modeling notebooks
- `sql` → Schema files, load scripts, validation queries, and key-related SQL scripts

---

## 🚀 Project Progress

### Day 1: Project Setup and Data Understanding
- Set up project folders and workflow
- Loaded all raw Olist datasets
- Explored dataset structure, columns, and initial data quality

### Day 2: Data Cleaning and Preprocessing
- Standardized column names
- Handled missing values
- Removed duplicates where necessary
- Fixed inconsistent data formats
- Prepared cleaned CSV files for further processing

### Day 3: Data Modeling and Schema Creation
- Designed relational data model for the project
- Identified primary keys and foreign key relationships
- Generated SQL schema using Python
- Prepared table creation logic for MySQL database setup

### Day 4: SQL Load Preparation and Validation
- Created SQL-safe cleaned files for database loading
- Worked on `LOAD DATA INFILE` process for multiple tables
- Resolved issues related to:
  - duplicate records
  - column length limits
  - datatype mismatches
  - geolocation load checks
- Validated row counts between CSV files and SQL tables
- Investigated mismatches in review and geolocation-related data
- Improved notebook flow with more meaningful step-wise processing
- Updated GitHub with current project progress and fixes

---

## ✅ Current Status
- Data cleaning completed for major datasets
- Schema creation completed
- SQL loading completed for multiple tables
- Validation work in progress for full database consistency
- Project structure and version control actively maintained in GitHub

---

## 📊 Next Steps
- Complete SQL validation for all loaded tables
- Write business-focused SQL analysis queries
- Generate business insights from cleaned and validated data
- Build Power BI dashboard for reporting and storytelling
- Finalize project documentation and presentation-ready outputs

---

## 🎯 Expected Outcomes
- Clean and structured relational database
- Validated data ready for analysis
- SQL queries answering real business questions
- Interactive Power BI dashboard
- Strong portfolio project demonstrating data analyst skills end to end
