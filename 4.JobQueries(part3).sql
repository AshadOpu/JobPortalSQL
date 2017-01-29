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