-- Create Table
CREATE TABLE retail_sales 
            (
                transactions_id INT PRIMARY KEY,
                sale_date DATE,
                sale_time TIME,
                customer_id	INT,
                gender	VARCHAR(20),
                age	INT,
				category VARCHAR(20),
                quantiy	INT,
                price_per_unit FLOAT,	
                cogs FLOAT,
                total_sale FLOAT
           );

-- Check the data set after Import CSV file

SELECT * FROM retail_sales
LIMIT 10;

-- Count all of the data
SELECT 
    COUNT(*)
FROM retail_sales;

-- Check the Null Values individually

SELECT transactions_id FROM retail_sales
WHERE transactions_id IS NULL;

SELECT sale_date FROM retail_sales
WHERE sale_date IS NULL;

SELECT sale_time FROM retail_sales
WHERE sale_time IS NULL;

SELECT customer_id FROM retail_sales
WHERE customer_id IS NULL;

SELECT gender FROM retail_sales
WHERE gender IS NULL;

--- There are null values
SELECT age FROM retail_sales
WHERE age IS NULL;

SELECT category FROM retail_sales
WHERE category IS NULL;

--- There are null values
SELECT quantiy FROM retail_sales
WHERE quantiy IS NULL;

--- There are null values
SELECT price_per_unit FROM retail_sales
WHERE price_per_unit IS NULL;

--- There are null values
SELECT cogs FROM retail_sales
WHERE cogs IS NULL;

--- There are null values
SELECT total_sale FROM retail_sales
WHERE total_sale IS NULL;

-- Check all the columun toghter
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Delete Null Rows
DELETE FROM retail_sales
	WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
	
	
--# Data Exploration
-- How many sales we have?
SELECT COUNT (*) total_sale FROM retail_sales;

-- How many unique customer we have?
SELECT COUNT (DISTINCT 	customer_id) as total_sale FROM retail_sales;

-- How many unique category we have?
SELECT DISTINCT category as total_sale FROM retail_sales;

--# Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
*
FROM retail_sales
WHERE
    category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
     category,
	 SUM(total_sale)AS net_sale,
	 COUNT(*) AS total_order
FROM retail_sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
*
FROM retail_sales
WHERE category = 'Beauty'

SELECT 
     ROUND(AVG (age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales
WHERE total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
     category,
	 gender,
	 COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    EXTRACT (YEAR from sale_date) as year,
	EXTRACT (MONTH from sale_date) as month,
	AVG (total_sale) as avg_sales
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,2

SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
     customer_id,
	 SUM(total_sale) as total_sales	
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
	COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
     CASE
	    WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
    shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;




























