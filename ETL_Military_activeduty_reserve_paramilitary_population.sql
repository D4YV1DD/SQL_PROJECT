USE military;
SELECT * FROM liist_country;

/* Top country that have highest active duty,reserve and paramilitary */

SELECT country,(activeDuty + paramilitary + reserves) AS total_military 
FROM liist_country
group by country,activeDuty,paramilitary,reserves
;

/* Top country that have highest total of active duty and reserve */
SELECT  country,(activeDuty  + reserves) AS total_military 
FROM liist_country
group by country,activeDuty,reserves
ORDER BY total_military DESC
LIMIT 10
;
/* country have the highest active personel */
SELECT country,activeDuty 
FROM liist_country
group by country,activeDuty
ORDER BY activeDuty DESC
limit 15;

/* country have highest population */
SELECT country,pop2022 
FROM liist_country
group by country,pop2022
ORDER BY pop2022 DESC
limit 15;