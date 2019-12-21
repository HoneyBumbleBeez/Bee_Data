DROP TABLE IF EXISTS MERGED; 

CREATE TABLE MERGED (
	id serial primary key,
	Year varchar(20),
	Period varchar(20),
	Mean_Land_Ocean_Temp_Celsius varchar(20),
	Count varchar(20)
);

COPY MERGED FROM 'C:\Users\Crist\Desktop\HoneyBumbleBeez.github.io\CleanData\BeeMerged_Edit.csv' WITH (FORMAT CSV, DELIMITER ',');



select nullif(Year, '')::int as Year, Period, Mean_Land_Ocean_Temp_Celsius, Count
from MERGED;

Select * 
From MERGED;