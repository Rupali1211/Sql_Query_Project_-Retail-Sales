--Sql Retail sales Analysis--

--CREATE TABLE---
DROP TABLE IF EXISTS Retail_sales;
CREATE TABLE Retail_Sales
 (
   transactions_id INT PRIMARY KEY,
   sale_date DATE,	
   sale_time TIME,	
   customer_id	INT,
   gender VARCHAR(10),	
   age	INT,
   category	 VARCHAR(15),
   quantiy	INT,
   price_per_unit FLOAT,	
   cogs	 FLOAT,
   total_sale FLOAT
);
SELECT * FROM Retail_Sales
LIMIT 10;

--Data Cleaning--
SELECT Count (*) 
From retail_sales;

SELECT * FROM Retail_Sales
WHERE 
   transactions_id IS NULL
   OR
   Sale_date IS NULL
   OR
   Sale_time IS NULL
   OR
   Customer_id IS NULL
   OR
   gender IS NULL
   OR
   age IS NULL
   OR
   Category IS NULL
   OR
   quantiy IS NULL
   OR
   price_per_unit IS NULL
   OR
   cogs IS NULL
   OR
   total_sale IS NULL;
   
DELETE FROM Retail_Sales
WHERE 
   transactions_id IS NULL
   OR
   Sale_date IS NULL
   OR
   Sale_time IS NULL
   OR
   Customer_id IS NULL
   OR
   gender IS NULL
   OR
   age IS NULL
   OR
   Category IS NULL
   OR
   quantiy IS NULL
   OR
   price_per_unit IS NULL
   OR
   cogs IS NULL
   OR
   total_sale IS NULL;

--Data Exploration

--How many Sales  we have?
SELECT COUNT(*) as total_sale FROM retail_sales
   
--How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

--How many unique category we have?
SELECT DISTINCT category From retail_sales



-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales 
WHERE sale_date = '2022-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE 
Category ='Clothing'
AND
quantiy >=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
category,
Sum (total_sale) as net_sale,
Count(*) as total_orders
FROM retail_sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
Round (avg(age),2) as avg_age
FROM retail_sales
WHERE category ='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >= 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
   Category,
   gender,
Count(*) as total_trans
From retail_sales
GROUP BY
   Category,
   gender
Order By 1  

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
    Year,
	Month,
	avg_sale
From
(
SELECT
   EXTRACT (year from sale_date) as year,
   EXTRACT (month from sale_date) as month,
   Avg(total_sale) as avg_sale,
   Rank() OVER (partition By Extract(year From sale_date) Order By Avg(Total_sale) DESC) as rank
From retail_sales
Group By 1,2
) as t1
WHERE rank =1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
  Customer_id,
  Sum(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
  
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
  Category,
  Count(Distinct customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY Category
  
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
as
(
SELECT * ,
CASE 
  WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Mornng'
  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END as shift
FROM retail_sales
)
SELECT 
 shift,
 Count (*) as Total_orders
 FROM hourly_sale
 GROUP BY Shift 

----END  OF PROJECT-----








