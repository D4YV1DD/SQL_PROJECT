USE addidas_sale;
DROP TABLE addidas;

/* DML 
 Schema Modification
 */
 DESCRIBE addidas ;
 ALTER TABLE addidas
	   CHANGE COLUMN `Retailer ID` `Retailer_ID` INTEGER,
       CHANGE COLUMN `Invoice Date` `Invoice_Date` INTEGER,
       CHANGE COLUMN `Price per Unit` `Price_per_Unit` INTEGER,
       CHANGE COLUMN `Units Sold` `Units_Sold` INTEGER,
       CHANGE COLUMN `Total Sales` `Total_Sales` INTEGER,
       CHANGE COLUMN `Operating Profit` `Operating_Profit` INTEGER,
       CHANGE COLUMN `Operating Margin` `Operating_Margin` DOUBLE,
       CHANGE COLUMN `Sales Method` `Sales_Method` TEXT;

 ALTER TABLE addidas
	    CHANGE COLUMN `Invoice_Date` `Invoice_dates` DATE;
ALTER TABLE addidas
	  DROP COLUMN Invoice_Date;
ALTER TABLE invoice_date 
	  CHANGE COLUMN `Invoice Date` `Invoice_Date` TEXT;
ALTER TABLE invoice_date
	  CHANGE COLUMN `Retailer ID` `Retailer_ID` INTEGER;
UPDATE invoice_date SET New_Date = STR_TO_DATE(Invoice_Date, '%m/%d/%Y');

ALTER TABLE supermarket_sales
MODIFY COLUMN Date DATE;
ALTER TABLE invoice_date ADD COLUMN New_Date DATE;
UPDATE invoice_date SET New_Date = STR_TO_DATE(Invoice_Date, '%m/%d/%Y');
UPDATE invoice_date
SET New_Date = STR_TO_DATE(Invoice_Date, '%d/%m/%Y');

ALTER TABLE invoice_date DROP COLUMN Invoice_Date;
ALTER TABLE supermarket_sales CHANGE COLUMN New_Date Date DATE;


DESCRIBE invoice_date;
SELECT *
FROM invoice_date;
SELECT *
FROM addidas
WHERE Retailer IS NULL OR
	  Retailer_ID IS NULL OR
      Invoice_Date IS NULL OR
      Region IS NULL OR
      State IS NULL OR
      City IS NULL OR
      Product IS NULL OR
      Price_per_Unit IS NULL OR
      Units_Sold IS NULL OR
      Total_Sales IS NULL OR 
      Operating_Profit IS NULL OR
      Operating_Margin IS NULL OR
      Sales_Method IS NULL ;

SELECT * 
FROM addidas;

/* Number of retailer */

SELECT DISTINCT retailer 
FROM addidas;

/* total sales and profit */

SELECT SUM(Total_Sales) AS total_sales,
	   SUM(Operating_Profit) AS total_profit
FROM addidas;
/* total sales per quarter */

SELECT 
	 YEAR(j.New_Date) as Year,
     QUARTER(j.New_Date) AS Quarter,
     SUM(i.total_sales) AS total_sales
FROM addidas AS i
inner join invoice_date AS j 
ON i.retailer_ID = j.retailer_ID
GROUP BY  YEAR(j.New_Date),QUARTER(j.New_Date)
ORDER BY 1,2;

/* total sales per year */

SELECT 
	YEAR(j.new_date) AS year,
    SUM(i.total_sales) AS total_sales_per_year,
    SUM(i.Operating_Profit) total_profit_per_year
FROM addidas AS i
INNER JOIN invoice_date AS J
      ON i.retailer_ID = J.retailer_ID
GROUP BY YEAR(j.new_date)
ORDER BY YEAR DESC;

/* Retailer total sales and profit*/

SELECT Retailer,
	   SUM(Total_Sales) AS total_sales_per_retailer,
       SUM(Operating_Profit) AS total_profit_per_retailer
FROM addidas 
GROUP BY retailer
ORDER BY total_sales_per_retailer DESC;

/* total sales per region */
SELECT Region,
	   SUM(Total_Sales) AS total_sales_per_retailer
FROM addidas 
GROUP BY Region
ORDER BY total_sales_per_retailer DESC;

/* Which Products Have the Highest Sales Volume? */
SELECT 
	product,
    (ROUND(SUM(units_sold),2) / Count(*)) * 100 AS total_Volume_solved
FROM addidas 
GROUP BY product
ORDER BY total_Volume_solved DESC;

/* Which Sales Methods Are Most Popular? */
SELECT 
	(SUM(Sales_Method = 'In-store') / COUNT(*)) * 100 as In_Store_Methods_percentage,
	(SUM(Sales_Method = 'Outlet') / COUNT(*)) * 100 as Outlet_Methods_percentage,
	(SUM(Sales_Method = 'Online') / COUNT(*)) * 100 as Online_Methods_percentage
FROM addidas;


/* Can you identify any regional patterns in payment method usage? */
SELECT Region,
	(SUM(Sales_Method = 'In-store') / COUNT(*)) * 100 as In_Store_Methods_percentage,
	(SUM(Sales_Method = 'Outlet') / COUNT(*)) * 100 as Outlet_Methods_percentage,
	(SUM(Sales_Method = 'Online') / COUNT(*)) * 100 as Online_Methods_percentage
FROM addidas
GROUP BY Region;


SELECT *
FROM addidas AS a
INNER JOIN invoice_date AS d
ON a.retailer_ID = d.retailer_ID;