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
