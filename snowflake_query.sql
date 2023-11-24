CREATE OR REPLACE STORAGE INTEGRATION SNOW_OBJECT
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::######:role/craiglist_vehicles_role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://craiglistvehicle/'

DESC INTEGRATION SNOW_OBJECT;
--Specify the file format
CREATE OR REPLACE FILE FORMAT CSV_FORMAT TYPE = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1 NULL_IF = ('NULL', 'null')
EMPTY_FIELD_AS_NULL = TRUE;

--
CREATE OR REPLACE STAGE snow_Stage_2023
  STORAGE_INTEGRATION = SNOW_OBJECT 
  URL = 's3://craiglistvehicle'
  FILE_FORMAT = my_csv_format; 

  create or replace file format my_csv_format
  type = csv
  record_delimiter = '\n'
  field_delimiter = ','
  skip_header = 1
  null_if = ('NULL', 'null')
  empty_field_as_null = true
  FIELD_OPTIONALLY_ENCLOSED_BY = '0x22'
        
create or replace table craiglist_vehicles
            (
                id varchar,
                region varchar,
                price varchar,
                year varchar,
                manufacturer varchar,
                model varchar,
                condition varchar,
                cylinders varchar,
                fuel varchar,
                odometer varchar,
                title_status varchar,
                transmission varchar,
                drive varchar,
                size varchar,
                type varchar,
                paint_color varchar,
                state varchar,
                posting_date varchar
            )

copy into craiglist_vehicles from @Snow_Stage_2023
            ON_ERROR = 'skip_file';

select * from capstoneproject.craiglistvehicles.craiglist_vehicles;
