USE sample_sales;
-- comment 1.Create a list of all transactions that took place on January 15, 2024,
   sorted by sale amount from highest to lowest.
   (South Carolina only)

SELECT 
    ss.Transaction_Date,
    ss.Store_ID,
    ss.Prod_Num,
    ss.Sale_Amount
FROM sample_sales.Store_Sales ss
JOIN sample_sales.store_locations sl
    ON ss.Store_ID = sl.StoreID
WHERE ss.Transaction_Date = '2024-01-15'
  AND sl.StoreLocation = 'South Carolina'
ORDER BY ss.Sale_Amount DESC;

-- comment 2.Which transactions had a sale amount greater than $500?
   Display the transaction date, store ID, product number, and sale amount.
   (South Carolina only)

SELECT 
    Transaction_Date,
    Store_ID,
    Prod_Num,
    Sale_Amount
FROM Store_Sales
WHERE Sale_Amount > 500
ORDER BY Sale_Amount DESC;

-- comment4. Total revenue + average transaction amount (South Carolina) */

SELECT
    SUM(SalesTotal) AS total_revenue,
    AVG(SalesTotal) AS avg_transaction_amount
FROM sample_sales.online_sales
WHERE ShipToState = 'South Carolina';

 -- comment 6. Highest and lowest revenue by state (online sales) */

SELECT
    ShipToState,
    SUM(SalesTotal) AS total_revenue
FROM sample_sales.online_sales
GROUP BY ShipToState
ORDER BY total_revenue DESC;

-- comment 8. States with revenue above $50,000 (online sales) */

SELECT
    ShipToState,
    SUM(SalesTotal) AS total_revenue
FROM sample_sales.online_sales
GROUP BY ShipToState
HAVING SUM(SalesTotal) > 50000
ORDER BY total_revenue DESC;

-- comment 13. Total sales by region. Which region generates the most revenue? 

SELECT
    m.Region,
    SUM(ss.Sale_Amount) AS total_revenue
FROM sample_sales.store_sales ss
JOIN sample_sales.store_locations sl
    ON ss.Store_ID = sl.StoreID
JOIN sample_sales.management m
    ON sl.StoreLocation = m.State
GROUP BY m.Region
ORDER BY total_revenue DESC;

-- comment 16. Display total revenue by regional director 

SELECT
    m.RegionalDirector,
    SUM(ss.Sale_Amount) AS total_revenue
FROM sample_sales.store_sales ss
JOIN sample_sales.store_locations sl
    ON ss.Store_ID = sl.StoreID
JOIN sample_sales.management m
    ON sl.StoreLocation = m.State
GROUP BY m.RegionalDirector
ORDER BY total_revenue DESC;










