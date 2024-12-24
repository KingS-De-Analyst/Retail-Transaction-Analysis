-- Creating the Customers Table
CREATE TABLE customers (
	customer_id INTEGER PRIMARY KEY,
	name VARCHAR (100),
	email VARCHAR (100),
	city VARCHAR (50),
	state VARCHAR (50),
	country VARCHAR (50),
	age INTEGER,
	gender VARCHAR (10),
	income VARCHAR (50),
	customer_type VARCHAR (50)
);

-- Creating the Table for Transactions
CREATE TABLE transactions (
	transaction_id INTEGER PRIMARY KEY,
	customer_id INTEGER,
	product VARCHAR (100),
	p_category VARCHAR (50),
	p_brand VARCHAR (50),
	p_type VARCHAR (50),
	date DATE,
	purchase INTEGER,
	amount DECIMAL (15, 3),
	shipping VARCHAR (50),
    payment_mehtod VARCHAR(50),
	order_status VARCHAR (50),
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Creating the Feedback Table
CREATE TABLE sql_project.feedback (
	transaction_id INTEGER
REFERENCES sql_project.transactions(transaction_id) ON DELETE CASCADE,
	feedback TEXT,
	ratings INTEGER CHECK
	(ratings >= 1 AND ratings <= 5),
	PRIMARY KEY (transaction_id)
); 

SELECT * FROM customers;

SELECT * FROM transactions;

SELECT * FROM feedback;