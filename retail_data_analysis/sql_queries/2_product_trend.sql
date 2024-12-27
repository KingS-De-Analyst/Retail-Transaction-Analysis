--What are the top-performing products based on sales volume?

SELECT product,
    SUM(unit_price * quantity) AS total_revenue,
    SUM(quantity) AS total_sold
FROM transactions
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 10;

/* I ran the analysis here to know the products that are most popular to the customers by calculating 
 how many times they were bought anad how much wengenerate from them

    This query is to know the total amount of sales for each product in addition to their revenue.
    So it calculates the total revenue for each product and sorts products by their revenue.
    I am listing the top 10 in this case where we have Huawei leading as the product with the highest revenue.
*/


SELECT product,
    COUNT(*) AS times_bought,
    SUM(quantity) AS total_quantity_sold
FROM transactions
GROUP BY product
ORDER BY times_bought DESC
LIMIT 10;

/*
    After this analysis I was able to ientify the number of transactions for the product and the total quantity sold.
    This reveals the top 10 selling products, where we have iphone leading the race with Huawei P following it.
*/