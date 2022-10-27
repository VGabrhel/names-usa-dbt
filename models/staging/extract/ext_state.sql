SELECT
   Id,
   `Name`,
   `State`,
   `Count`
FROM 
    {{ source('extract', 'state_gcs') }}