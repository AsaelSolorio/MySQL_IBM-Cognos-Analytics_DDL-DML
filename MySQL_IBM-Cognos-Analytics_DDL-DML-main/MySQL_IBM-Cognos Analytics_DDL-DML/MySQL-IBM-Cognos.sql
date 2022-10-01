CREATE DATABASE MyDataBase;
USE MyDataBase;

CREATE TABLE MyDimDate (
dateid INTEGER PRIMARY KEY NOT NULL,
date  VARCHAR(20),
year INTEGER,
Quarter INTEGER,
QuarterName VARCHAR(10),
Month INTEGER,
Monthname VARCHAR(15),
Day INTEGER,
Weekday INTEGER,
WeekdayName VARCHAR(15)
);

CREATE TABLE DimStation (
Stationid INTEGER PRIMARY KEY NOT NULL,
City VARCHAR(30)
);


CREATE TABLE DimTruck (
Truckid INTEGER PRIMARY KEY NOT NULL,
TruckType VARCHAR(30)
);

CREATE TABLE FactTrips (
Tripid INTEGER PRIMARY KEY NOT NULL,
Dateid INTEGER,
Stationid INTEGER,
Truckid INTEGER,
Wastecollected FLOAT,
FOREIGN KEY (Dateid) REFERENCES MyDimDate(dateid),
FOREIGN KEY (Truckid) REFERENCES DimTruck(Truckid),
FOREIGN KEY (Stationid) REFERENCES DimStation(Stationid)

);

/*stationid, trucktype, total waste collected. */
SELECT A.Stationid, B.trucktype, SUM(C.Wastecollected) AS TOTAL_WASTE
FROM facttrips AS C
INNER JOIN dimstation AS A
ON C.Stationid = A.Stationid
INNER JOIN dimtruck AS B
ON C.Truckid = B.Truckid
GROUP BY (A.Stationid);


/* city, stationid, and total waste collected.*/
SELECT D.year, A.City,A.Stationid, SUM(Wastecollected) AS TOTAL_WASTE
FROM facttrips AS C
INNER JOIN dimstation AS A
ON C.Stationid = A.Stationid
INNER JOIN mydimdate AS D
ON C.dateid = D.dateid
GROUP BY ( A.Stationid);

/* city, stationid, and average waste collected. */
SELECT D.year, A.City,A.Stationid,AVG(Wastecollected) AS AVERAGE_TOTAL_WASTE
FROM facttrips AS C
LEFT JOIN dimstation AS A
ON C.Stationid = A.Stationid
LEFT JOIN mydimdate AS D
ON C.Dateid = D.Dateid
GROUP BY (A.Stationid);

