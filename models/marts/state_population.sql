{{ config(schema='marts', materialized='table') }}

SELECT DISTINCT
    state,
    year,
    SUM(CAST(name_count AS INT)) AS name_sum
FROM 
    {{ ref('L2_state')}}
GROUP BY
    state,
    year