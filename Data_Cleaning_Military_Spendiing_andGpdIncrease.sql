CREATE DATABASE world_data_budget;
USE world_data_budget;

SELECT * FROM military_spending; 
SELECT * FROM world_active_military;

/* WORLD MILITARY EXPENDITURE, 2022 */

SELECT country2, Military_Spending AS military_expenditure
FROM military_spending
ORDER BY military_spending DESC
LIMIT 15;

/* The 10 countries with the highest military spending as a share of gross domestic product are listed */

SELECT country2,Share_fGDP AS share_GDP 
FROM military_spending
ORDER BY Share_fGDP DESC
LIMIT 15 ;

/* WORLD highest active personel and the lowest Active personel */
SELECT Country, ActiveMiltary_2022 AS world_highest_military_personel
FROM world_active_military
ORDER BY ActiveMiltary_2022 DESC
LIMIT 15;


SELECT Country, ActiveMiltary_2022 AS world_lowest_military_personel
FROM world_active_military
WHERE ActiveMiltary_2022 > 0
ORDER BY ActiveMiltary_2022 ASC
LIMIT 15;

/* Country fastest growth increase base on Active military 2022 vs percentage change (2021) */

SELECT Country,Percentage_Change AS Highest_increase
FROM world_active_military
WHERE Percentage_change <> 'INF%'
ORDER BY Percentage_Change DESC
LIMIT 15 ;


