# MySQL_IBM-Cognos-Analytics_DDL-DML

The company collects and recycles solid waste across major cities in the country of Brazil. the company
*would like to create a data warehouse so that it can create reports like*

   * total waste collected per trucktype per station 

   * total waste collected  per station per city

   * total average waste collected per station per city
---


> I started designing ERD in MySQL and a Star Schema warehouse by identifying the columns for the various dimension and fact tables in the schema.

![imagen](tablas.png )

> load the data into the tables.

![imagen](load.png)

> aggregation queries
	
```postgresql
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

```
> Create a dashboard using Cognos Analytics

![imagen](dashboard.png)
