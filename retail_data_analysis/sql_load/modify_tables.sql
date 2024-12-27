/* NOTE: In the case of having issues with permissions that you get an error: 

'could not open file "[your file path]\customers.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_project` database
3. Right-click `sql_project` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy customers FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\customers.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy feedback FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\feedback.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy transactions FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\transactions.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/


COPY customers
FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\customers.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY feedback
FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\feedback.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY transactions
FROM 'C:\Users\KINGSLEY\Documents\POSTGRESQL\csv_files\transactions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
