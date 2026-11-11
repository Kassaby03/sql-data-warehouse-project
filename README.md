# 📊 SQL Data Warehouse Project

## 🚀 Overview

This project demonstrates the design and implementation of a modern **SQL Server Data Warehouse**, following an end-to-end Data Engineering workflow.

The main objective is to integrate data from different source systems (CRM and ERP), transform raw data into clean and structured information, and build an analytical data model that supports business intelligence and reporting.

The project follows the **Medallion Architecture (Bronze, Silver, and Gold)** to organize data processing into clear and manageable layers.

## 🏗️ Data Architecture

The project follows a three-layer architecture:

```text
       CRM Sources       ERP Sources
            │                 │
            └────────┬────────┘
                     ▼
              BRONZE LAYER
              (Raw Data)
                     │
                     ▼
              SILVER LAYER
        (Cleaning & Transformation)
                     │
                     ▼
               GOLD LAYER
          (Business-Ready Data)
                     │
                     ▼
          Analytics & Reporting
```

### 🥉 Bronze Layer – Raw Data

- Stores raw data extracted from CRM and ERP source systems.
- Loads source data into SQL Server without applying business transformations.
- Maintains the original data for traceability and further processing.

### 🥈 Silver Layer – Data Transformation

- Cleans and standardizes raw data.
- Handles missing values and inconsistent data.
- Applies data quality rules and validation.
- Prepares reliable and consistent data for analytical modeling.

### 🥇 Gold Layer – Analytical Modeling

- Integrates data from different source systems.
- Implements a Star Schema data model.
- Organizes data into Fact and Dimension tables.
- Provides business-ready data for analytical queries and reporting.

## 🛠️ Technologies & Tools

- **Microsoft SQL Server** – Data warehouse database.
- **T-SQL** – Data extraction, transformation, and loading.
- **SQL Server Management Studio (SSMS)** – Database development and management.
- **Draw.io** – Data architecture and modeling diagrams.
- **Git & GitHub** – Version control and project management.

## 📂 Repository Structure

```text
sql-data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── docs/
│   ├── data_architecture/
│   ├── data_flow/
│   └── data_models/
│
├── scripts/
│   ├── init_database.sql
│   │
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── tests/
│
└── README.md
```

## ⚙️ Getting Started

### Prerequisites

Before running the project, make sure you have:

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS).
- Git installed on your machine.

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/Kassaby03/sql-data-warehouse-project.git
```

**2. Open the project**

Navigate to the project directory and open SQL Server Management Studio.

**3. Initialize the database**

Execute the database initialization script:

```text
scripts/init_database.sql
```

**4. Build and load the Bronze Layer**

Execute the Bronze layer scripts to create the required tables and load the raw CRM and ERP data.

**5. Build and process the Silver Layer**

Execute the Silver layer scripts to clean, standardize, and transform the data.

**6. Create the Gold Layer**

Execute the Gold layer scripts to build the analytical data model.

**7. Run Data Quality Tests**

Execute the SQL scripts inside the `tests/` directory to validate data consistency and integrity.

> **Note:** Update the source file paths in the loading scripts according to your local datasets directory before executing the ETL processes.

## 🧪 Data Quality & Validation

Data quality is an essential part of this project. Validation checks are performed to ensure:

- Data integrity and consistency.
- Handling of NULL values.
- Detection of duplicate records.
- Validation of primary and foreign key relationships.
- Accuracy of the final analytical model.

## 🎯 Key Learning Outcomes

Through this project, I gained practical experience in:

- Designing and implementing a SQL Server Data Warehouse.
- Understanding and applying Medallion Architecture.
- Developing ETL pipelines using T-SQL.
- Integrating data from multiple source systems.
- Data cleaning and transformation.
- Dimensional modeling and Star Schema design.
- Implementing data quality checks.
- Preparing data for business intelligence and analytics.

## 👨‍💻 Author

**Omar Ahmed Abdelaziz**

Computer and Communication Engineering Graduate | Aspiring Data Engineer

- GitHub: [Kassaby03](https://github.com/Kassaby03)
- Project Repository: [SQL Data Warehouse Project](https://github.com/Kassaby03/sql-data-warehouse-project)

---

⭐ If you find this project useful, feel free to explore the repository and share your feedback.