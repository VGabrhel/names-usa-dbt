SELECT
   ID as customer_id,
   FIRST_NAME AS first_name,
   LAST_NAME AS last_name
FROM 
   {{ source('jaffle_shop', 'customers') }}