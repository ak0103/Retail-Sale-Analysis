DROP TABLE IF EXISTS retail_sales;
CREATE  TABLE retail_sales

  (
     transactions_id INT,
	 sale_date	DATE,
	 sale_time  TIME,
	 customer_id INT,
	 gender	 TEXT,  
	 age	 INT,
	 category VARCHAR(20),
	 quantiy  INT,	
	 price_per_unit	 FLOAT,
	 cogs	FLOAT,
	 total_sale FLOAT
  );  
SET search_path TO public;
SELECT * FROM retail_sales



select * from Public.retail_sales
SET search_path TO public;

ALTER TABLE retail_sales RENAME COLUMN quantiy TO quantity;


-- DATA CLEANING 

select * from retail_sales
WHERE
	age IS NULL
     OR
	category IS NULL
     or
    quantity IS NULL
     or
     price_per_unit IS NULL
     or
     cogs IS NULL
     or
     total_sale IS NULL



DELETE  FROM retail_sales
WHERE
	age IS NULL
     OR
	category IS NULL
     or
    quantity IS NULL
     or
     price_per_unit IS NULL
     or
     cogs IS NULL
     or
     total_sale IS NULL


-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS total_sales FROM retail_sales

-- HOW MANY CUSTOMER DO WE HAVE?

SELECT COUNT(DISTINCT customer_id) AS total_sales 
FROM retail_sales

-- DISTINCT CATEGORY

SELECT DISTINCT category FROM retail_sales

-- DATA ANALYSIS & BUISNESS KEY PROBLEMS & ANSWERS

-- Q. 1 Write a SQL query to retrieve all columns for sales made on 2022-11-05?
   
    SELECT * FROM retail_sales
    WHERE sale_date = '2022-11-05';
--Q. 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of 'Nov - 2022'?

     SELECT * FROM retail_sales
     WHERE category = 'Clothing'
     AND
     TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
     AND 
     quantity >= 4;

--Q. 3 Write a SQL query to calculate the (total_sale) for each category?

     SELECT category, SUM(total_sale) AS net_sale,
        COUNT(*) AS total_orders 
     FROM retail_sales
     GROUP BY category;

-- Q. 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

      SELECT ROUND(AVG(age),2) AS avg_age
      FROM retail_sales
      WHERE category = 'Beauty'

-- Q. 5 Write a SQL query to find all transactions where the total_sale is greater than 1000?

       SELECT * FROM retail_sales
       WHERE total_sale > 1000

-- Q. 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?

      SELECT category, gender, COUNT(*) AS total_trnsaction
      FROM retail_sales
      GROUP BY  category, gender
      ORDER BY category

--Q. 7  Write a SQL query to calculate the aveage sale for each month. Find out best selling month in each year?

       SELECT year,month,avg_sale
       FROM
          (
		    SELECT
		         EXTRACT(YEAR FROM sale_date) as year,
                 EXTRACT(MONTH FROM sale_date) as month,
                 AVG(total_sale) AS avg_sale,
                 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
		         FROM retail_sales
		         GROUP BY year, month
		  ) as t1
          WHERE rank = 1


--Q. 8 Write a SQL query to find the top 5 customers based on the highest total sales?

        SELECT customer_id,SUM(total_sale) AS total_sales
        FROM retail_sales
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 5


--Q. 9 Write a SQL query to find the number of unique customers who purchased items from each category?

       SELECT category,COUNT(DISTINCT customer_id) AS unique_cst
       FROM retail_sales
       GROUP BY category


--Q. 10 Write a SQL query to create each shift and number of orders?

        WITH hourly_sale
        AS
        (
         SELECT *,
		   CASE
		      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND  17 THEN 'Afternoon'
		      ELSE 'Evening'
		   END AS shift
		 FROM retail_sales
		 )  
			 SELECT shift, COUNT(*) AS total_orders  
		 	FROM hourly_sale   
		 	GROUP BY shift 

--  End of Project		  
		  



		  
		
        
      
      