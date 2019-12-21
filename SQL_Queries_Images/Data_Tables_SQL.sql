CREATE TABLE BC (
	id serial primary key,
	Year character varying(100) NOT NULL,
	Period varchar (100) NOT NULL,
	Count character varying (100) NOT NULL
);
COPY MERGED FROM 'C:\Users\Crist\Desktop\HoneyBumbleBeez.github.io\CleanData\bc.csv' WITH (FORMAT CSV, DELIMITER ',');

SELECT *
FROM bc;
CREATE TABLE WD (
	id serial primary key,
	Year character varying (600) NOT NULL,
	Period varchar (600) NOT NULL,
	Mean_Temp character varying (600) NOT NULL);
COPY MERGED FROM 'C:\Users\Crist\Desktop\HoneyBumbleBeez.github.io\CleanData\wd.csv' WITH (FORMAT CSV, DELIMITER ',');

SELECT *
FROM wd;
SELECT
   bc.Year,
   bc.Period,
   bc.Count
FROM
	bc
INNER JOIN wd ON wd.Period = bc.period