{{ config(schema='marts', materialized='table') }}

SELECT DISTINCT
    name,
    state,
    gender,
    is_unisex,
    name_count 
FROM 
    {{ ref('L2_state')}}