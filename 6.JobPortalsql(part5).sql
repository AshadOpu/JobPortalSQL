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


