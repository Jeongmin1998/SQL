#https://www.w3resource.com/sql-exercises/employee-database-exercise/sql-employee-database-exercise-1.php

SQL exercises on employee Database

--1. Write a query in SQL to display all the information of the employees.

SELECT * FROM employees;


--2. Write a query in SQL to find the salaries of all employees.

SELECT salary FROM employees;


--3. Write a query in SQL to display the unique designations for the employees.

SELECT DISTINCT job_name
FROM employees;


--4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars.

SELECT emp_name, to_char(1.15*salary, '$99,999') "Salary"
FROM employees;


**to_char = 숫자나 날짜를 문자로 변환해주는 함수
이때, '9' = 한 자리 숫자, 실제 값보다 크거나 같게 명시**


--5. Write a query in SQL to produce the output of employees name and job name as a format of "Employee & Job".

SELECT emp_name|| '   ' ||job_name "Employee & Job"
FROM employees;


** || 쌍파이프 = 문자열이나 컬럼을 합쳐주는 역할 **


--6. Write a query in SQL to produce the output of employees.

SELECT emp_name || '('|| lower(job_name)||')' AS "Employee"
FROM employees;


--7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.

SELECT emp_name, to_char(hire_date, 'MONTH DD,YYYY') "Hire Date"
FROM employees;


--8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.

SELECT length(trim(emp_name))
FROM employees;


**trim = 문자열 공백 제거


--9. Write a query in SQL to list the emp_id, salary, and commission of all the employees.

SELECT emp_id, salary, commission
FROM employees;


--10. Write a query in SQL to display the unique department with jobs.

SELECT DISTINCT dep_id, job_name 
FROM employees;


--11. Write a query in SQL to list the employees who does not belong to department 2001.

SELECT *
FROM employees
WHERE department <> 2001;

----Sample Solution

SELECT *
FROM employees
WHERE dep_id NOT IN (2001);

* <> = NOT IN


--12. Write a query in SQL to list the employees who joined before 1991.

SELECT *
FROM employees
WHERE EXTRACT(YEAR from hire_date) < 1991;

----Sample Solution

SELECT *
FROM employees
WHERE hire_date<('1991-1-1');

*나는 hire_date에서 년도를 추출해서 비교한 것이고, sample solution에서는 1991.01.01을 기준으로 비교해주었다.


--13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.

SELECT AVG(salary)
FROM employees
WHERE job_name = 'ANALYST';


--14. Write a query in SQL to display the details of the employee BLAZE.

SELECT * FROM employees WHERE emp_name='BLAZE';


--15. Write a query in SQL to display all the details of the employees whose commission is more than their salary.

SELECT * FROM employees WHERE commission > salary;


--16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.

SELECT * FROM employees WHERE (salary*1.25) > 3000;


--17. Write a query in SQL to list the name of the employees, those having six characters to their name.

SELECT emp_name FROM employees
WHERE length(emp_name) = 6;


--18. Write a query in SQL to list the employees who joined in the month January.

SELECT * FROM employees 
WHERE EXTRACT(MONTH from hire_date) = 1;

----Sample Solution

SELECT *
FROM employees
WHERE to_char(hire_date, 'mon')='jan';



--19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.

SELECT e.emp_name || ' works for ' || m.emp_name
FROM employees e,
     employees m
WHERE e.manager_id = m.emp_id;


--20. Write a query in SQL to list all the employees whose designation is CLERK.

SELECT *
FROM employees
WHERE job_name = 'CLERK';


--21. Write a query in SQL to list the employees whose experience is more than 27 years.

SELECT * FROM employees
WHERE EXTRACT(YEAR from age(CURRENT_DATE, hire_date)) >27;

**age(계산할 시점, 기준 시점)**


--22. Write a query in SQL to list the employees whose salaries are less than 3500.

SELECT * FROM employees 
WHERE salary < 3500;


--23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.

SELECT emp_name, job_name, salary
FROM employees
WHERE job_name = 'ANALYST';


--24. Write a query in SQL to list the employees who have joined in the year 1991.

SELECT * FROM employees
WHERE EXTRACT(YEAR from hire_date) = 1991;

----Sample Solution

SELECT *
FROM employees
WHERE to_char(hire_date,'YYYY') = '1991';


--25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91.

SELECT emp_name, emp_id, hire_date, salary
FROM employees
WHERE hire_date < '1991-04-01';


--26. Write a query in SQL to list the employee name, and job_name who are not working under a manager.

SELECT emp_name, job_name
FROM employees
WHERE manager_id IS NULL;


--27. Write a query in SQL to list all the employees joined on 1st may 91.

SELECT *
FROM employees
WHERE hire_date = '1991-05-01';


--28. Write a query in SQL to list the id, name, salary, and experiences of all the employees working for the manger 68319.

SELECT emp_id, emp_name, salary, age(CURRENT_DATE, hire_date) "Experience"
FROM employees
WHERE manager_id = 68319;


--29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.

SELECT emp_id, emp_name, salary, age(CURRENT_DATE, hire_date) "Experience"
FROM employees
WHERE salary/30 > 100;


--30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.

SELECT emp_name
FROM employees
WHERE hire_date + interval '8 years' > '1999-12-31';


** interval: 시간, 날짜 더하기, 빼기


--31. Write a query in SQL to list those employees whose salary is an odd value.

SELECT *
FROM employees
WHERE mod(salary,2) = 1;


--32. Write a query in SQL to list those employees whose salary contain only 3 digits.

SELECT *
FROM employees
WHERE length(TRIM(TO_CHAR(salary,'9999'))) = 3;


--33. Write a query in SQL to list the employees who joined in the month of APRIL.

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 4;

----Sample Solution

SELECT *
FROM employees
WHERE to_char(hire_date,'MON') ='APR';

----OR

SELECT *
FROM employees
WHERE to_char(hire_date,'MON') IN ('APR');

----OR

SELECT *
FROM employees
WHERE to_char(hire_date,'MON') LIKE 'APR%';


--34. Write a query in SQL to list the employees those who joined in company before 19th of the month.

SELECT * FROM employees
WHERE EXTRACT(DAY FROM hire_date) < 19;

----Sample Solution

SELECT *
FROM employees
WHERE to_char(hire_date,'DD') < '19';


--35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience which month portion is more than 10.

SELECT * FROM employees
WHERE job_name='SALESMAN' AND (EXTRACT(MONTH from age(CURRENT_DATE, hire_date))) > 10;


--36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.

SELECT * FROM employees
WHERE dep_id IN (3001, 1001) AND EXTRACT(YEAR FROM hire_date)=1991;

----Sample Solution 1

SELECT *
FROM employees
WHERE to_char(hire_date,'YYYY') = '1991'
  AND (dep_id =3001
       OR dep_id =1001) ;

----2

SELECT *
FROM employees
WHERE to_char (hire_date,'YYYY') IN ('1991')
  AND (dep_id = 3001
       OR dep_id =1001) ;


--37. Write a query in SQL to list the employees who are working for the department ID 1001 or 2001.

SELECT * FROM employees
WHERE dep_id IN (1001, 2001);

----Sample Solution

SELECT *
FROM employees
WHERE dep_id=1001
  OR dep_id=2001;
  
  
--38. Write a query in SQL to list all the employees of designation CLERK in department no 2001.

SELECT * FROM employees
WHERE job_name='CLERK' AND dep_id=2001;


--39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for -
--1) Annual salary is below 34000 but receiving some commission which should not be more than the salary,
--2) And designation is SALESMAN and working for department 3001

SELECT emp_id "ID", emp_name "Name", salary "Salary", job_name "Job"
FROM employees
WHERE 12*(salary+commission) < 34000 AND commission <= salary
    AND commission IS NOT NULL
    AND job_name='SALESMAN' AND dep_id=3001;
    
    
**주의해야할 점: 조건 중에 "commission IS NOT NULL"은 넣지 않아도 값이 우연히 똑같이 나오긴 한다.
그러나, 문제에서 "receiving some commission~"라고 했기 때문에 이 조건 넣어줘야 한다.**


--40. Write a query in SQL to list the employees who are either CLERK or MANAGER.

SELECT * FROM employees
WHERE job_name IN ('CLERCK', 'MANAGER');























