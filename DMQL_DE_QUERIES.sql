Select "Accident"."Severity" 
from "Accident" 
join "Startlocation" on "Accident"."AccidentID" = "Startlocation"."AccidentID" 
where "Startlocation"."County"='Erie' AND "Accident"."Severity" = 4;

Select "Accident"."Description" 
from "Accident" 
WHERE EXTRACT(HOUR FROM "Accident"."Start_Time") BETWEEN 1 AND 5;

SELECT "Startlocation"."Start_Time" 
FROM "Startlocation";

Select COUNT("Junction") 
from "Feature" 
where "Junction"='True';