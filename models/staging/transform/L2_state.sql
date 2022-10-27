{{ config(schema='transform', materialized='table') }}

WITH cte_unisex_name AS (
SELECT DISTINCT 
      name 
    FROM 
      {{ source('transform', 'L1_state') }}
    GROUP BY 
      name  
    HAVING 
      COUNT(DISTINCT gender) > 1 
)

SELECT
   L1.*,
   CASE
        WHEN L1.name = cte_unisex_name.name THEN 1 
        ELSE 0
   END AS is_unisex
FROM 
   {{ source('transform', 'L1_state') }} AS L1
LEFT JOIN 
    cte_unisex_name
        ON cte_unisex_name.name = L1.name