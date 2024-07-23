--created the table


CREATE TABLE supermarket_sales
(
    Invoice_ID VARCHAR2(20),
    Branch VARCHAR2(50),
    City VARCHAR2(50),
    Customer_type VARCHAR2(20),  
    Gender VARCHAR2(20),          
    Product_line VARCHAR2(50),
    Unit_price NUMBER,           
    Quantity NUMBER,
    Tax5 NUMBER,                 
    Total NUMBER,
    Sale_Date DATE,               
    Sale_Time TIMESTAMP,         
    Payment VARCHAR2(50),         
    COGS NUMBER,                 
    Gross_margin_pct NUMBER,      
    Gross_income NUMBER,
    Rating NUMBER
);


--Confirming if table is created

SELECT *
FROM supermarket_sales

--Data is imported using Oracle SQL Developer

--Checking for nulls
SELECT *
FROM supermarket_sales
WHERE invoice_id IS NULL;

--Checking for duplicates

SELECT 
    invoice_id,
    COUNT(*) AS cnt
FROM 
    supermarket_sales
GROUP BY 
    invoice_id
HAVING 
    COUNT(*) > 1;


--Total Sales by Branch and City


SELECT 
    branch,
    city,
    SUM(total) AS total_sales
FROM 
    supermarket_sales
GROUP BY 
    branch, city
ORDER BY 
    total_sales DESC;
    
    
--Average Gross Margin Percentage by Product Line


SELECT 
    product_line,
    AVG(gross_margin_pct) AS avg_margin
FROM 
    supermarket_sales
GROUP BY 
    product_line
ORDER BY 
    avg_margin DESC;
    
    
--Top 5 Products by Sales Quantity

SELECT *
FROM (
    SELECT 
        product_line,
        unit_price,
        SUM(quantity) AS total_quantity
    FROM 
        supermarket_sales
    GROUP BY 
        product_line, unit_price
    ORDER BY 
        total_quantity DESC
) 
WHERE ROWNUM <= 5;



--Customer Type Distribution and Average Total Spent

SELECT 
    customer_type,
    COUNT(invoice_id) AS num_invoices,
    AVG(total) AS avg_spent
FROM 
    supermarket_sales
GROUP BY 
    customer_type
ORDER BY 
    avg_spent DESC;
    
--Sales Trend Over Time (Monthly)


SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS month,
    SUM(total) AS monthly_sales
FROM 
    supermarket_sales
GROUP BY 
    TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY 
    month;

    
--Payment Method Analysis


SELECT 
    payment,
    COUNT(invoice_id) AS num_transactions,
    SUM(total) AS total_sales
FROM 
    supermarket_sales
GROUP BY 
    payment
ORDER BY 
    total_sales DESC;
    
    
--Correlation Between Rating and Gross Income


SELECT 
    rating,
    AVG(gross_income) AS avg_gross_income
FROM 
    supermarket_sales
GROUP BY 
    rating
ORDER BY 
    rating;

--Average Unit Price and Quantity by Product Line


SELECT 
    product_line,
    AVG(unit_price) AS avg_unit_price,
    AVG(quantity) AS avg_quantity
FROM 
    supermarket_sales
GROUP BY 
    product_line
ORDER BY 
    avg_unit_price DESC;