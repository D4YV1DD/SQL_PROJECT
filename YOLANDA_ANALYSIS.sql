USE typhoon;

SELECT * FROM casualties;

/* Count of Yolanda victim base on region */

SELECT Region,Status,
COUNT(CASE WHEN Status ='Dead'THEN 1 ELSE 0 END) AS Dead_Count,
COUNT(CASE WHEN Status ='Missing' THEN 1 ELSE 0 END) AS Missing_Count,
COUNT(CASE WHEN Status ='Injured' THEN 1 ELSE 0 END) AS Injured_Count
FROM casualties
GROUP BY Region,Status;

/* Count of Yolanda victims base on province */
SELECT Province,Status,
COUNT(CASE WHEN Status ='Dead'THEN 1 ELSE 0 END) AS Dead_Count,
COUNT(CASE WHEN Status ='Missing' THEN 1 ELSE 0 END) AS Missing_Count,
COUNT(CASE WHEN Status ='Injured' THEN 1 ELSE 0 END) AS Injured_Count
FROM casualties
GROUP BY Province,Status;

/* Count of all Missing,Dead and Injured */

SELECT Status,
COUNT(CASE WHEN Status ='Dead'THEN 1  END) AS Dead_Count,
COUNT(CASE WHEN Status ='Missing' THEN 1  END) AS Missing_Count,
COUNT(CASE WHEN Status ='Injured' THEN 1  END) AS Injured_Count
FROM casualties
GROUP BY Status;

/* Sum of all Victims */

SELECT COUNT(Status) AS Total_Victims
FROM casualties;

