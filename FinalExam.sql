--1
--No because it has a calculated value.

--2
CREATE VIEW v_seattle (emp_no, f_name, l_name, Dept_no, no, dept_name, location)
AS SELECT employee.* ,department.*
  FROM employee JOIN department
  ON employee.dept_no = department.dept_no
  WHERE location = 'Seattle';

GO;

--Yes because you are selecting all and if you name one column, you must name them all.

ALTER VIEW v_seattle  
AS 
SELECT employee.emp_no, employee.emp_fname, employee.emp_lname, department.Dept_no, department.dept_name, 
department.location
  FROM employee JOIN department
  ON employee.dept_no = department.dept_no
  WHERE location = 'Seattle';

  GO;

  --3
  CREATE VIEW project_empCount
  AS
  SELECT project.project_no, project.project_name, COUNT(works_on.emp_no) AS emp_count
  FROM project JOIN works_on ON project.project_no = works_on.project_no
  GROUP BY project.project_no, project.project_name;

  GO;

--4
BEGIN TRY
 BEGIN TRAN;
 INSERT employee
 VALUES(11111, 'Ann', 'Smith', 'd2');
 INSERT employee
 VALUES(22222, 'Matthew', 'Jones', 'd4');
 INSERT employee
 VALUES(33333, 'Andrew', 'Cather', 'd2');
 COMMIT TRAN;
 PRINT 'Transaction commited';
END TRY
BEGIN CATCH
 PRINT 'Transaction rolled back';
 ROLLBACK TRAN;
END CATCH;

GO;

--5
CREATE PROC sp_increase_budget
       @percent decimal(5,2) = .05
AS
UPDATE project 
SET budget = budget + (budget * @percent);

GO;

--6
CREATE FUNCTION emp_inProject
(@pr_number CHAR(4))
RETURNS TABLE
AS RETURN (SELECT emp_fname,emp_lname
           FROM works_on JOIN  employee ON employee.emp_no =works_on.emp_no
           WHERE project_no = @pr_number);

SELECT * FROM emp_inProject('p1');

--7
--Cutting budgets. Testing to see if the new budget is less than the old budget.

--8 
CREATE TRIGGER department_UPDATE_DELETE
ON department
AFTER DELETE, UPDATE
AS
If EXISTS(SELECT * FROM deleted JOIN employee ON deleted.dept_no = employee.dept_no)
BEGIN
;
THROW 50002, 'ID is referenced', 1;
ROLLBACK TRAN;
END;


--9
--Inserted is a system created table that holds the new data for insert and update statements.
--Deleted is a system created table that holds the previous data for delete and update statements.

--10
USE CISJUDY;
BEGIN TRANSACTION /* The beginning of the transaction */
BEGIN TRY
UPDATE employee
    SET emp_no = 39831
    WHERE emp_no = 10102
END TRY
BEGIN CATCH
PRINT 'ROLLED'
ROLLBACK TRANSACTION /* Rollback of the transaction */
END CATCH
BEGIN TRY
UPDATE works_on
    SET emp_no = 39831
    WHERE emp_no = 10102
END TRY
BEGIN CATCH
PRINT 'ROLLED'
ROLLBACK TRANSACTION
END CATCH
COMMIT TRANSACTION /*The end of the transaction */

 



