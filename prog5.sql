CREATE TABLE DEPARTMENT (DNO VARCHAR(20) PRIMARY KEY, DNAME VARCHAR(20) , MGRSTARTDATE DATE);
CREATE TABLE EMPLOYEE (SSN VARCHAR(20) PRIMARY KEY, FNAME VARCHAR(20), LNAME VARCHAR(20), ADDRESS VARCHAR(20),
    SEX CHAR(1) , SALARY INT,
    SUPERSSN VARCHAR(20) REFERENCES EMPLOYEE(SSN),
    DNO VARCHAR(20) REFERENCES DEPARTMENT (DNO));

ALTER TABLE DEPARTMENT ADD MGRSSN VARCHAR(20) REFERENCES EMPLOYEE(SSN);

CREATE TABLE DLOCATION (DLOC VARCHAR(20),
DNO VARCHAR(20) REFERENCES DEPARTMENT(DNO));

CREATE TABLE PROJECT(PNO INT(5) PRIMARY KEY, PNAME VARCHAR(20),PLOCATION VARCHAR(20), DNO VARCHAR(20) REFERENCES DEPARTMENT(DNO));

CREATE TABLE WORKS_ON (
HOURS INT(2), SSN VARCHAR(20) REFERENCES EMPLOYEE(SSN),
PNO INT(5) REFERENCES PROJECT(PNO),
PRIMARY KEY(SSN, PNO));

INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSECE01','JOHN','SCOTT','BANGALORE','M', 450000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE01','JAMES','SMITH','BANGALORE','M', 500000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE02','HEARN','BAKER','BANGALORE','M', 700000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE03','EDWARD','SCOTT','MYSORE','M', 500000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE04','PAVAN','HEGDE','MANGALORE','M', 650000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE05','GIRISH','MALYA','MYSORE','M', 450000);
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSCSE06','NEHA','SN','BANGALORE','F', 800000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSACC01','AHANA','K','MANGALORE','F', 350000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSACC02','SANTHOSH','KUMAR','MANGALORE','M', 300000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSISE01','VEENA','M','MYSORE','M', 600000); 
INSERT INTO EMPLOYEE (SSN, FNAME, LNAME, ADDRESS, SEX, SALARY) VALUES 
('RNSIT01','NAGESH','HR','BANGALORE','M', 500000); 
INSERT INTO DEPARTMENT VALUES ('1', 'ACCOUNTS', '2001-01-01', 'RNSACC02');
INSERT INTO DEPARTMENT VALUES ('2', 'IT', '2016-08-01', 'RNSIT01');
INSERT INTO DEPARTMENT VALUES ('3', 'ECE', '2008-06-01', 'RNSECE01');
INSERT INTO DEPARTMENT VALUES ('4', 'ISE', '2015-08-01', 'RNSISE01');
INSERT INTO DEPARTMENT VALUES ('5', 'CSE', '2002-06-01', 'RNSCSE05');

UPDATE EMPLOYEE SET 
SUPERSSN = NULL,DNO='3' 
WHERE SSN='RNSECE01'; 
UPDATE EMPLOYEE SET 
SUPERSSN='RNSCSE02',DNO='5' 
WHERE SSN='RNSCSE01'; 
UPDATE EMPLOYEE SET 
SUPERSSN='RNSCSE03',DNO='5' 
WHERE SSN='RNSCSE02'; 
UPDATE EMPLOYEE SET 
SUPERSSN='RNSCSE04',DNO='5' 
WHERE SSN='RNSCSE03'; 
UPDATE EMPLOYEE SET DNO='5', 
SUPERSSN='RNSCSE05' 
WHERE SSN='RNSCSE04';
UPDATE EMPLOYEE SET DNO='5', 
SUPERSSN='RNSCSE06' 
WHERE SSN='RNSCSE05'; 
UPDATE EMPLOYEE SET 
DNO='5', SUPERSSN=NULL 
WHERE SSN='RNSCSE06'; 
UPDATE EMPLOYEE SET DNO='1', 
SUPERSSN='RNSACC02' 
WHERE SSN='RNSACC01'; 
UPDATE EMPLOYEE SET 
DNO='1', SUPERSSN=NULL 
WHERE SSN='RNSACC02'; 
UPDATE EMPLOYEE SET 
DNO='4', SUPERSSN=NULL 
WHERE SSN='RNSISE01'; 
UPDATE EMPLOYEE SET 
DNO='2', SUPERSSN=NULL 
WHERE SSN='RNSIT01';

INSERT INTO DLOCATION VALUES ('BANGALORE', '1'); 
INSERT INTO DLOCATION VALUES ('BANGALORE', '2'); 
INSERT INTO DLOCATION VALUES ('BANGALORE', '3'); 
INSERT INTO DLOCATION VALUES('MANGALORE','4'); 
INSERT INTO DLOCATION VALUES('MANGALORE','5'); 

INSERT INTO PROJECT VALUES (100,'IOT','BANGALORE','5'); INSERT 
INTO PROJECT VALUES (101,'CLOUD','BANGALORE','5'); INSERT INTO 
PROJECT VALUES (102,'BIGDATA','BANGALORE','5'); INSERT INTO 
PROJECT VALUES (103,'SENSORS','BANGALORE','3'); 
INSERT INTO PROJECT VALUES (104,'BANK MANAGEMENT','BANGALORE','1'); INSERT INTO 
PROJECT VALUES (105,'SALARYMANAGEMENT','BANGALORE','1'); INSERT INTO PROJECT 
VALUES(106,'OPENSTACK','BANGALORE','4'); 
INSERT INTO PROJECT VALUES (107,'SMARTCITY','BANGALORE','2');

INSERT INTO WORKS_ON VALUES (4, 'RNSCSE01', 100); 
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE01', 101); 
INSERT INTO WORKS_ON VALUES (8, 'RNSCSE01', 102); 
INSERT INTO WORKS_ON VALUES (10, 'RNSCSE02', 100); 
INSERT INTO WORKS_ON VALUES (3, 'RNSCSE04', 100); 
INSERT INTO WORKS_ON VALUES (4, 'RNSCSE05', 101); 
INSERT INTO WORKS_ON VALUES (5, 'RNSCSE06', 102); 
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE03', 102); 
INSERT INTO WORKS_ON VALUES (7, 'RNSECE01', 103); 
INSERT INTO WORKS_ON VALUES (5, 'RNSACC01', 104); 
INSERT INTO WORKS_ON VALUES (6, 'RNSACC02', 105); 
INSERT INTO WORKS_ON VALUES (4, 'RNSISE01', 106); 
INSERT INTO WORKS_ON VALUES (10, 'RNSIT01', 107); 
SELECT * FROM EMPLOYEE;
SELECT DISTINCT P.PNO
FROM PROJECT P
JOIN DEPARTMENT D ON P.DNO = D.DNO
JOIN EMPLOYEE E ON D.MGRSSN = E.SSN
WHERE E.LNAME = 'SCOTT'

UNION

SELECT DISTINCT P.PNO
FROM PROJECT P
JOIN WORKS_ON W ON P.PNO = W.PNO
JOIN EMPLOYEE E ON E.SSN = W.SSN
WHERE E.LNAME = 'SCOTT';


SELECT E.FNAME, E.LNAME, 1.1*E.SALARY AS INCR_SAL FROM 
EMPLOYEE E, WORKS_ON W, PROJECT P 
WHERE E.SSN=W.SSN 
AND W.PNO=P.PNO 
AND P.PNAME='IOT';

SELECT SUM(E.SALARY), MAX(E.SALARY), MIN(E.SALARY), AVG(E.SALARY) 
FROM EMPLOYEE E, DEPARTMENT D 
WHERE E.DNO=D.DNO 
AND D.DNAME='ACCOUNTS';



SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.PNO
    FROM PROJECT P
    WHERE P.DNO = '5'
    AND NOT EXISTS (
        SELECT 1
        FROM WORKS_ON W
        WHERE W.PNO = P.PNO
        AND W.SSN = E.SSN
    )
);

SELECT D.DNO, COUNT(*) AS EMPLOYEE_COUNT
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DNO = E.DNO
WHERE E.SALARY > 600000
AND D.DNO IN (
    SELECT E1.DNO
    FROM EMPLOYEE E1
    GROUP BY E1.DNO
    HAVING COUNT(*) > 5
)
GROUP BY D.DNO;
