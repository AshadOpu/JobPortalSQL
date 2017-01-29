/*DATABASE PROJECT ON JOB PORTAL*/

DROP TABLE Application;
DROP TABLE Admin;
DROP TABLE JobPost;
DROP TABLE Employee;
DROP TABLE Employer;

--CREAT TABLE

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

