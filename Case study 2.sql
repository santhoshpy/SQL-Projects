CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

CREATE TABLE JOBE
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOBE VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')
drop table employee

CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOBE(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


--List all the employee details.
select * from EMPLOYEE
--2. List all the department details.
select * from DEPARTMENT
--3. List all job details.
select * from JOBE
--4. List all the locations.
select * from LOCATION
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name, Last_Name, Salary from EMPLOYEE
--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select Employee_ID as "ID of the Employee",Last_Name as "Name of the Employee"  ,Department_ID as "Dep_id" from EMPLOYEE
--7. List out the annual salary of the employees with their names only
select (FIRST_Name  +  Last_Name) as Employee_Name ,(salary*12)as Annualsalary from EMPLOYEE

	--WHERE Condition:
--8. List the details about "Smith".
select * from EMPLOYEE
where FIRST_NAME ='smith' or LAST_NAME = 'smith'
--9. List out the employees who are working in department 20.
select * from EMPLOYEE
where DEPARTMENT_ID = 20
--10 List out the employees who are earning salary between 2000 and 3000.
select * from EMPLOYEE
where SALARY between 2000 and 3000
--11. List out the employees who are working in department 10 or 20.
select * from EMPLOYEE
where DEPARTMENT_ID = 10 or DEPARTMENT_ID = 20
--12. Find out the employees who are not working in department 10 or 30.
select * from EMPLOYEE
where DEPARTMENT_ID = 10 or DEPARTMENT_ID = 30
--13. List out the employees whose name starts with 'L'.
select * from EMPLOYEE
where  FIRST_NAME like'l%' or LAST_NAME like 'l%'
--14. List out the employees whose name starts with 'L' and ends with 'E'.

select * from EMPLOYEE
where  (FIRST_NAME like'l%' or LAST_NAME like 'l%') and (FIRST_NAME like'%e' or LAST_NAME like '%e')
--15. List out the employees whose name length is 4 and start with 'J'.
select * from EMPLOYEE
where  (FIRST_NAME like'j%' and len(FIRST_NAME)= 4)
--16. List out the employees who are working in department 30 and draw the salaries more than 2500.

select * from EMPLOYEE
where SALARY>2500 and DEPARTMENT_ID = 30
--17. List out the employees who are not receiving commission
select * from EMPLOYEE
where comm is null

--ORDER BY Clause:
--18. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select employee_id , last_name from EMPLOYEE
order by EMPLOYEE_ID desc
--19. List out the Employee ID and Name in descending order based on salary.
select employee_id , FIRST_NAME from EMPLOYEE
order by SALARY desc

--20. List out the employee details according to their Last Name in ascending-order.
select * from EMPLOYEE
order by  LAST_NAME 
--21. List out the employee details according to their Last Name in ascending order and then Department ID in descending order
	select * from EMPLOYEE
	order by  LAST_NAME ,  department_id desc
--GROUP BY and HAVING Clause:

--22. List out the department wise maximum salary, minimum salary and
--average salary of the employees.
select d.Name ,avg(salary)as average_salary ,min(salary)as minimum_salary ,max(salary) as maximum_salary   from EMPLOYEE  E join  DEPARTMENT D on D.Department_Id=E.DEPARTMENT_ID
group by e.DEPARTMENT_ID,d.Name

--23. List out the job wise maximum salary, minimum salary and average
--salary of the employees.
select J.DESIGNATION ,avg(salary)as average_salary ,min(salary)as minimum_salary ,max(salary) as maximum_salary   from EMPLOYEE  E join  JOBE J on J.JOB_ID=E.JOB_ID
group by j.DESIGNATION

--24. List out the number of employees who joined each month in ascending order.
select month(hire_date)as Monthwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by month(HIRE_DATE)
order by month(HIRE_DATE)
--25. List out the number of employees for each month and year in
--ascending order based on the year and month.
select month(hire_date)as Monthwise,year(hire_date)as yearwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by month(HIRE_DATE),year(hire_date)
order by month(HIRE_DATE)

--26. List out the Department ID having at least four employees.
select d.Department_Id,count(E.EMPLOYEE_ID)as emplyoee_count from DEPARTMENT D join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Department_Id
Having count(E.EMPLOYEE_ID)>=4

--27. How many employees joined in February month.
select format(hire_date,'MMM')as Monthwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by format(HIRE_DATE,'MMM')
having format(HIRE_DATE,'MMM')= 'feb'

--28. How many employees joined in May or June month.

select format(hire_date,'MMM')as Monthwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by format(HIRE_DATE,'MMM')
having format(HIRE_DATE,'MMM')= 'may' or format(HIRE_DATE,'MMM')='june'

--29. How many employees joined in 1985?
select year(hire_date)as yearwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by year(HIRE_DATE)
having  year(HIRE_DATE) = 1985

--30. How many employees joined each month in 1985?
select format(hire_date,'MMM')as Monthwise,year(hire_date)as yearwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by format(HIRE_DATE,'MMM'),year(hire_date)
having year(hire_date) = 1985

--31. How many employees were joined in April 1985?
select format(hire_date,'MMM')as Monthwise,year(hire_date)as yearwise, count(employee_id) as emplyoee_count from EMPLOYEE
group by format(HIRE_DATE,'MMM'),year(hire_date)
having format(HIRE_DATE,'MMM')= 'Apr'and year(hire_date) = 1985 

--32.  Which is the Department ID having greater than or equal to 1 employees joining in April 1985?
select d.Department_Id,format(hire_date,'MMM')as Monthwise,year(hire_date)as yearwise,count(E.EMPLOYEE_ID)as emplyoee_count from DEPARTMENT D join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Department_Id, format(HIRE_DATE,'MMM'),year(hire_date)
Having count(E.EMPLOYEE_ID)>=1 and format(HIRE_DATE,'MMM')= 'Apr'and year(hire_date) = 1985 

--Joins: from DEPARTMENT D join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
--33. List out employees with their department names.
select e.EMPLOYEE_ID ,d.Name from DEPARTMENT d join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 

--34. Display employees with their designations.
select e.EMPLOYEE_ID ,j.DESIGNATION from EMPLOYEE E join JOBE J on j.JOB_ID = e.JOB_ID

--35. Display the employees with their department names and city.
select e.EMPLOYEE_ID ,d.Name , l.City from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
join LOCATION L on l.Location_ID = d.Location_Id


--36. How many employees are working in different departments? Display with
--department names.
select count (e.EMPLOYEE_ID)as emplyoeecount ,d.Name from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Name

--37. How many employees are working in the sales department?


select count (e.EMPLOYEE_ID)as emplyoeecount ,d.Name from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Name
having d.name ='sales'

--38. Which is the department having greater than or equal to 3
--employees and display the department names in ascending order.

select count (e.EMPLOYEE_ID)as emplyoeecount ,d.Name from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Name
having count(e.employee_id) >=3 

select count (e.EMPLOYEE_ID)as emplyoeecount ,d.Name from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
group by d.Name
order by count(e.employee_id) 

--39. How many employees are working in 'Dallas'?

select count(e.EMPLOYEE_ID)as emplyoeecount ,l.City from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
join LOCATION L on l.Location_ID = d.Location_Id
group by l.City
having l.City ='dallas'


--40. Display all employees in sales or operation departments.

select e.EMPLOYEE_ID  ,d.Name from DEPARTMENT d 
join EMPLOYEE E on d.Department_Id = E.DEPARTMENT_ID 
where d.name ='sales' or d.name = 'operations'

--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
select * ,iif(salary<1000, 'grade D',
iif(salary<2000 ,'Grade C',
iif(salary<2500,'Grade B', 
iif(salary>2500,'Grade A','')))) 

as Grade from  EMPLOYEE
--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
with conditional as
(select * ,iif(salary<1000, 'grade D',
iif(salary<2000 ,'Grade C',
iif(salary<2500,'Grade B', 
iif(salary>2500,'Grade A','')))) 
as grade
from EMPLOYEE)
select count(EMPLOYEE_id) as empcount, grade from conditional
group by grade



--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

WITH SalaryGrades AS (
    SELECT
        EMPLOYEE_ID,
        Salary,
        CASE
            WHEN Salary < 1000 THEN 'Grade D'
            WHEN Salary < 2000 THEN 'Grade C'
            WHEN Salary < 2500 THEN 'Grade B'
            ELSE 'Grade A'
        END AS Grade
    FROM EMPLOYEE
    WHERE Salary BETWEEN 2000 AND 5000
)
SELECT Grade, COUNT(*) AS empcount
FROM SalaryGrades
GROUP BY Grade;


--Subqueries:

--1. Display the employees list who got the maximum salary.
select EMPLOYEE_ID from EMPLOYEE
where salary =( select max(salary) from employee)
--2. Display the employees who are working in the sales department.

select EMPLOYEE_ID,FIRST_NAME,LAST_NAME from EMPLOYEE
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
where Name = 'sales')


--3. Display the employees who are working as 'Clerk'.
select EMPLOYEE_ID, FIRST_NAME,LAST_NAME from EMPLOYEE
where JOB_ID = (select JOB_ID from JOBE
where DESIGNATION  = 'clerk')


--4. Display the list of employees who are living in 'Boston'.
select EMPLOYEE_ID, FIRST_NAME,LAST_NAME from EMPLOYEE
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
where Location_ID = (select Location_ID from LOCATION
where City  = 'Boston'))


--5. Find out the number of employees working in the sales department.

select count(EMPLOYEE_ID)as emplyoee_count from EMPLOYEE
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
where Name = 'sales')

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
  
update  EMPLOYEE
set SALARY = (SALARY+SALARY*0.1)
where JOB_ID = (select JOB_ID from JOBE
where DESIGNATION  = 'clerk')

--7. Display the second highest salary drawing employee details.
select  * from EMPLOYEE
where salary= (select  max(salary) from EMPLOYEE
where SALARY not in (select max(salary) from EMPLOYEE))

--8. List out the employees who earn more than every employee in department 30.
select  * from EMPLOYEE
where salary= (select  max(salary) from EMPLOYEE
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
where Department_Id = 30))

--9. Find out which department has no employees.
select * from DEPARTMENT
where Department_Id not in ( select Department_Id from EMPLOYEE)


--10. Find out the employees who earn greater than the average salary for their department.

select  * from EMPLOYEE
where salary>(select  avg(salary) from EMPLOYEE)
