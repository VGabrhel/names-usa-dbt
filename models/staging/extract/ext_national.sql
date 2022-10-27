SELECT
   Id,
   `Name`,
   `Count`
FROM 
   {{ source('extract', 'national_gcs') }}