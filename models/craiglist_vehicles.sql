with craiglist_vehicles as(
select 
id,
region,
price,
year,
manufacturer,
model,
condition,
cylinders,
fuel,
odometer,
title_status,
transmission,
drive,
size,
type,
paint_color,
state,
posting_date
from capstoneproject.craiglistvehicles.craiglist_vehicles
)
select * from craiglist_vehicles
