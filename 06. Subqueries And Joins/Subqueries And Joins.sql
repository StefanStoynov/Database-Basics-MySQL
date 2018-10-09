# Lab: Subqueries and JOINs

/*1.	Managers
Write a query to retrieve information about the managers – id, full_name, deparment_id and department_name.
Select first 5 deparments ordered by employee_id.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT e.employee_id,
       concat(e.first_name,' ', e.last_name) AS 'full_name',
       d.department_id,
       d.name AS 'department_name'
FROM employees AS e
      RIGHT JOIN departments AS d
ON d.manager_id = e.employee_id
ORDER BY employee_id
LIMIT 5;

/*2.	Towns Adresses
Write a query to get information about adresses in the database, which are in San Francisco, Sofia or Carnation.
Retrieve town_id, town_name, address_text. Order the result by town_id, then by address_id.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT t.town_id, t.name AS 'town_name', a.address_text
FROM towns AS t
      LEFT JOIN addresses as a
         ON t.town_id = a.town_id
WHERE t.name = 'Sofia'
    OR t.name='San Francisco'
    OR t.name='Carnation'
ORDER BY t.town_id, a.address_text;

/*3.	Employees Without Managers
Write a get information about employee_id, first_name, last_name, department_id and salary about all employees
who don’t have a manager. Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT employee_id,first_name,last_name,department_id,salary FROM employees
WHERE manager_id IS NULL;

/*4.	Higher Salary
Write a query to count the number of employees who receive salary higher than the average.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT count(employee_id)
FROM employees AS e
WHERE e.salary > (SELECT avg(salary) FROM employees);

#Exercises: Subqueries and JOINs

/*1.	Employee Address
Write a query that selects:
•	employee_id
•	job_title
•	address_id
•	address_text
Return the first 5 rows sorted by address_id in ascending order.
*/

SELECT e.employee_id,e.job_title,a.address_id,a.address_text
FROM employees e
JOIN addresses a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;

/*2.	Addresses with Towns
Write a query that selects:
•	first_name
•	last_name
•	town
•	address_text
Sorted by first_name in ascending order then by last_name. Select first 5 employees.
*/

SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees e
JOIN addresses a ON e.address_id = a.address_id
JOIN towns t ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

/*3.	Sales Employee
Write a query that selects:
•	employee_id
•	first_name
•	last_name
•	department_name
Sorted by employee_id in descending order. Select only employees from “Sales” department.
*/

SELECT e.employee_id,e.first_name,e.last_name, d.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

/*4.	Employee Departments
Write a query that selects:
•	employee_id
•	first_name
•	salary
•	department_name
Filter only employees with salary higher than 15000. Return the first 5 rows sorted by department_id in descending order.
*/

SELECT e.employee_id,e.first_name,e.salary,d.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

/*5.	Employees Without Project
Write a query that selects:
•	employee_id
•	first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
*/

SELECT e.employee_id, e.first_name
FROM employees e
LEFT JOIN employees_projects e_p ON e.employee_id = e_p.employee_id
WHERE e_p.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

/*6.	Employees Hired After
Write a query that selects:
•	first_name
•	last_name
•	hire_date
•	dept_name
Filter only employees with hired after 1/1/1999 and are from either "Sales" or "Finance" departments.
Sorted by hire_date (ascending).
*/

SELECT e.first_name, e.last_name, e.hire_date, d.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.hire_date >= '1999-01-02' AND d.name IN ('Sales','Finance')
ORDER BY e.hire_date;

/*7.	Employees with Project
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date).
Return the first 5 rows sorted by first_name then by project_name both  in ascending order.
*/

SELECT e.employee_id, e.first_name, p.name
FROM employees e
RIGHT JOIN employees_projects e_p ON e.employee_id = e_p.employee_id
JOIN projects p ON e_p.project_id = p.project_id
WHERE p.start_date >= '2002-08-14' AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;

/*8.	Employee 24
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter all the projects of employees with id 24. If the project has started after 2005 inclusively the return value should be NULL. Sort result by project_name alphabetically.
*/

/*9.	Employee Manager
Write a query that selects:
•	employee_id
•	first_name
•	manager_id
•	manager_name
Filter all employees with a manager who has id equals to 3 or 7. Return the all rows sorted by employee first_name in ascending order.
*/

/*10.	Employee Summary
Write a query that selects:
•	employee_id
•	employee_name
•	manager_name
•	department_name
Show first 5 employees (only for employees who has a manager) with their managers and the departments which they are in (show the departments of the employees). Order by employee_id.
*/

/*11.	Min Average Salary
Write a query that return the value of the lowest average salary of all departments.
*/

/*12.	Highest Peaks in Bulgaria
Write a query that selects:
•	country_code
•	mountain_range
•	peak_name
•	elevation
Filter all peaks in Bulgaria with elevation over 2835. Return the all rows sorted by elevation in descending order.
*/

/*13.	Count Mountain Ranges
Write a query that selects:
•	country_code
•	mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria. Sort result by mountain_range count  in decreasing order.
*/

/*14.	Countries with Rivers
Write a query that selects:
•	country_name
•	river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
*/

/*15.	*Continents and Currencies
Write a query that selects:
•	continent_code
•	currency_code
•	currency_usage
Find all continents and their most used currency. Filter any currency that is used in only one country. Sort your results by continent_code and currency_code.
*/

/*16.	Countries without any Mountains
Find all the count of all countries which don’t have a mountain.
*/

/*17.	Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest peak_elevation (from highest to lowest), then by the longest river_length (from longest to smallest), then by country_name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
*/

