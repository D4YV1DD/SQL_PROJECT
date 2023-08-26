CREATE DATABASE sales_project;
USE sales_project;

DROP TABLE IF EXISTS february,july,june,junuary,march,may;

/* Data wrangling and cleaning the data */
DESCRIBE supermarket_sales;

ALTER TABLE supermarket_sales
CHANGE COLUMN `Invoice ID` `Invoice_ID` text;

ALTER TABLE supermarket_sales
RENAME COLUMN new_column_name TO Invoice_ID;

SELECT *
FROM supermarket_sales;

ALTER TABLE supermarket_sales
CHANGE COLUMN `Invoice ID` `Invoice_ID` TEXT,
CHANGE COLUMN `Customer type` `Customer_type` TEXT,
CHANGE COLUMN `Product line` `Product_line` TEXT,
CHANGE COLUMN `Unit price` `Unit_price` DOUBLE,
CHANGE COLUMN `Tax 5%` `Tax_5%` DOUBLE,
CHANGE COLUMN `gross margin percentage` `gross_margin_percentage` DOUBLE,
CHANGE COLUMN `gross income` `gross_income` DOUBLE;

ALTER TABLE supermarket_sales
CHANGE COLUMN `Tax 5%` `Tax_5` DOUBLE;


SELECT *
FROM supermarket_sales
WHERE date IS NULL;

DELETE FROM supermarket_sales
WHERE Customer_type IS NULL OR
	  Unit_price IS NULL OR
	  Quantity IS NULL OR
	  Date IS NULL OR
	  Payment IS NULL OR 
	  Rating IS NULL;
      
/* fixing date format */
ALTER TABLE supermarket_sales
MODIFY COLUMN Date DATE;
ALTER TABLE supermarket_sales ADD COLUMN New_Date DATE;
UPDATE supermarket_sales SET New_Date = STR_TO_DATE(Date, '%m/%d/%Y');
ALTER TABLE supermarket_sales DROP COLUMN Date;
ALTER TABLE supermarket_sales CHANGE COLUMN New_Date Date DATE;


/* What is the gender distribution among supermarket customers? */

SELECT gender,
ROUND(SUM(total),2) as Total_Revenue
FROM supermarket_sales
GROUP BY Gender;

/* Customer Gneder Count  base on percentage */

SELECT 
(SUM(Gender = 'Male') / COUNT(*)) * 100 as Male_Count,
(SUM(Gender = 'Female') / COUNT(*)) * 100 AS Female_Count
FROM supermarket_sales ;

/* customer type volume base on percentage */

SELECT 
(SUM(customer_type = 'Member') / COUNT(*)) * 100 AS total_member_customer,
(SUM(customer_type = 'Normal') / COUNT(*)) * 100 AS total_normal_customer
FROM supermarket_sales ;

/* Customer type that got the highest Revenue */

SELECT DISTINCT Customer_type,ROUND(SUM(total),2) AS Total_Revenue
FROM supermarket_sales
GROUP BY Customer_type;
 
/* Overall customer in junuary,febuarary,march */

SELECT COUNT(Customer_type) as Total_customer
FROM supermarket_sales;

/* Which products have the highest sales volume ,product quantity and  revenue? 
SELECT distinct Product_line
FROM supermarket_sales; */

/* product line volume base on percentage */

SELECT 
(SUM(Product_line = 'Food and beverages')/ COUNT(*)) * 100 AS Food_and_beverages,
(SUM(Product_line = 'Health and beauty')/ COUNT(*)) * 100 AS Health_and_beauty,
(SUM(Product_line = 'Fashion accessories')/ COUNT(*)) * 100 AS Fashion_accessories,
(SUM(Product_line = 'Electronic accessories') / COUNT(*)) * 100 AS Electronic_accessories,
(SUM(Product_line = 'Home and lifestyle') / COUNT(*)) * 100 AS Home_and_lifestyle,
(SUM(Product_line = 'Sports and travel') / COUNT(*)) * 100 AS Sports_and_travel
FROM supermarket_sales;

/* product volume with the total quantity */

SELECT Product_line, SUM(Quantity) AS Total_Quantity
FROM supermarket_sales
GROUP BY Product_line
ORDER BY Total_Quantity DESC;

/* product volume with the total revenue */

SELECT product_line ,ROUND(SUM(total),2) AS Total_Revenue
FROM supermarket_sales
GROUP BY product_line
ORDER BY  Total_Revenue DESC
LIMIT 6;


/* Are there specific times of the year when certain product categories
 experience increased sales?*/
 
SELECT  YEAR(Date) AS Year,
CASE   
WHEN MONTH(Date) = 1 THEN 'January'
WHEN MONTH(Date) = 2 THEN 'February'
WHEN MONTH(Date) = 3 THEN 'March'
END AS Month,
SUM(Total) AS Total_Revenue
FROM supermarket_sales
GROUP BY YEAR(Date),month
ORDER BY Total_Revenue DESC;

/* customer purchase base on time moment */

SELECT ROUND(SUM(Total),2) AS Total_Revenue,
CASE
WHEN HOUR(Time) >= 0 AND HOUR(Time) < 6 THEN 'night'
WHEN HOUR(Time) >= 6 AND HOUR(Time) < 12 THEN 'morning'
WHEN HOUR(Time) >= 12 AND HOUR(Time) < 18 THEN 'afternoon'
ELSE 'evening'
END AS day_part
FROM supermarket_sales
GROUP BY day_part
ORDER BY Total_Revenue DESC;

/* What are the proportions of different payment methods
(cash, credit card, debit card, mobile wallets, etc.) used by customers in the supermarket? 
SELECT DISTINCT payment 
FROM supermarket_sales ; */

SELECT 
(SUM(payment = 'Ewallet' ) / COUNT(*)) * 100 AS Ewallet_Transaction,
(SUM(payment = 'Cash') / COUNT(*)) * 100 AS Cash_Transaction,
(SUM(payment = 'Credit card') / COUNT(*)) * 100 AS Credit_Card_Transaction
FROM supermarket_sales ;

/* Branch with highest revenue 
SELECT DISTINCT City,branch
FROM supermarket_sales ; */

SELECT DISTINCT branch, ROUND(SUM(total),2) AS total_revenue
FROM supermarket_sales
GROUP BY branch
ORDER BY total_revenue ;

/* total revenue per city and thier customer count */

SELECT DISTINCT city,
COUNT(customer_type) AS total_customer,
ROUND(SUM(total),2) as total_revenue_per_city
FROM supermarket_sales 
GROUP BY city
ORDER BY total_revenue_per_city ;

/* total ammount of 5% task that deducted per product */
SELECT product_line, ROUND(SUM(Tax), 2) AS Total_deducted
FROM supermarket_sales
GROUP BY product_line;

ALTER TABLE supermarket_sales
CHANGE COLUMN `Tax_5%` `Tax` DOUBLE ;

/* total decuted tax per month */

SELECT YEAR(DATE) AS Year ,
CASE   
WHEN MONTH(Date) = 1 THEN 'January'
WHEN MONTH(Date) = 2 THEN 'February'
WHEN MONTH(Date) = 3 THEN 'March'
END AS Month,ROUND(SUM(Tax),2) as total_deducted_per_month
FROM supermarket_sales
GROUP BY Year,month
ORDER BY total_deducted_per_month DESC;

/* top product highest rating */

SELECT product_line,MAX(rating) as Highest_rating,
CASE 
WHEN MAX(rating) = 10 THEN 'Outstanding'
WHEN MAX(rating) = 9.9 THEN 'Excellent' 
END AS satisfaction
FROM supermarket_sales
GROUP BY product_line
ORDER BY Highest_rating DESC;

/* data set link https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales */




