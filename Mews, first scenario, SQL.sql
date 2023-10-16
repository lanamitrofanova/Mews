-- Join tables + days of week

create or replace table "Reservations with rates" as
select R1.*, R2."RateName", R2."SettlementAction", R2."SettlementTrigger", R2."SettlementValue", CASE DAYOFWEEK(TO_TIMESTAMP("CreatedUtc")) 
    WHEN 0 THEN 'Sunday'
    WHEN 1 THEN 'Monday'
    WHEN 2 THEN 'Tuesday'
    WHEN 3 THEN 'Wednesday'
    WHEN 4 THEN 'Thursday'
    WHEN 5 THEN 'Friday'
    WHEN 6 THEN 'Saturday'
end as "DayOfWeek"
from "Reservations" as R1
left join "Rates" as R2 on R1."RateId" = R2."RateId";

select * from "Reservations with rates";

-- task 1

SELECT t1."RateName", t1."AgeGroup", t2."Gender", t3."NationalityCode"
FROM

(SELECT "RateName", "AgeGroup"
FROM (
    SELECT "RateName", "AgeGroup", 
           ROW_NUMBER() OVER (PARTITION BY "RateName" ORDER BY COUNT("AgeGroup") DESC) as rank
    FROM "Reservations with rates"
    where "AgeGroup" != 0
    GROUP BY "RateName", "AgeGroup"
) 
WHERE rank = 1) AS t1

JOIN

(SELECT "RateName", "Gender"
FROM (
    SELECT "RateName", "Gender",
           ROW_NUMBER() OVER (PARTITION BY "RateName" ORDER BY COUNT("Gender") DESC) as rank
    FROM "Reservations with rates"
    where "Gender" != 0
    GROUP BY "RateName", "Gender"
) 
WHERE rank = 1) AS t2 on t1."RateName" = t2."RateName"

JOIN

(SELECT "RateName", "NationalityCode"
FROM (
    SELECT "RateName", "NationalityCode",
           ROW_NUMBER() OVER (PARTITION BY "RateName" ORDER BY COUNT("NationalityCode") DESC) as rank
    FROM "Reservations with rates"
    where "NationalityCode" != 'NULL'
    GROUP BY "RateName", "NationalityCode"
) 
WHERE rank = 1) AS t3 on t2."RateName" = t3."RateName";


-- task 2, for the whole week

SELECT 

    (SELECT top 1 "AgeGroup"
     FROM "Reservations with rates"
     WHERE "IsOnlineCheckin" = 1
     GROUP BY "AgeGroup"
     ORDER BY COUNT(*) DESC) as "Age",
     
    (SELECT TOP 1 "Gender"
     FROM "Reservations with rates"
     WHERE "IsOnlineCheckin" = 1
     GROUP BY "Gender"
     ORDER BY COUNT(*) DESC) as "Gender",
     
    (SELECT TOP 1 "NationalityCode"
     FROM "Reservations with rates"
     WHERE "IsOnlineCheckin" = 1
     GROUP BY "NationalityCode"
     ORDER BY COUNT(*) DESC) as "Nationality"

;

-- task 2, days in a week

create or replace table "Task2" as

SELECT 
    'All week' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL


SELECT 
    'Monday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Monday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Monday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Monday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Tuesday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Tuesday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Tuesday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Tuesday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Wednesday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Wednesday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Wednesday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Wednesday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Thursday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Thursday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Thursday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Thursday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Friday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Friday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Friday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Friday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Saturday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Saturday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Saturday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Saturday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"

UNION ALL

SELECT 
    'Sunday' as "DayOfWeek",
    (
        SELECT top 1 "AgeGroup"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Sunday'
        GROUP BY "AgeGroup"
        ORDER BY COUNT(*) DESC
    ) as "Age",
     
    (
        SELECT TOP 1 "Gender"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Sunday'
        GROUP BY "Gender"
        ORDER BY COUNT(*) DESC
    ) as "Gender",
     
    (
        SELECT TOP 1 "NationalityCode"
        FROM "Reservations with rates"
        WHERE "IsOnlineCheckin" = 1 and "DayOfWeek" = 'Sunday'
        GROUP BY "NationalityCode"
        ORDER BY COUNT(*) DESC
    ) as "Nationality"
;


-- task 3

create or replace table "Revenue per single occupied capacity" as
select "NightCount", "NightCost_Sum", "OccupiedSpace_Sum", ("NightCost_Sum"/"OccupiedSpace_Sum") as "RevenuePerCapacity", "GuestCount_Sum", "IsOnlineCheckin", "NationalityCode", "Gender", "AgeGroup"
from "Reservations"
where "CancellationReason" = 'NULL' and "OccupiedSpace_Sum" != 0;

-- per gender
select "Gender", avg("RevenuePerCapacity") as "RevenuePerCapacityG"
from "Revenue per single occupied capacity"
where "Gender" != 0
group by "Gender"
order by "RevenuePerCapacityG" desc;

-- per Age
select "AgeGroup", avg("RevenuePerCapacity") as "RevenuePerCapacityA"
from "Revenue per single occupied capacity"
where "AgeGroup" != 0
group by "AgeGroup"
order by "RevenuePerCapacityA" desc;

-- per NationalityCode
select "NationalityCode", avg("RevenuePerCapacity") as "RevenuePerCapacityN"
from "Revenue per single occupied capacity"
where "NationalityCode" != 'NULL'
group by "NationalityCode"
order by "RevenuePerCapacityN" desc;

-- per gender Top 1
select TOP 1 "Gender", avg("RevenuePerCapacity") as "RevenuePerCapacityG"
from "Revenue per single occupied capacity"
where "Gender" != 0
group by "Gender"
order by "RevenuePerCapacityG" desc;

-- per gender Bottom 1
select TOP 1 "Gender", avg("RevenuePerCapacity") as "RevenuePerCapacityG"
from "Revenue per single occupied capacity"
where "Gender" != 0
group by "Gender"
order by "RevenuePerCapacityG" asc;

-- per Age Top 1
select TOP 1 "AgeGroup", avg("RevenuePerCapacity") as "RevenuePerCapacityA"
from "Revenue per single occupied capacity"
where "AgeGroup" != 0
group by "AgeGroup"
order by "RevenuePerCapacityA" desc;

-- per Age Bottom 1
select TOP 1 "AgeGroup", avg("RevenuePerCapacity") as "RevenuePerCapacityA"
from "Revenue per single occupied capacity"
where "AgeGroup" != 0
group by "AgeGroup"
order by "RevenuePerCapacityA" asc;

-- per NationalityCode Top 1
select TOP 1  "NationalityCode", avg("RevenuePerCapacity") as "RevenuePerCapacityN"
from "Revenue per single occupied capacity"
where "NationalityCode" != 'NULL'
group by "NationalityCode"
order by "RevenuePerCapacityN" desc;

-- per NationalityCode Bottom 1
select TOP 1  "NationalityCode", avg("RevenuePerCapacity") as "RevenuePerCapacityN"
from "Revenue per single occupied capacity"
where "NationalityCode" != 'NULL'
group by "NationalityCode"
order by "RevenuePerCapacityN" asc;


