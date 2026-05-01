USE sample_sales;
-- comment Territory (South Carolina) 
-- comment Region (South) 
-- comment Manager (Len Jensen)

-- COMMENT 1. Total revenue + date range(South carolina)
SELECT
    SUM(SalesTotal) AS total_revenue,
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM sample_sales.online_sales
WHERE ShiptoState = 'South Carolina';


-- comment 2. Monthly revenue breakdown
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS month,
    SUM(SalesTotal) AS monthly_revenue
FROM sample_sales.online_sales
WHERE ShiptoState = 'South Carolina'
GROUP BY month
ORDER BY month;

-- comment  3: Compare South Carolina vs South region
SELECT
    m.Region,
    os.ShiptoState,
    SUM(os.SalesTotal) AS total_revenue
FROM sample_sales.online_sales os
JOIN sample_sales.management m
    ON os.ShiptoState = m.State
WHERE m.Region = (
    SELECT Region
    FROM sample_sales.management
    WHERE State = 'South Carolina'
)
GROUP BY m.Region, os.ShiptoState
ORDER BY total_revenue DESC;


SELECT * FROM management;

-- comment 4. Transactions and avg size by category
SELECT
    DATE_FORMAT(os.Date, '%Y-%m') AS month,
    ic.Category,
    COUNT(*) AS total_transactions,
    AVG(os.SalesTotal) AS avg_transaction_size
FROM sample_sales.online_sales os
JOIN sample_sales.products p
    ON os.ProdNum = p.ProdNum
JOIN sample_sales.inventory_categories ic
    ON p.CategoryId = ic.CategoryId
WHERE os.ShiptoState = 'South Carolina'
GROUP BY month, ic.Category
ORDER BY month, ic.Category;

--  comment 5. Rank states by revenue (South region)
SELECT
    os.ShiptoState,
    SUM(os.SalesTotal) AS total_revenue
FROM sample_sales.online_sales os
JOIN sample_sales.management m
    ON os.ShiptoState = m.State
WHERE m.Region = (
    SELECT Region
    FROM sample_sales.management
    WHERE State = 'South Carolina'
)
GROUP BY os.ShiptoState
ORDER BY total_revenue DESC;

-- comment 6. Recommendation:
-- Based on the analysis of South Carolina’s online sales, I recommend focusing next quarter on:
-- (1) Strengthening high-performing product categories that show consistent monthly revenue.
-- (2) Targeting marketing efforts toward states in the same region that generate strong revenue.
-- (3) Improving conversion in lower-performing months by running seasonal promotions.

-- comment Why?
-- The data shows clear monthly revenue patterns, strong category performance in specific segments,
-- and opportunities to grow sales by leveraging regional demand trends.













 
	








