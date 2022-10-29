/* {{ config(schema='transform', materialized='table') }} */

SELECT
   MD5(Id) AS name_state_id,
   `Name` AS name,
   `Year` AS year,
   Gender AS gender,
   `State` AS state,
   `Count` AS name_count
FROM 
    {{ source('extract', 'state_gcs') }}
WHERE 
   `Name` != 'Name'