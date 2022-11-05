SELECT * FROM employees
--Question 1
SELECT last_name, hire_date, department_id FROM employees 
WHERE department_id=80 AND last_name <> 'Zlotkey'

--Question 2
SELECT employee_id, last_name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary

--Question 3
SELECT employee_id, last_name FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%u%')

-- Question 4
--Cach 1: inner join
SELECT e.last_name, e.department_id, e.job_id
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.location_id = 1700
-- Cach 2: select long
SELECT last_name, department_id, job_id from employees
WHERE department_id IN (select department_id from departments where location_id = 1700)

--Question 5
--Cach 1 select long
SELECT last_name, salary FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees WHERE last_name = 'King')
--Cach 2 self-join
SELECT e.last_name, e.salary FROM employees e JOIN employees manager on e.manager_id = manager.employee_id
WHERE manager.last_name = 'King'


--HOMEWORK
--Question 6
--Cach 1
SELECT department_id, last_name, job_id FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Executive')
--Cach 2
SELECT e.department_id, e.last_name, e.job_id, d.department_name FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Executive'

--Question 7
SELECT employee_id, last_name, salary, department_id FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees) 
AND department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%u%')
ORDER BY department_id ASC

--Question 8
SELECT 
	ROUND(MAX(salary),0) AS 'Maximum',
	ROUND(MIN(salary),0) AS 'Minimum', 
	ROUND(AVG(salary),0) AS 'Average', 
	ROUND(SUM(salary),0) AS 'Sum'
FROM employees

--Question 9
SELECT 
	UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,LEN(last_name))) AS 'Uppercase First Letter',
	LEN(last_name) AS 'Length of Last Name' 
FROM employees
WHERE last_name LIKE '[JAM]%'
ORDER BY last_name ASC

--Question 10
SELECT employee_id, last_name, salary, ROUND(salary + salary * (15.5/100),0) AS 'New Salary' FROM employees

--Question 11
SELECT e.last_name, e.department_id, d.department_name FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id

--Question 12
SELECT e.employee_id, e.last_name, e.hire_date, m.hire_date AS 'Manager Hire Date' 
FROM employees e JOIN employees m on e.manager_id = m.employee_id
WHERE e.hire_date>m.hire_date
AND e.department_id = (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city ='Toronto'))
