{{ config(
    materialized = "table"
) }} 
WITH craiglist_vehicles AS (
    SELECT
        id,
        region,
        TRY_CAST(COALESCE(NULLIF(price, 'None'), '0') AS INTEGER) AS price,
        year,
        manufacturer,
        model,
        condition,
        cylinders,
        fuel,
        TRY_CAST(COALESCE(NULLIF(odometer, 'None'), '0') AS INTEGER) AS odometer,
        title_status,
        transmission,
        drive,
        size,
        type,
        paint_color,
        state,
        TRY_CAST(posting_date AS DATETIME) AS posting_date
    FROM capstoneproject.craiglistvehicles.craiglist_vehicles
)
SELECT * FROM craiglist_vehicles