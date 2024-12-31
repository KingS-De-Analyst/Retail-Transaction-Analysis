# Online Retail Transactions Aalysis

## Overview
This project analyzes an **Online Retail Transactions Dataset** to uncover insights that can guide business decisions. This is a dataset of a UK-based and registered, non-store online retail, the company mainly sells unique all-occasion gift-ware. The dataset includes transaction details, customer demographics, and feedback information, providing a comprehensive view of the retail environment.

Sql queries? Check them out here: [sql_queries folder](/retail_data_analysis/sql_queries/)

## Dataset
- **Source**: Kaggle
- **Features** The dataset consists of three tables
    1. **Customers Table**
        - **Columns :** 'customer_id', 'name', 'email', 'city', 'state', 'country', 'age', 'gender', 'income', 'customer_type'
    2. **Transactions Table**
        - **Columns :** 'transaction_id', 'customer_id', 'product', 'p_category, 'p_brand', 'p_type', 'date', 'quantity', 'unit_price', 'shipping', 'payment_method', 'order_status'
    3. **Feedback Table**
        - **Columns :** 'transaction_id', 'feedback', 'ratings'

## Objectives
The key goals of this analysis are :
- To understand customer purchasing patterns.
- To identify top-performing products and geographic trends.
- To evaluate the impact of feedback sentiment and payment methods on sales.
## The questions I wanted to anwser through my sql queries were:
1. - Which customers are the top sepender?
    - Which countries have the highest number of customers and revenue?
2. What are the top-performing products based on sales volume and revenue?
3. Which countries generate the most revenue for the business?

4. How do product sales differ across countries?
5. - How does the payment method impact customer feedback sentiment?
    - What is the distribution of transactions across different payment methods?

## Tools and Technologies
For my deep dive into the retail transactions analysis, I harnessed the power of several key tools:

- **Excel :** For data cleaning and preparation.
- **SQL :** The backbone of my analysis, allowing me to query the databse and unearth critical insights.
- **PostgresSQL :** The chosen database management system, ideal for handling the retail transactions data.
- **pgAdmin & Visual Studio Code :** My go-to for database management and query execution and analysis.
- **Git & Github :** Essential for version control and collaboration and project tracking.
## The Analysis
Each query for this project is aimed at investigating specific aspects of the retail transactions.
Here is how I approached each question:

### 1. Top Spenders
To identify the top spenders, I calculated the sum spent by each customer through their unique customer id. This query highlights the top spenders.

- **Query for the list of the top spenders.**

```sql
SELECT c.customer_id, c.name, c.email,
    SUM(t.unit_price * t.quantity) AS total_spent
FROM transactions AS t
JOIN customers AS c ON c.customer_id = t.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;
```

- **Query for the list of the top spenders with their spending percentage.**

```sql
WITH customer_totals AS (
    SELECT c.customer_id, c.name, c.email,
    SUM(t.unit_price * t.quantity) AS total_spent
    FROM transactions AS t
    JOIN customers AS  c ON c.customer_id = t.customer_id
GROUP BY c.customer_id
),
max_spent AS (
    SELECT MAX( total_spent) AS highest_spent
    FROM customer_totals
)
SELECT ct.customer_id, ct.name, ct.email, ct.total_spent, (ct.total_spent * 100.0 / ms.highest_spent) AS percentage_of_highest
FROM customer_totals AS ct
CROSS JOIN max_spent AS ms
ORDER BY ct.total_spent DESC;
```

Here we are looking to identify high-value customers (top spenders) based on purchase frequency or spending for targeted marketing
because understanding high-value customers is a priority for marketing and customer relationship management.
This analysis gives us the list of top spenders, their spending percentage, and sort them by the amount spent.


### 2. Product Trend
I ran some analysis here to know the products that are most popular to the customers by calculating how many times they were bought anad how much we generated from them.

- **Query for the top-performing products based on sales revenue**
```sql
SELECT product,
    SUM(unit_price * quantity) AS total_revenue,
    SUM(quantity) AS total_sold
FROM transactions
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 10;
```
This query is to know the total amount of sales for each product in addition to their revenue.
I calculated the total revenue for each product and sorted the products by their revenue.
I am listing the top 50 in this case where we have Huawei leading as the product with the highest revenue.

- **Query for the top performing products based on quantity sold**
```sql
SELECT product,
    COUNT(*) AS times_bought,
    SUM(quantity) AS total_quantity_sold
FROM transactions
GROUP BY product
ORDER BY times_bought DESC
LIMIT 50;
```
After this analysis I was able to ientify the number of transactions for the product and the total quantity sold. This reveals the top 50 selling products, where we have iphone leading the race with Huawei P following it.

### 3. Geographic Trend
- **Query for the countries that generate the most revenue for the business**

This query gives us the insight for revenue by country for market focus.
```sql
SELECT c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country
ORDER BY total_revenue DESC;
```
This queery gives us update on the countries with regards to the their perfomances based on revenue. To identify these countries, I calculated the total revenue and grouped it by the countries. This shows that USA is leading as sales to USA generates the most revenue.

- **Query for the list of countries with the highest number of customers and purchases**
```sql

SELECT c.country,
    SUM(t.quantity) AS total_purchases,
    COUNT(DISTINCT t.customer_id) AS unique_customers
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_purchases DESC;
```

My analysis gives us an insight into countries that contribute the most sales or have the highest number of unique customers. It shows us that USA is the country with the highest number of unique customers and number of purchases.

- **Query for the cities that generate the most revenue for the business**

This query gives us the insight for revenue by country, state and city for market focus.
```sql
SELECT c.city, c.state, c.country,
    SUM(t.unit_price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY country, state, city
ORDER BY total_revenue DESC;
```
This query gives us more insight on the performances on cities based on revenue, and giving the details of the state and coutry. This shows us that on city level 2 cities from Australia are leading.

### 4. Sales Trend
- **Query on how product sales differ across countries**
```sql
SELECT CONCAT(t.product, ' / ', t.p_brand) AS product_n_brand, c.country,
    SUM(t.quantity) AS total_sold
FROM transactions AS t
JOIN customers AS c ON t.customer_id = c.customer_id
GROUP BY c.country, t.product, t.p_brand
ORDER BY total_sold DESC;
```
My analysis here is to showcase the best-selling products in each coutry, so as to enable localized marketing strategies. To get this, I calculated the amount of sales for each product and grouped them by country, product and product brand.

### 5. Feedback and Payment Method Trend
- **Query on how the payment method impact customer feedback sentiment**

My analysis on this level is to provide insight into customer payment preferences.

```sql
SELECT t.payment_method,
    COUNT(f.transaction_id) AS feedback_count,
    AVG(f.ratings) AS avg_rating
FROM feedback AS f
JOIN transactions AS t ON f.transaction_id = t.transaction_id
GROUP BY t.payment_method
```
 After my analysis on this I was able to discover that we do not have much difference on the rate of feedback on all the payment methods as the difference on the averages is not been up to 1.
 To identify this trend, I had to calculate and find out the average of the feedback and filtered it through the transaction id of each transaction to get the payment method for each feedback, and grouped them by the payment method.

 - **Query for Transaction distribution by payment method**

This is to find out the payment method that was used the most by customer and also to check the revenue generated by each payment method.

```sql
SELECT payment_method,
    count(*) AS transaction_count,
    SUM(unit_price * quantity) AS total_revenue
FROM transactions
GROUP BY payment_method
ORDER BY total_revenue DESC;
```

According to my analysis Credit Card is topping the list which indicates a seamless payment process, so it would best to ensure that this option is always available. Next to it is Debit Card which is behind Credit Card with just 4 transactions and around 11,089.499 in terms of revenue.

## Business Impact
The findngs would help optimize product offerigs, focus marketing on high-performing regions, and improve customer experience based on feedback.

## What I  Learned
Through this project, I gained valuable skills and insights, including:

1. **Data Cleaning And Preparation**: This project helped me harness this skill as I Identified and addressed missing, duplicate and inconsistent data.
2. **SQL Querying**: I used advanced SQL techniques such as joins, subqueries and aggregate functions to analyze data effectively.
3. **Insight Generation**: Through this project, I was able to translate raw data into actionable insights that could guide business decisions.
4. **Critical Thinking**: I explored different perspectives for analysis, such as customer demographics, product trends and payment preferences.
5. **Visualization Planning**: I designed queries to support potential visualizations, such as bar charts for top products or pie charts for geographic sales distribution.

These experineces have enhanced my ability to work with real-world datasets and address business needs with data-driven solutions.
## Conclusion
This project demotrates:
- The ability to extract actionable insights from raw data.
- The use of data-driven strategies to improve product offerings, customer satisfaction and operational efficiency.

By leveraging SQL and EXCEL effectively, this project highlights critical data analytics skills very necessary for solving real-world business problems.