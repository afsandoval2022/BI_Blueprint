# Cohort Analysis Project

This project focuses on performing cohort analysis on sales data from CarMax. It includes SQL queries to analyze customer behavior patterns, such as active customers, repurchases, desertions, and returns, across different months.

## Project Structure

- **Databases:**
  - `carmax_v2.db`: SQLite database with sales data (version 2).
  - `carmax_v3.db`: SQLite database with sales data (version 3).
  - `FilgudTransaccional.db`: Additional transactional database.

- **SQL Scripts:**
  - `Cohort.sql`: Main query for cohort analysis. It calculates customer states per month based on purchase activity.
  - `Pivot_date.sql`: Script to generate a temporary sales table with random dates in 2022 for testing or simulation.

## Usage

1. Ensure SQLite is installed on your system.
2. To run the cohort analysis: `sqlite3 carmax_v3.db < Cohort.sql`
3. The query will output a pivoted table showing the state of each customer for each month (Active, Recompra, Desercion, etc.).

## Dashboards

- `Dashboard_v2.html`: Interactive dashboard visualizing cohort analysis with RFM segmentation. Features a line chart for cohort evolution and bar charts for RFM distributions.
- `Dashboard_v3.html`: Similar to Dashboard_v2.html but with a stacked column chart for cohort evolution instead of a line chart.

To view the dashboards, open the HTML files in a web browser.

## Requirements

- SQLite 3.x

## Contributing

Feel free to contribute by submitting pull requests or issues via GitHub.
