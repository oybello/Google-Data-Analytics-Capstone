/* These codes are the codes for one-year review of the divvy_trip data for 2023
   period. The codes are part of the deliverables of my project towards the completion 
   and award of Google Data Analytics Professional Certificate course. 
   The codes can be reused for educational purposes without contacting the author (Yusuf Olanrewaju Bello).
   However, the use of the code or reposting large part of it for commercial benefit requires the consent of the author.
*/

--create database divvy_tripdata

CREATE DATABASE divvy_tripdata;

--create table divvy_tripdta_2023

CREATE TABLE divvy_tripdata_2023 (
	ride_id varchar(32),
	rideable_type varchar(30),
	started_at timestamptz,
	ended_at timestamptz,
	start_station_name varchar(50),
	start_station_id varchar(30),
	end_station_name varchar(50),
	end_station_id varchar(30),
	start_lat double precision,
	start_lng double precision,
	end_lat double precision,
	end_lng double precision,
	member_casual varchar(15)
);

--Update the end_station_id column to accommodate more than 50 characters
ALTER TABLE divvy_tripdata_2023
ALTER COLUMN end_station_id TYPE VARCHAR(100);

--Update the end_station_name column to accommodate more than 50 characters
ALTER TABLE divvy_tripdata_2023
ALTER COLUMN end_station_name TYPE VARCHAR(250);

--load csv files (for the 12 months of all members' records) onto postgresql database as shown below
--the 12 tables (extracted from the 12 csv files) were appended because they have the same number of columns
-- and the same type of column

--load the January divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202301-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the February divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202302-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the March divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202303-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the April divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202304-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the May divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202305-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the June divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202306-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the July divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202307-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the August divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202308-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the September divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202309-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the October divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202310-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the November divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202311-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

--load the December divvy_tripdata_2023

COPY divvy_tripdata_2023
FROM 'C:\my directory\202312-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

-- check the table
SELECT* from divvy_tripdata_2023;

--data cleaning 
---remove blank rows
DELETE FROM "divvy_tripdata_2023" WHERE "ride_id" = '';


--Get the count of members for the whole year and export result to Excel for visualization
SELECT COUNT(DISTINCT ride_id), member_casual 
FROM divvy_tripdata_2023
GROUP BY member_casual


--Get the average of ride_length for the whole year and export result to Excel for visualization   
SELECT member_casual, avg(ended_at - started_at) AS "average of ride_length"               
FROM divvy_tripdata_2023
GROUP BY member_casual;    

--Get the average of ride_length for the whole year grouped by day_of_week and export result to Excel for visualization

SELECT member_casual, extract(dow from started_at) + 1 AS day_of_week, 
                      avg(ended_at - started_at) AS "average of ride_length"              
FROM divvy_tripdata_2023
GROUP BY member_casual, day_of_week
ORDER BY member_casual ASC; 

--Get the counts of members who rode different bikes and the bikes that they rodeover the year (2023)
SELECT COUNT(DISTINCT ride_id), member_casual, rideable_type
FROM divvy_tripdata_2023
GROUP BY member_casual, rideable_type 

-- Get the counts of members who rode bikes in different days of the week
SELECT COUNT(DISTINCT ride_id), member_casual, extract(dow from started_at) + 1 AS day_of_week            
FROM divvy_tripdata_2023
GROUP BY member_casual, day_of_week;

--Get the average lengths of time members rode different bikes throughout the year
SELECT  rideable_type, member_casual, avg(ended_at - started_at) AS "average of ride_length"              
FROM divvy_tripdata_2023
GROUP BY rideable_type, member_casual
ORDER BY rideable_type; 

