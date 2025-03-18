
CREATE TABLE BOOK (  
    Book_id INT PRIMARY KEY,
    Title VARCHAR(255),
    Publisher_Name VARCHAR(255),
    Pub_Year YEAR );

CREATE TABLE BOOK_AUTHORS ( 
    Book_id INT REFERENCES BOOK(Book_id) ON DELETE CASCADE,  
    Author_Name VARCHAR(255), 
    PRIMARY KEY (Book_id, Author_Name) );

CREATE TABLE LIBRARY_BRANCH ( Branch_id INT PRIMARY KEY, 
Branch_Name VARCHAR(255),  
Address VARCHAR(255) );

CREATE TABLE BOOK_COPIES ( Book_id INT REFERENCES BOOK(Book_id) ON DELETE CASCADE ,
 Branch_id INT REFERENCES LIBRARY_BRANCH(Branch_id) ON DELETE CASCADE ,
   No_of_Copies INT,
    PRIMARY KEY (Book_id, Branch_id));

CREATE TABLE PUBLISHER  ( Pub_id INT PRIMARY KEY,
 Name VARCHAR(255),
  Address VARCHAR(255),
   Phone VARCHAR(15) );

CREATE TABLE BOOK_LENDING ( Book_id INT REFERENCES BOOK(Book_id) ON DELETE CASCADE 
, Branch_id INT REFERENCES LIBRARY_BRANCH(Branch_id) ON DELETE CASCADE ,
    Card_No INT,
    Date_Out DATE,
    Due_Date DATE,
    PRIMARY KEY (Book_id, Branch_id, Card_No) );

INSERT INTO BOOK VALUES
(1, 'The Guide', 'Indian Publishers', 1958),
(2, 'Malgudi Days', 'Penguin India', 1982),
(3, 'Train to Pakistan', 'Rupa & Co', 1956),
(4, 'God of Small Things', 'India Ink', 1997),
(5, 'Wings of Fire', 'Universities Press', 1999),
(6, 'The Discovery of India', 'Oxford India', 1946),
(7, 'Midnight’s Children', 'Jonathan Cape', 1981),
(8, 'The White Tiger', 'HarperCollins', 2008),
(9, 'A Suitable Boy', 'Penguin India', 2003);

INSERT INTO BOOK_AUTHORS VALUES
(1, 'R.K. Narayan'),
(2, 'R.K. Narayan'),
(3, 'Khushwant Singh'),
(4, 'Arundhati Roy'),
(5, 'A.P.J. Abdul Kalam'),
(6, 'Jawaharlal Nehru'),
(7, 'Salman Rushdie'),
(8, 'Aravind Adiga'),
(9, 'Vikram Seth');

INSERT INTO LIBRARY_BRANCH VALUES
(1, 'Delhi Public Library', 'Connaught Place, Delhi'),
(2, 'Bangalore City Library', 'MG Road, Bangalore');

INSERT INTO BOOK_COPIES VALUES
(1, 1, 5),
(2, 1, 3),
(3, 1, 2),
(4, 1, 6),
(5, 2, 4),
(6, 2, 3),
(7, 2, 2),
(8, 2, 5);

INSERT INTO PUBLISHER VALUES
 (1, 'Penguin India', 'Delhi', '9876543210'), 
(2, 'Vintage', 'Mumbai', '9876543220'),
 (3, 'HarperCollins', 'Chennai', '9876543230'),
 (4, 'Roli Books', 'Kolkata', '9876543240'),
 (5, 'IndiaInk', 'Bangalore', '9876543250'), 
(6, 'Mariner Books', 'Hyderabad', '9876543260'), 
(7, 'Penguin India', 'Pune', '9876543270'), 
(8, 'Universities Press', 'Ahmedabad', '9876543280');

INSERT INTO BOOK_LENDING VALUES
(1, 1, 101, '2019-01-05', '2019-01-20'),
(2, 1, 101, '2019-02-10', '2019-02-25'),
(3, 1, 101, '2019-03-15', '2019-03-30'),
(4, 1, 101, '2019-04-20', '2019-05-05'), 
(5, 2, 102, '2019-02-12', '2019-02-27'),
(6, 2, 102, '2019-03-20', '2019-04-04'),
(7, 2, 102, '2019-04-25', '2019-05-10'); 

SELECT B.Book_id, B.Title, B.Publisher_Name, B.Pub_Year, BA.Author_Name, BC.No_of_Copies FROM BOOK B JOIN BOOK_AUTHORS BA ON B.Book_id = BA.Book_id JOIN BOOK_COPIES BC ON B.Book_id = BC.Book_id;
SELECT Card_No, COUNT(Book_id) AS Total_Books FROM BOOK_LENDING WHERE Date_Out BETWEEN '2019-01-01' AND '2019-06-30' GROUP BY Card_No HAVING COUNT(Book_id) > 3;

DELETE FROM BOOK WHERE Book_id = 3;

SELECT * FROM BOOK;
SELECT Pub_Year, GROUP_CONCAT(Publisher_Name SEPARATOR ',') AS Publishers
FROM BOOK
GROUP BY Pub_Year;

CREATE VIEW BOOK_AVAILABILITY AS SELECT B.Title, C.No_Of_Copies FROM BOOK B, BOOK_COPIES C WHERE B.Book_Id = C.Book_Id;

SELECT *FROM BOOK_AVAILABILITY;





