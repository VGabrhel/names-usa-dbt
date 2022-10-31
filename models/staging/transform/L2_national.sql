{{ config(schema='transform', materialized='table') }}

/* Identify unisex names */

WITH cte_unisex_name AS (
SELECT DISTINCT 
      name 
    FROM 
      {{ ref('L1_national') }}
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
   {{ ref('L1_national') }} AS L1
LEFT JOIN 
    cte_unisex_name
        ON cte_unisex_name.name = L1.name