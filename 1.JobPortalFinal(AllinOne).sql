/*

MD.ASHAD-UZ-ZAMAN
ROLL: 1207004
SESSION: 2014-2015
DEPARTMENT OF COMPUTER SCIENCE & ENGINEERING
COURSE NO: CSE 3104
COURSE TITLE: DATABASE SYSTEMS LABORATORY
PROJECT ON DATABASE MANAGEMENT
PROJECT TOPIC: JOB PORTAL

/**************************************PROJECT STARTS HERE****************************************/

DROP TABLE Application;
DROP TABLE Admin;
DROP TABLE JobPost;
DROP TABLE Employee;
DROP TABLE Employer;

--CREATE TABLE

create table Employer(
	Employer_Id		number(10),
	Employer_Name	varchar2(20) NOT NULL,
	Company_Name	varchar2(30) NOT NULL,
	PRIMARY KEY (Employer_Id)
);

create table Employee(
	Employee_Id		number(10),
	Employee_Name	varchar2(20),
	Last_Degree		varchar2(20),
	PRIMARY KEY (Employee_Id)
);

create table JobPost(
	Job_Id	number(10),
	Job_Name	varchar2(20),
	Employer_Id		number(10) NOT NULL,
	PRIMARY KEY (Job_Id),
	FOREIGN KEY (Employer_Id) REFERENCES Employer(Employer_Id)
);

create table Application(
	Application_Id	number(10) NOT NULL,
	Employer_Id		number(10),
	Employee_Id		number(10),
	Job_Id	number(10),
	PRIMARY KEY (Application_Id),
	FOREIGN KEY (Employer_Id)	REFERENCES	Employer(Employer_Id),
	FOREIGN KEY (Employee_Id)	REFERENCES	Employee(Employee_Id),
	FOREIGN KEY (Job_Id)	REFERENCES	JobPost(Job_Id)
);

create table Admin(
	Admin_Id	number(10),
	Employer_Id		number(10),
	Employee_Id		number(10),
	Register_Id		number(2),
	FOREIGN KEY (Employer_Id)	REFERENCES	Employer(Employer_Id),
	FOREIGN KEY (Employee_Id)	REFERENCES	Employee(Employee_Id)
);

--DESCRIBING TABLE

DESCRIBE Employer;
DESCRIBE Employee;
DESCRIBE JobPost;
DESCRIBE Application;
DESCRIBE Admin; 

--ALTERING A TABLE

ALTER TABLE Employee
	ADD (	Current_pos	number(30),
			Current_Organization	number(20),
			Expected_Salary number(10)
		);

DESCRIBE Employee;

ALTER TABLE Employee
	MODIFY (	Current_pos varchar2(30),
				Current_Organization	varchar2(20)
			);

DESCRIBE Employee;

ALTER TABLE Admin
	DROP COLUMN	Register_Id;

DESCRIBE Admin;

ALTER TABLE Employee
	RENAME COLUMN Current_pos TO Current_position;

DESCRIBE Employee;

--INSERTING DATA INTO TABLE
	
INSERT INTO Employer VALUES (1207001,'Aziz Sarkar','KUET');
INSERT INTO Employer VALUES (1207002,'Md.Masum Billah','BTCL');
INSERT INTO Employer VALUES (1207003,'Rahman Tanim','WDL');
INSERT INTO Employer VALUES (1207004,'Ashad Opu','BN');
INSERT INTO Employer VALUES (1207005,'Asaf Golap','TCL');


 
--TRIGGER

CREATE OR REPLACE TRIGGER Sall BEFORE INSERT OR UPDATE ON Employee
	FOR EACH ROW
	DECLARE

	wage_max  number(8) :=160000;
 
BEGIN
IF :new.Expected_Salary>wage_max THEN
RAISE_APPLICATION_ERROR(-20000,'We can not afford you. Why dont you start your own company??');
END IF;
END;
/

INSERT INTO Employee VALUES (8001,'Shahriyar Sawon','BSC','CEO','SBL',55000);
INSERT INTO Employee VALUES (8002,'Al Mazba','MSC','SE','MEGA',35000);
INSERT INTO Employee VALUES (8003,'Sarwar Rahat','BCS','PC','ALPHA',150000);
INSERT INTO Employee VALUES (8004,'Salman Ferdous','BSC','OC','DBBL',78500);
INSERT INTO Employee VALUES (8005,'Arman Tomal','BSC','CEO','KSY',34500);

INSERT INTO JobPost VALUES (5001,'SE',1207003);
INSERT INTO JobPost VALUES (5002,'Progmer',1207004);
INSERT INTO JobPost VALUES (5003,'EO',1207004);
INSERT INTO JobPost VALUES (5004,'Gamer',1207003);
INSERT INTO JobPost VALUES (5005,'PO',1207004);

INSERT INTO Application VALUES (450001,1207004,8002,5003);
INSERT INTO Application VALUES (450002,1207003,8002,5001);
INSERT INTO Application VALUES (450003,1207004,8005,5002);
INSERT INTO Application VALUES (450004,1207004,8004,5005);
INSERT INTO Application VALUES (450005,1207003,8005,5004);

INSERT INTO Admin VALUES (100001,1207001,8001);
INSERT INTO Admin VALUES (100001,1207003,8002);
INSERT INTO Admin VALUES (100002,1207001,8001);
INSERT INTO Admin VALUES (100001,1207002,8003);
INSERT INTO Admin VALUES (100001,1207004,8004);
INSERT INTO Admin VALUES (100001,1207005,8005);

--SHOWING ALL DATA OF A TABLE

SELECT * FROM	Employer;
SELECT * FROM	Employee;
SELECT * FROM	JobPost;
SELECT * FROM	Application;
SELECT * FROM	Admin;




--UPDATING TABLE DATA

UPDATE JobPost SET Job_Name='Programmer' WHERE Job_Id=5002;

SELECT * FROM JobPost;

--DELETING DATE FROM TABLE

DELETE FROM Admin WHERE Admin_Id=100002;

SELECT * FROM Admin;

--SHOWING SCATERRED DATA

SELECT Employee_name,Last_Degree FROM Employee;

--Eliminating re elements

SELECT DISTINCT (Employer_Id) FROM JobPost;

SELECT * FROM JobPost;

--Calculated Fields

SELECT (Expected_Salary/5) FROM Employee WHERE Employee_Id=8003;

--Giving the column a different name

SELECT (Expected_Salary/5) AS salary_divide_by_five FROM Employee;

--Comparison Search Condition

SELECT Employee_Id,Expected_Salary FROM Employee;

SELECT Employee_Id FROM Employee WHERE Expected_Salary<50000;

--Compound Comparison Search Condition

SELECT Employee_name,Current_Organization
FROM Employee
WHERE Employee_Id=8002 OR Employee_Id=8005;

--Range Search Condition

SELECT Employee_Id,Current_Organization
FROM Employee
WHERE Expected_Salary BETWEEN 35000 AND 80000;

SELECT Employee_Id,Current_Organization
FROM Employee
WHERE Expected_Salary NOT BETWEEN 35000 AND 80000;

SELECT Employee_Id,Current_Organization
FROM Employee
WHERE Expected_Salary>=35000 AND Expected_Salary<=80000;

--Single Column Ordering

SELECT Employee_Id,Last_Degree,Current_Organization,Expected_Salary
FROM Employee
ORDER BY Expected_Salary;

--Multiple Columns Ordering

SELECT * FROM Application;

SELECT * FROM Application
ORDER BY Employer_Id,Employee_Id;

--Aggregate Functions
--MAX
SELECT Expected_Salary FROM Employee;

SELECT MAX(Expected_Salary) FROM Employee;

--COUNT

SELECT COUNT(*),COUNT(Employee_Id) FROM Application;
SELECT COUNT(*),SUM(Expected_Salary) FROM Employee;
SELECT AVG(Expected_Salary) FROM Employee;


--DISTINCT COUNT

SELECT COUNT(Employee_Id),COUNT(DISTINCT Employee_Id),COUNT(ALL Employee_Id)
FROM Application;


--GROUP BY

SELECT Employee_Id,COUNT(Application_Id)
FROM Application
GROUP BY Employee_Id;

SELECT Employer_Id,COUNT(Job_Id)
FROM JobPost
GROUP BY Employer_Id;

--HAVING

SELECT Employee_Id,COUNT(Job_Id)
FROM Application
GROUP BY Employee_Id
HAVING COUNT(Job_Id)>1;





--SubQuery

SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Job_Name = 'Programmer'
							);


--Union All

SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004
							);

SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8001
UNION ALL
SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004
							);

--UNION

SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8001
UNION
SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004
							);


--INTERSECT


SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8004
INTERSECT
SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004
							);


--MINUS


SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004
							)
MINUS
SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8004;

--Precedence of Set Operators

SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8001
UNION
(SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id IN						
						(
							SELECT a.Employee_Id
							FROM Application a,JobPost j
							WHERE  j.Job_Id = a.Job_Id
							AND j.Employer_Id = 1207004)
MINUS
SELECT e.Employee_Name,e.Current_Organization,e.Current_Position
FROM Employee e
WHERE e.Employee_Id = 8004);





--JOIN

SELECT Employer.Employer_Name,JobPost.Job_Name
		FROM Employer JOIN JobPost
		ON Employer.Employer_Id = JobPost.Employer_Id;


--NATURAL JOIN

SELECT Employer.Employer_Name,Employer.Company_Name,JobPost.Job_Name
		FROM Employer NATURAL JOIN JobPost;


--CROSS JOIN

SELECT Employer.Employer_Name,JobPost.Job_Name
		FROM Employer CROSS JOIN JobPost;

--INNER JOIN

SELECT E.Employer_Name,E.Company_Name,J.Job_Name
		FROM Employer E INNER JOIN JobPost J
		ON E.Employer_Id = J.Employer_Id;

--OUTER JOIN

--LEFT OUTER JOIN

SELECT E.Employer_Name,E.Company_Name,J.Job_Name
		FROM Employer E LEFT OUTER JOIN JobPost J
		ON E.Employer_Id = J.Employer_Id;

--RIGHT OUTER JOIN

SELECT E.Employer_Name,E.Company_Name,J.Job_Name
		FROM Employer E RIGHT OUTER JOIN JobPost J
		ON E.Employer_Id = J.Employer_Id;





--PL/SQL

SET  SERVEROUTPUT ON
DECLARE
  emple_name Employee.Employee_Name%type;
  app_no  Application.Application_Id%type := 450003;
BEGIN
  SELECT Employee_Name INTO emple_name
  FROM Employee, Application
  WHERE Employee.Employee_Id = Application.Employee_Id AND
  app_no = Application_Id;  
  DBMS_OUTPUT.PUT_LINE('Application Id : ' || app_no || ' Employee Name : '|| emple_name);
END;
/

--CURSOR

SET SERVEROUTPUT ON
DECLARE
     CURSOR Emp_data IS SELECT Employer_Name,Company_Name FROM Employer;
  Own_data Emp_data%ROWTYPE;

BEGIN
OPEN Emp_data;
      LOOP
        FETCH Emp_data INTO Own_data;
        EXIT WHEN Emp_data%ROWCOUNT > 2;
      DBMS_OUTPUT.PUT_LINE ('EmployerName : ' || Own_data.Employer_Name || '	Company:  ' || Own_data.Company_Name);
      END LOOP;
      CLOSE Emp_data;   
END;
/

--PROCEDURE

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getjob IS 
   jb_id JobPost.Job_Id%type;
    jbname JobPost.Job_Name%type;
BEGIN
    jb_id := 5002;
    SELECT Job_Name INTO jbname
    FROM JobPost
    WHERE Job_Id = jb_id;
    DBMS_OUTPUT.PUT_LINE('Job name: '||jbname);
END;
/
SHOW ERRORS;

BEGIN
   getjob;
END;
/


--FUNCTION

CREATE OR REPLACE FUNCTION Max_wage RETURN NUMBER IS
   maxi_wage Employee.Expected_Salary%type;
BEGIN
  SELECT MAX(Expected_Salary) INTO maxi_wage
  FROM Employee;
   RETURN maxi_wage;
END;
/

SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE('Maximum Salary:  ' || Max_wage);
END;
/

/***************************************PROJECT ENDS HERE*****************************************/
