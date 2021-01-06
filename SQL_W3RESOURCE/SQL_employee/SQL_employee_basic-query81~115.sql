#https://w3resource.com/sql-exercises/employee-database-exercise/index.php

#81~114


--81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.

SELECT * FROM employees
WHERE hire_date>'1991-06-30' AND EXTRACT(YEAR FROM hire_date)=1991
ORDER BY job_name;

----Sample Solution

SELECT *
FROM employees
WHERE hire_date>('1991-6-30')
  AND date_part('year',hire_date)=1991
ORDER BY job_name ASC;

**date_part함수: 날짜 값에서 함수가 실행되는 특정 부분(년, 월 또는 일)


--82. Write a query in SQL to list the total information of employees table along with department, and location of all the employees working under FINANCE and AUDIT in the ascending department no.

SELECT * 
FROM employees e, department d
WHERE d.dep_name IN ('FINANCE', 'AUDIT') 
    AND e.dep_id=d.dep_id
ORDER BY e.dep_id;


--83. Write a query in SQL to display the total information of the employees along with grades in ascending order.

SELECT *
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_Sal
ORDER BY grade;


--84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.

SELECT e.emp_name,
       e.job_name,
       d.dep_name,
       e.salary,
       s.grade
FROM employees e,
     department d,
     salary_grade s
WHERE e.dep_id = d.dep_id
  AND e.salary BETWEEN s.min_sal AND s.max_sal
ORDER BY e.dep_id ;


--85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary.

SELECT e.emp_name,
       e.job_name,
       e.salary,
       s.grade,
       d.dep_name
FROM employees e,
     department d,
     salary_grade s
WHERE e.dep_id = d.dep_id
  AND e.salary BETWEEN s.min_sal AND s.max_sal
  AND e.job_name NOT IN('CLERK')
ORDER BY e.salary DESC;


--86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       s.grade,
       d.dep_name,
       age(CURRENT_DATE, hire_date) AS "Experience",
       12 * e.salary "Annual Salary"
FROM employees e,
     department d,
     salary_grade s
WHERE e.dep_id IN (1001,
                   2001)
  AND e.dep_id = d.dep_id
  AND e.salary BETWEEN s.min_sal AND s.max_sal;
  

--87. Write a query in SQL to list the details of the employees along with the details of their departments.

SELECT *
FROM employees e,
     department d
WHERE e.dep_id= d.dep_id;


--88. Write a query in SQL to list the employees who are senior to their own MANAGERS.

SELECT *
FROM employees w,
     employees m
WHERE w.emp_id= m.manager_id
  AND w.hire_date> m.hire_date;


--89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       e.dep_id
FROM employees E
WHERE e.dep_id = 1001
ORDER BY e.salary ASC;


--90. Write a query in SQL to find the highest salary from all the employees.

SELECT max(salary)
FROM employees


--91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.

SELECT job_name, 
    ROUND(avg(salary),1) "Salary", 
    ROUND(avg(salary+commission)) "Salary+Commission"
FROM employees
GROUP BY job_name;


--92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991.

SELECT job_name, sum(12*salary)
FROM employees
WHERE EXTRACT(YEAR FROM hire_date)=1991
GROUP BY job_name;


--93. Write a query in SQL to list the employee id, name, department id, location of all the employees.

SELECT e.emp_id,
       e.emp_name,
       e.dep_id,
       d.dep_location
FROM employees e,
     department d
WHERE e.dep_id = d.dep_id ;


--94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001.

SELECT e.emp_id,
       e.emp_name,
       e.dep_id,
       d.dep_location,
       d.dep_name
FROM employees e,
     department d
WHERE e.dep_id = d.dep_id
  AND e.dep_id IN (1001,
                   2001);


--95. Write a query in SQL to list the employee id, name, salary, grade of all the employees.

SELECT e.emp_id, e.emp_name, e.salary, s.grade
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal;


--96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id.

SELECT e.manager_id, count(*)
FROM employees e, employees m
WHERE e.manager_id=m.emp_id 
GROUP BY e.manager_id;


--97. Write a query in SQL to display the number of employee for each job in each department.

SELECT job_name, dep_id, count(*)
FROM employees
GROUP BY job_name, dep_id;


--98. Write a query in SQL to list the department where at least two employees are working.

SELECT dep_id,
       count(*)
FROM employees
GROUP BY dep_id
HAVING count(*) >= 2;


--99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.

SELECT s.grade "Grade", count(e.*) "Number of employees", max(e.salary) "MAX_salary"
FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
GROUP BY s.grade
ORDER BY s.grade;


--100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN.

SELECT d.dep_name "Department", s.grade "Grade", count(e.*)
FROM employees e, department d, salary_grade s
WHERE e.dep_id=d.dep_id AND e.salary BETWEEN s.min_sal AND s.max_sal
    AND e.job_name='SALESMAN'
GROUP BY d.dep_name, s.grade
HAVING count(e.*)>=2 AND e.job_name='SALESMAN';


--101. Write a query in SQL to list the no. of employees in each department where the no. is less than 4.

SELECT dep_id,
       count(*)
FROM employees
GROUP BY dep_id
HAVING count(*)<4;


**언제 HAVING? 집계함수(count, sum...)는 where절에 나타날 수 없다.


--102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.

SELECT d.dep_name "Department", count(e.*)
FROM employees e, department d
WHERE e.dep_id=d.dep_id
GROUP BY d.dep_name
HAVING count(e.*)>=2;


--103. Write a query in SQL to check whether all the employees numbers are indeed unique.

SELECT emp_id,
       count(*)
FROM employees
GROUP BY emp_id;


--104. Write a query in SQL to list the no. of employees and average salary within each department for each job name.

SELECT dep_id, job_name, count(*), avg(salary)
FROM employees
GROUP BY dep_id, job_name;


--105. Write a query in SQL to list the names of those employees starting with 'A' and with six characters in length.

SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%' AND LENGTH(emp_name)=6;


--106. Write a query in SQL to list the employees whose name is six characters in length and third character must be 'R'.

SELECT *
FROM employees
WHERE length(emp_name)=6
  AND emp_name LIKE '__R%';


--107. Write a query in SQL to list the name of the employee of six characters long and starting with 'A' and ending with 'N'.


SELECT *
FROM employees
WHERE length(emp_name)=6
  AND emp_name LIKE 'A%N';
  
  
--108. Write a query in SQL to list the employees who joined in the month of which second character is 'a'.

SELECT *
FROM employees
WHERE to_char(hire_date, 'mon') LIKE '_a%';


--109. Write a query in SQL to list the employees whose names containing the character set 'AR' together.

SELECT *
FROM employees
WHERE emp_name LIKE '%AR%';


--110. Write a query in SQL to list the employees those who joined in 90's.

SELECT *
FROM employees
WHERE to_char(hire_date,'yy') LIKE '9%';


--111. Write a query in SQL to list the employees whose ID not starting with digit 68.

SELECT *
FROM employees
WHERE emp_id NOT LIKE '68%';

----*위와 같이 하면 오류! LIKE는 '문자열' 부분일치 함수

SELECT * 
FROM employees
WHERE to_char(emp_id, '99999') NOT LIKE '68%';

----trim 함수를 통해 문자 앞뒤 공백 제거해줘야 더 정확한 결과가 나옴

SELECT emp_id,
       trim(to_char(emp_id,'99999'))
FROM employees
WHERE trim(to_char(emp_id,'99999')) NOT LIKE '68%';


--112. Write a query in SQL to list the employees whose names containing the letter 'A'.

SELECT *
FROM employees
WHERE emp_name LIKE '%A%';


--113. Write a query in SQL to list the employees whose name is ending with 'S' and six characters long.

SELECT *
FROM employees
WHERE emp_name LIKE '%S'
  AND LENGTH (emp_name) = 6;


--114. Write a query in SQL to list the employees who joined in the month having char 'A' at any position.

SELECT *
FROM employees
WHERE to_char (hire_date,'MONTH') LIKE '%A%';


--115. Write a query in SQL to list the employees who joined in the month having second char is 'A'.

SELECT *
FROM employees
WHERE to_char(hire_date,'MON') LIKE '_A%';

