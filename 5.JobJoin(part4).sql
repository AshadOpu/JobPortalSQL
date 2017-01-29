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

SELECT E.Employer_Name,E.Company_Name,J.Job_Name
		FROM Employer E LEFT OUTER JOIN JobPost J
		ON E.Employer_Id = J.Employer_Id;

SELECT E.Employer_Name,E.Company_Name,J.Job_Name
		FROM Employer E RIGHT OUTER JOIN JobPost J
		ON E.Employer_Id = J.Employer_Id;