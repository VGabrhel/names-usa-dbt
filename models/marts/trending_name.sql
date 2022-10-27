{{ config(schema='marts', materialized='table') }}

WITH cte_last_two_year AS 
    (SELECT DISTINCT
        year
     FROM 
        {{ ref('L2_national')}}
     ORDER BY 
        year DESC 
     LIMIT 2)

SELECT DISTINCT
    name,
    gender,
    FIRST_VALUE(name_count)
        OVER w1 AS year_before_the_last_year,
    NTH_VALUE(name_count, 2)
        OVER w1 as last_year,
    (NTH_VALUE(CAST(name_count AS INT), 2)
        OVER w1 / FIRST_VALUE(CAST(name_count AS INT))
        OVER w1) * 100 AS trend_percent
FROM 
    {{ ref('L2_national')}} AS L2_national 
INNER JOIN 
    cte_last_two_year
        ON L2_national.year = cte_last_two_year.year
WINDOW w1 AS (
    PARTITION BY name, gender ORDER BY cte_last_two_year.year ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)