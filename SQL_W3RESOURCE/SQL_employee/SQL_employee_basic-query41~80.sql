#https://w3resource.com/sql-exercises/employee-database-exercise/index.php

--41. Write a query in SQL to list the employees who joined in any year except the month February.

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 2;

----Sample Solution1

SELECT *
FROM employees
WHERE to_char(hire_date,'MON') NOT IN ('FEB');

----Sample Solution2

SELECT *
FROM employees
WHERE to_char(hire_date,'MONTH') NOT LIKE 'FEB%';


--42. Write a query in SQL to list the employees who joined in the year 91.

SELECT * FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1991;

----Sample Solution

SELECT *
FROM employees
WHERE hire_date BETWEEN '1991-01-01' AND '1991-12-31';


--43. Write a query in SQL to list the employees who joined in the month of June in 1991.

SELECT * FROM employees
WHERE to_char(hire_date, 'mon-yyyy')='jun-1991'

----Sample Solution

SELECT * FROM employees
WHERE to_char(hire_date, 'mon-yyyy')='jun-1991'


--44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000.

SELECT * FROM employees
WHERE 12*(salary) BETWEEN 25000 AND 50000;


--45. Write a query in SQL to list the employees who have joined on the following dates 1st May,20th Feb, and 03rd Dec in the year 1991.

SELECT * FROM employees
WHERE to_char(hire_date, 'dd-MON-1991') = '01-MAY-1991' 
    OR to_char(hire_date, 'dd-MON-1991') = '20-FEB-1991'
    OR to_char(hire_date, 'dd-MON-1991') = '03-DEC-1991';
    
----Sample Solution

SELECT *
FROM employees
WHERE to_char(hire_date,'DD-MON-YY') IN ('01-MAY-91',
                                         '20-FEB-91',
                                         '03-DEC-91');

*샘플 답변이 좀 더 편리하다.


--46. Write a query in SQL to list the employees working under the managers 63679, 68319, 66564, 69000.

SELECT *
FROM employees
WHERE manager_id IN (63679,
                     68319,
                     66564,
                     69000);


--47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1991 and within this year.

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM hire_date)>6;

----Sample Solution

SELECT *
FROM employees
WHERE hire_date BETWEEN '01-JUL-91' AND '31-DEC-91';


--48. Write a query in SQL to list the employees who joined in 90's.

SELECT *
FROM employees
WHERE to_char(hire_date,'YY') BETWEEN '90' AND '99';


--49. Write a query in SQL to list the managers of department 1001 or 2001.

SELECT *
FROM employees
WHERE job_name = 'MANAGER'
  AND (dep_id = 1001
       OR dep_id =2001);


--50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000.

SELECT * FROM employees
WHERE to_char(hire_date, 'MON') = 'FEB' AND salary BETWEEN 1001 AND 2000;


--51. Write a query in SQL to list all the employees who joined before or after 1991.

SELECT *
FROM employees
WHERE to_char(hire_date,'YYYY') NOT IN ('1991');


--52. Write a query in SQL to list the employees along with department name.

SELECT *
FROM employees e,
     department d
WHERE e.dep_id = d.dep_id;


--53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn 60000 in a year or not working as an ANALYST.

SELECT e.emp_name,
       e.job_name,
       (12*e.salary)"Annual Salary",
       e.dep_id,
       d.dep_name,
       s.grade
FROM employees e,
     department d,
     salary_grade s
WHERE e.dep_id = d.dep_id
  AND e.salary BETWEEN s.min_sal AND s.max_sal
  AND (((12*e.salary)>= 60000)
       OR (e.job_name != 'ANALYST'))


--54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary for those employees whose salary is greater than the salary of their managers.

SELECT w.emp_name,
       w.job_name,
       w.manager_id,
       w.salary,
       m.emp_name "Manager",
       m.emp_id,
       m.salary "Manager_Salary"
FROM employees w,
     employees m
WHERE w.manager_id = m.emp_id
  AND w.salary > m.salary;

**'manager'테이블을 만들어준것

--55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH.

SELECT e.emp_name, e.dep_id, e.salary, e.commission
FROM employees e, department d
WHERE e.dep_id=d.dep_id AND (e.salary BETWEEN 2000 AND 5000)
    AND d.dep_location='PERTH';


--56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.

SELECT s.grade, e.emp_name
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
    AND e.dep_id IN (1001, 3001) AND s.grade<>4
    AND hire_date<'1992-12-31'
ORDER BY s.grade;


--57. Write a query in SQL to list the employees whose manager name is JONAS.

SELECT *
FROM employees e, employees m
WHERE e.manager_id=m.emp_id 
    AND m.emp_name='JONAS';
    

--58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade.

SELECT e.emp_name, e.salary
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
    AND emp_name='FRANK' AND e.salary=s.max_sal;
    

--59. Write a query in SQL to list the employees who are working either MANAGER or ANALYST with a salary range between 2000 to 5000 without any commission.

SELECT * FROM employees
WHERE job_name IN ('MANAGER', 'ANALYST') 
    AND salary BETWEEN 2000 AND 5000 
    AND commission IS NULL;
    

--60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.

SELECT e.emp_id,
       e.emp_name,
       e.dep_id,
       e.salary,
       d.dep_location
FROM employees e,
     department d
WHERE e.dep_id = d.dep_id
  AND d.dep_location IN ('PERTH',
                         'MELBOURNE')
  AND EXTRACT(MONTH
              FROM age(CURRENT_DATE, hire_date)) > 10;


--61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.

SELECT e.emp_id,
       e.emp_name,
       e.dep_id,
       e.salary,
       d.dep_location
FROM employees e,
     department d
WHERE e.dep_id = d.dep_id
  AND d.dep_location IN ('SYDNEY',
                         'MELBOURNE')
  AND to_char(e.hire_date,'YY') = '91'
  AND e.salary BETWEEN 2000 AND 5000;


--62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH within the grade 3 to 5 and experience over 5 years.

SELECT e.dep_id,
       e.emp_id,
       e.emp_name,
       e.salary,
       d.dep_name,
       d.dep_location,
       s.grade
FROM employees e,
     salary_grade s,
     department d
WHERE e.dep_id = d.dep_id
  AND e.salary BETWEEN s.min_sal AND s.max_sal
  AND s.grade IN (3,4,
                  5)
  AND EXTRACT(YEAR
              FROM age(CURRENT_DATE, hire_date)) > 5
  AND (d.dep_name = 'MARKETING'
       AND D.dep_location IN ('MELBOURNE',
                              'PERTH'));


--63. Write a query in SQL to list the employees who are senior to their own manager.

SELECT *
FROM employees w,
     employees m
WHERE w.manager_id = m.emp_id
  AND w.hire_date < m.hire_date;


--64. Write a query in SQL to list the employee with their grade for the grade 4.

SELECT * 
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal 
    AND s.grade=4;
    

--65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name.

SELECT e.emp_name
FROM employees e, department d
WHERE e.dep_id=d.dep_id    
    AND d.dep_name IN ('PRODUCTION', 'AUDIT') 
    AND EXTRACT(YEAR FROM e.hire_date)>'1991'
    AND e.emp_name NOT IN ('MARKER', 'ADELYN');

----Sample Solution

SELECT e.emp_name
FROM employees e,
     department d,
     salary_grade s
WHERE e.dep_id = d.dep_id
  AND d.dep_name IN ('PRODUCTION',
                     'AUDIT')
  AND e.salary BETWEEN s.min_sal AND s.max_sal
  AND e.emp_name NOT IN ('MARKER',
                         'ADELYN')
  AND to_char(hire_date,'YYYY') >'1991';


**샘플 답변에 왜 굳이 salary_grade테이블 가져왔는지 모르겠음


--66. Write a query in SQL to list the employees in the ascending order of their salaries.

SELECT * FROM employees
ORDER BY salary;

**ascending이 디폴트기 때문에 'ASC' 생략해줘도 됨


--67. Write a query in SQL to list the details of the employees in ascending order to the department_id and descending order to the jobs.

SELECT * 
FROM employees
ORDER BY dep_id, job_name DESC;


--68. Write a query in SQL to display all the unique job in descending order.

SELECT DISTINCT job_name
FROM employees
ORDER BY job_name DESC;


--69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.

SELECT emp_id,
       emp_name,
       salary Monthly_Salary,
       salary/30 Daily_Salary,
       12*salary Anual_Salary
FROM employees
ORDER BY Anual_Salary ASC;


--70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'.

SELECT *
FROM employees
WHERE job_name='CLERK'
  OR job_name='ANALYST'
ORDER BY job_name DESC;


--71. Write a query in SQL to display the location of CLARE.

SELECT dep_location
FROM department d,
     employees e
WHERE e.emp_name = 'CLARE'
  AND e.dep_id = d.dep_id ;


--72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.

SELECT *
FROM employees
WHERE hire_date IN ('1991-5-01',
                    '1991-12-03',
                    '1990-01-19')
ORDER BY hire_date ASC;


--73. Write a query in SQL to list the employees who are drawing the salary less than 1000 and sort the output in ascending order on salary.

SELECT *
FROM employees
WHERE salary < 1000
ORDER BY salary;


--74. Write a query in SQL to list the details of the employees in ascending order on the salary.

SELECT *
FROM employees
ORDER BY salary ASC;


--75. Write a query in SQL to list the employees in ascending order on job name and descending order on employee id.

SELECT *
FROM employees e
ORDER BY e.job_name ASC,
         e.emp_id DESC ;


--76. Write a query in SQL to list the unique jobs of department 2001 and 3001 in descending order.

SELECT DISTINCT job_name
FROM employees
WHERE dep_id IN (2001, 3001)
ORDER BY job_name DESC;


--77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.

SELECT *
FROM employees
WHERE job_name NOT IN ('PRESIDENT', 'MANAGER')
ORDER BY salary;


--78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.

SELECT * 
FROM employees
WHERE 12*salary < 25000
ORDER BY salary;


--79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.

SELECT e.emp_id,
       e.emp_name,
       12*salary "Annual Salary",
       (12*salary)/365 "Daily Salary"
FROM employees e
WHERE e.job_name = 'SALESMAN'
ORDER BY "Annual Salary" ASC;


--80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.

SELECT emp_id,
       emp_name,
       hire_date,
       CURRENT_DATE,
       age(CURRENT_DATE, hire_date) EXP
FROM employees
ORDER BY EXP ASC;

