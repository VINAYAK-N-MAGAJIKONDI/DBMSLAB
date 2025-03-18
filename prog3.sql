CREATE TABLE ACTOR ( Act_id INT PRIMARY KEY, Act_Name VARCHAR(50), Act_Gender VARCHAR(10) );
CREATE TABLE DIRECTOR ( Dir_id INT PRIMARY KEY, Dir_Name VARCHAR(50), Dir_Phone VARCHAR(15) );
CREATE TABLE MOVIES ( Mov_id INT PRIMARY KEY, Mov_Title VARCHAR(100), Mov_Year INT, Mov_Lang VARCHAR(20), Dir_id INT REFERENCES DIRECTOR(Dir_id) ON DELETE CASCADE);
CREATE TABLE MOVIE_CAST ( Act_id INT REFERENCES ACTOR(Act_id) ON DELETE CASCADE, Mov_id INT REFERENCES MOVIES(Mov_id) ON DELETE CASCADE, Role VARCHAR(50), PRIMARY KEY (Act_id, Mov_id) );
CREATE TABLE RATING ( Mov_id INT REFERENCES MOVIES(Mov_id) ON DELETE CASCADE, Rev_Stars INT );

INSERT INTO ACTOR VALUES
(1, 'Robert Downey Jr.', 'Male'),
(2, 'Scarlett Johansson', 'Female'),
(3, 'Chris Hemsworth', 'Male'),
(4, 'Leonardo DiCaprio', 'Male'),
(5, 'Emma Watson', 'Female'),
(6, 'Tom Hanks', 'Male'),
(7, 'Angelina Jolie', 'Female'),
(8, 'Brad Pitt', 'Male');
INSERT INTO DIRECTOR VALUES
(1, 'ABCD', '1234567890'),
(2, 'XYZ', '9876543210'),
(3, 'Christopher Nolan', '5555555555'),
(4, 'Steven Spielberg', '6666666666'),
(5, 'James Cameron', '7777777777'),
(6, 'Martin Scorsese', '8888888888'),
(7, 'Quentin Tarantino', '9999999999'),
(8, 'Tim Burton', '4444444444'),
(10, 'XYZ', '1234567890');
INSERT INTO MOVIES VALUES
(1, 'Inception', 2010, 'English', 1),
(2, 'Avengers', 2012, 'English', 1),
(3, 'Titanic', 1997, 'English', 2),
(4, 'Interstellar', 2014, 'English', 3),
(5, 'Joker', 2019, 'English', 4),
(6, 'Fight Club', 1999, 'English', 5),
(7, 'Pulp Fiction', 1994, 'English', 6),
(8, 'The Dark Knight', 2008, 'English', 7),
(9, 'Movie XYZ1', 2020, 'English', 10),
(10, 'Movie XYZ2', 2021, 'English', 10);
INSERT INTO MOVIE_CAST VALUES
(1, 1, 'Lead Role'),
(1, 2, 'Supporting'),
(2, 1, 'Supporting'),
(2, 2, 'Heroine'),
(2, 3, 'Guest Role'),
(3, 2, 'Hero'),
(3, 4, 'Lead Role'),
(4, 2, 'Villain'),
(4, 5, 'Supporting'),
(4, 6, 'Villain'),
(5, 3, 'Lead Role'),
(5, 7, 'Guest Role'),
(6, 4, 'Supporting'),
(7, 5, 'Guest Role'),
(8, 6, 'Supporting');
INSERT INTO RATING VALUES
(1, 5),
(2, 4),
(3, 5),
(4, 3),
(5, 4),
(6, 5),
(7, 4),
(8, 5),
(9, 3),
(10, 4);
SELECT Mov_Title FROM MOVIES 
WHERE Dir_id = (SELECT Dir_id FROM DIRECTOR WHERE Dir_Name = 'ABCD');
SELECT DISTINCT M.Mov_Title
FROM MOVIES M
JOIN MOVIE_CAST MC ON M.Mov_id = MC.Mov_id
WHERE MC.Act_id IN (
    SELECT Act_id FROM MOVIE_CAST GROUP BY Act_id HAVING COUNT(Mov_id) >= 2
);
SELECT DISTINCT A.Act_Name 
FROM ACTOR A
JOIN MOVIE_CAST MC1 ON A.Act_id = MC1.Act_id
JOIN MOVIES M1 ON MC1.Mov_id = M1.Mov_id
JOIN MOVIE_CAST MC2 ON A.Act_id = MC2.Act_id
JOIN MOVIES M2 ON MC2.Mov_id = M2.Mov_id
WHERE M1.Mov_Year < 2000 AND M2.Mov_Year > 2015;

SELECT M.Mov_Title, MAX(R.Rev_Stars) AS Highest_Stars
FROM MOVIES M
JOIN RATING R ON M.Mov_id = R.Mov_id
GROUP BY M.Mov_Title
ORDER BY M.Mov_Title;

UPDATE RATING
SET Rev_Stars = 5
WHERE Mov_id IN (
    SELECT Mov_id FROM MOVIES
    WHERE Dir_id IN (SELECT Dir_id FROM DIRECTOR WHERE Dir_Name = 'XYZ')
);
