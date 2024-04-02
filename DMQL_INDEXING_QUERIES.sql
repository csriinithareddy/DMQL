/* Executing queries without indexing */

/* 1. Displaying the columns extracted by using multiple joins to join various columns */
/* Query execution time  = 00:00:03:822 (3 seconds, 822 msec) (1sec- 1000ms) */
SELECT "Accident"."AccidentID", "Accident"."Severity", "Weather"."Temperature(F)", "Feature"."Amenity"
FROM "Accident" 
INNER JOIN "Startlocation" ON "Accident"."AccidentID" = "Startlocation"."AccidentID"
INNER JOIN "Weather" ON "Accident"."AccidentID" = "Weather"."AccidentID"
LEFT JOIN "Feature" ON "Accident"."AccidentID" = "Feature"."AccidentID"
WHERE "Accident"."Start_Time" BETWEEN '2017-01-01 00:00:00' AND '2017-01-31 23:59:59'
AND "Startlocation"."Country" = 'US';

/* 2. Displaying the Average temperature and number of accidents for each state*/
/* Query execution time  = 00:00:02.925 */
SELECT "Startlocation"."State",
 AVG("Weather"."Temperature(F)") AS "AvgTemperature",
 COUNT(*) AS NumAccidents
FROM "Startlocation" 
 JOIN "Weather" ON "Startlocation"."AccidentID" = "Weather"."AccidentID"
GROUP BY
 "Startlocation"."State";
 
 /* 3. Displaying the temperature, start and end time of an accident whose severity is greater than 2 and the 
 precipitation is >0.5*/ 
 /* Query execution time  = 00:00:01.060 */
SELECT "Accident"."Start_Time", "Accident"."End_Time", "Weather"."Temperature(F)"
FROM "Accident"
INNER JOIN "Weather" ON "Accident"."AccidentID" = "Weather"."AccidentID"
WHERE "Accident"."Severity" >= 2 AND "Weather"."Precipitation(in)" > 0.5
ORDER BY "Accident"."Start_Time" DESC

/* Creating indexes for the AccidentID for the tables - Accident, Startlocation, Weather, and Feature */
/* Time taken to create the index: 00:00:08.942 */ 
CREATE INDEX accidenttable ON "Accident"("AccidentID");
/* Time taken to create the index: 00:00:13.169 */ 
CREATE INDEX startlocationtable ON "Startlocation"("AccidentID");
/* Time taken to create the index: 00:00:09.311 */ 
CREATE INDEX weathertable ON "Weather"("AccidentID");
/* Time taken to create the index: 00:00:14.400 */ 
CREATE INDEX featuretable ON "Feature"("AccidentID");

/* Executing the same queries after creating indexes */

/* 1. Displaying the columns extracted by using multiple joins to join various columns */
/* Query execution time  = 00:00:01.109 */
SELECT "Accident"."AccidentID", "Accident"."Severity", "Weather"."Temperature(F)", "Feature"."Amenity"
FROM "Accident" 
INNER JOIN "Startlocation" ON "Accident"."AccidentID" = "Startlocation"."AccidentID"
INNER JOIN "Weather" ON "Accident"."AccidentID" = "Weather"."AccidentID"
LEFT JOIN "Feature" ON "Accident"."AccidentID" = "Feature"."AccidentID"
WHERE "Accident"."Start_Time" BETWEEN '2017-01-01 00:00:00' AND '2017-01-31 23:59:59'
AND "Startlocation"."Country" = 'US';

/* 2. Displaying the Average temperature and number of accidents for each state*/
/* Query execution time  = 00:00:00.724 */
SELECT "Startlocation"."State",
 AVG("Weather"."Temperature(F)") AS "AvgTemperature",
 COUNT(*) AS NumAccidents
FROM "Startlocation" 
 JOIN "Weather" ON "Startlocation"."AccidentID" = "Weather"."AccidentID"
GROUP BY
 "Startlocation"."State";
 
 /* 3. Displaying the temperature, start and end time of an accident whose severity is greater than 2 and the 
 precipitation is >0.5*/ 
 /* Query execution time  = 00:00:00.070 */
SELECT "Accident"."Start_Time", "Accident"."End_Time", "Weather"."Temperature(F)"
FROM "Accident"
INNER JOIN "Weather" ON "Accident"."AccidentID" = "Weather"."AccidentID"
WHERE "Accident"."Severity" >= 2 AND "Weather"."Precipitation(in)" > 0.5
ORDER BY "Accident"."Start_Time" DESC

/* In few of the queries, we observed a significant difference in the execution time, whereas in the 3rd query,
there has not been much change. There was a considerable amount of difference in the execution time when I joined
more than 2 tables */