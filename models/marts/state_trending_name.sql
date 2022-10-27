{{ config(schema='marts', materialized='table') }}

WITH cte_last_two_years AS 
(
    SELECT DISTINCT
        year
     FROM 
        {{ ref('L2_state')}}
     ORDER BY 
        year DESC 
     LIMIT 2)
     
SELECT DISTINCT
    name,
    state,
    gender,
    is_unisex,
    FIRST_VALUE(name_count)
        OVER w1 AS year_before_the_last_year,
    NTH_VALUE(name_count, 2)
        OVER w1 as last_year,
    (NTH_VALUE(CAST(name_count AS INT), 2)
        OVER w1 / FIRST_VALUE(CAST(name_count AS INT))
        OVER w1) * 100 AS trend_percent
FROM 
    {{ ref('L2_state')}} AS L2_state 
INNER JOIN 
    cte_last_two_years
        ON L2_state.year = cte_last_two_years.year
WINDOW w1 AS (
    PARTITION BY name, state, gender ORDER BY cte_last_two_years.year ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)