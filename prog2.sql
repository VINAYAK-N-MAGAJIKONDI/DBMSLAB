CREATE TABLE SALESMAN ( Salesman_id INT PRIMARY KEY, Name VARCHAR(50), City VARCHAR(50), Commission DECIMAL(5,2) );
CREATE TABLE CUSTOMER ( Customer_id INT PRIMARY KEY, Cust_Name VARCHAR(50), City VARCHAR(50), Grade INT, Salesman_id INT REFERENCES SALESMAN(Salesman_id) ON DELETE CASCADE );
CREATE TABLE ORDERS ( Ord_No INT PRIMARY KEY, Purchase_Amt DECIMAL(10,2), Ord_Date DATE,  Customer_id INT REFERENCES CUSTOMER(Customer_id) ON DELETE CASCADE,  Salesman_id INT REFERENCES SALESMAN(Salesman_id) ON DELETE CASCADE );

INSERT INTO SALESMAN VALUES
(1000, 'Raj', 'Bangalore', 10.50),
(1001, 'Amit', 'Delhi', 12.00),
(1002, 'Suresh', 'Mumbai', 15.00),
(1003, 'Ravi', 'Bangalore', 9.00),
(1004, 'Sunil', 'Chennai', 11.00),
(1005, 'Arun', 'Delhi', 10.00);
INSERT INTO CUSTOMER VALUES
(2001, 'John', 'Bangalore', 8, 1000),
(2002, 'Mike', 'Bangalore', 9, 1000),
(2003, 'Rahul', 'Delhi', 6, 1001),
(2004, 'Anjali', 'Mumbai', 7, 1002),
(2005, 'Sneha', 'Bangalore', 5, 1003),
(2006, 'David', 'Chennai', 4, 1004),
(2007, 'Krish', 'Delhi', 6, 1001),
(2008, 'Arjun', 'Bangalore', 10, 1000);
INSERT INTO ORDERS VALUES
(3001, 5000, '2024-03-10', 2001, 1000),
(3002, 7000, '2024-03-11', 2002, 1000),
(3003, 4000, '2024-03-10', 2003, 1001),
(3004, 9000, '2024-03-11', 2004, 1002),
(3005, 8500, '2024-03-12', 2005, 1003),
(3006, 6500, '2024-03-13', 2006, 1004),
(3007, 11000, '2024-03-14', 2007, 1001),
(3008, 13000, '2024-03-15', 2008, 1000);

SELECT COUNT(*) AS Count_Customers
FROM CUSTOMER
WHERE Grade > (SELECT AVG(Grade) FROM CUSTOMER WHERE City = 'Bangalore');

SELECT S.Salesman_id, S.Name, COUNT(C.Customer_id) AS Customer_Count
FROM SALESMAN S
JOIN CUSTOMER C ON S.Salesman_id = C.Salesman_id
GROUP BY S.Salesman_id, S.Name
HAVING COUNT(C.Customer_id) > 1;

SELECT S.Salesman_id, S.Name, 'Has Customers' AS Status
FROM SALESMAN S
WHERE EXISTS (SELECT 1 FROM CUSTOMER C WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City)
UNION
SELECT S.Salesman_id, S.Name, 'No Customers' AS Status
FROM SALESMAN S
WHERE NOT EXISTS (SELECT 1 FROM CUSTOMER C WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City);

CREATE VIEW TopSalesman AS
SELECT O.Ord_Date, O.Purchase_Amt, S.Name AS Salesman_Name, C.Cust_Name AS Customer_Name
FROM ORDERS O
JOIN CUSTOMER C ON O.Customer_id = C.Customer_id
JOIN SALESMAN S ON O.Salesman_id = S.Salesman_id
WHERE O.Purchase_Amt = (SELECT MAX(Purchase_Amt) FROM ORDERS WHERE Ord_Date = O.Ord_Date);

-- DELETE FROM ORDERS WHERE Salesman_id = 1000;
DELETE FROM SALESMAN WHERE Salesman_id = 1000;
-- DELETE FROM CUSTOMER WHERE Salesman_id = 1000;
SELECT * FROM SALESMAN;
SELECT * FROM CUSTOMER;

