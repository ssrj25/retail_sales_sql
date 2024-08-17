-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

USE sql_project_p2;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
	transaction_id INT PRIMARY KEY,
	sale_date DATE,
    sale_time TIME,
	customer_id  INT,
	gender VARCHAR(15),
	age INT,
    caretail_salestegory VARCHAR(15),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
	);
  
  
  SELECT * FROM  retail_sales
  LIMIT 10;
  
  SELECT 
	count(*) 
 FROM retail_sales;
 
  SELECT * FROM  retail_sales
 WHERE transaction_id IS NULL;
 
  SELECT * FROM  retail_sales
 WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL
    OR customer_id IS NULL;
    
DELETE FROM retail_sales
WHERE
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL
    OR customer_id IS NULL;

-- Data Exploration

-- How many sales we have?
SELECT count(*) AS total_sale FROM retail_sales;

-- How many customer we have?

SELECT count(DISTINCT customer_id) AS total_sale FROM retail_sales;

SELECT DISTINCT category AS total_sale FROM retail_sales;

-- Data Analysis & Business Key Problem & Answers

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantity >= 4;

  
-- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;


-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY 
    category;
    
-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
) AS avg_sales
WHERE avg_sale = (
    SELECT MAX(avg_sale)
    FROM (
        SELECT 
            EXTRACT(YEAR FROM sale_date) AS year,
            EXTRACT(MONTH FROM sale_date) AS month,
            AVG(total_sale) AS avg_sale
        FROM retail_sales
        GROUP BY year, month
    ) AS monthly_sales
    WHERE monthly_sales.year = avg_sales.year
);


-- **Write a SQL query to find the top 5 customers based on the highest total sales **:


SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category
ORDER BY cnt_unique_cs DESC;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;








  
  










  
  


