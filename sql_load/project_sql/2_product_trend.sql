/*
 Popular products to stock more.
 We will the analysis here to know the products that are most popular to the customers by calculating how many times they were bought

    This query is to know the total amount of sales for each product in addition to their revenue.
    So it calculates the total revenue for each product and sorts products by their revenue in descending order
*/
SELECT product,
    SUM(unit_price * quantity) AS total_revenue,
    SUM(quantity) AS total_sold
FROM transactions
GROUP BY produCt
ORDER BY total_revenue DESC
--LIMIT 10;


/*
    The number of transactions for the product and the total quantity sold
*/
SELECT product,
    COUNT(*) AS times_bought,
    SUM(quantity) AS total_quantity_sold
FROM transactions
GROUP BY produCt
ORDER BY times_bought DESC