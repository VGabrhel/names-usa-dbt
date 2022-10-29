/* {{ config(schema='transform', materialized='table') }} */

SELECT
   MD5(`Id`) AS name_national_id,
   `Name` AS name,
   `Year` AS year,
   Gender AS gender,
   `Count` AS name_count
FROM 
   {{ source('extract', 'national_gcs') }}
WHERE
   `Name` != 'Name'