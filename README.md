# Introduction 

We want to implement an efficient solution for the various use-cases related to the US baby names.

As an initial dataset, you should use [US Baby Names](https://www.kaggle.com/datasets/kaggle/us-baby-names). The solution should consist of:

- Design data model for a data warehouse that could answer questions such as:
    - How did the name Ida change period-over-period nationally?
    - How did the name Ida change period-over-period in California?
    - What name is most unisex?
    - What names on the national level are too scarce on the state level?

- A data pipeline for Exporting data from the provided dataset, Transforming them and Loading them to the database regularly.

- An intuitive analytical dashboard to visualize insights such as:
    - Top 10 trending names
    - Top 10 states in newborns
    - Map with top names

# Solution 
- Due to the intention of deploying the solution to a cloud, I decided to develop the proposed solution directly in one of the existing cloud computing platforms, namely Google Cloud Platform. Here, 


## Design
-   

![Schema](https://storage.googleapis.com/baby-names-usa-1/us_baby_name.png)

## Data Lake
- Google Cloud Storage is used as a data lake
    - [National](https://storage.googleapis.com/baby-names-usa-1/NationalNames.csv)
    - [State](https://storage.googleapis.com/baby-names-usa-1/NationalNames.csv)

## Data Warehouse
- BigQuery serves as the data warehouse of choice. Here, three schemas exists: 
    a) Extract (raw data)
    b) Transform - L1 (initial data cleaning) and L2 (business logic implementation) transformations
    c) Data Marts - pre-calculated tables for different use-cases
- In adddition, [dbt](https://www.getdbt.com/) is used as a tool performing needed data transformations along with several key features (e.g., unit testing, data lineage or documentation)

## Vizualization
- Due to the easy integration with the rest of the GCP stack, the output data sources are linked to [Google Data / Looker Studio](https://datastudio.google.com/reporting/067fe3fa-186a-4798-b1d4-77157bec4466)

## Next Steps 
- Establish the extract part based on the preferred source - one option would be a scraper using the [US Social Security](https://www.ssa.gov/oact/babynames/).
