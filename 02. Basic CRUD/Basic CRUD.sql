# 1.	Find All Information About Departments
/*
Write a SQL query to find all available information about the departments. 
Sort the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT * FROM departments
ORDER BY department_id;

# 2.	Find all Department Names
/*
Write SQL query to find all department names. 
Sort the information by id. Submit your query statements as Prepare DB & run queries.
*/
SELECT name FROM departments
ORDER BY department_id;

# 3.	Find salary of Each Employee
/*
Write SQL query to find the first name, last name and salary of each employee. Sort the information by id.
 Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name, salary FROM employees
ORDER BY employee_id;

# 4.	Find Full Name of Each Employee
/*
Write SQL query to find the first, middle and last name of each employee. Sort the information by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, middle_name, last_name FROM employees
ORDER BY employee_id;

/*
5.	Find Email Address of Each Employee
Write a SQL query to find the email address of each employee. (by his first and last name). 
Consider that the email domain is softuni.bg. Emails should look like “John.Doe@softuni.bg". 
The produced column should be named "full_ email_address". 
Submit your query statements as Prepare DB & run queries.
*/

SELECT concat(`first_name`,'.',`last_name`,'@softuni.bg')
AS 'full_ email_address'
FROM employees;
 
 /*
 6.	Find All Different Employee’s Salaries
Write a SQL query to find all different employee’s salaries. 
Show only the salaries. Sort the information by id.  
Submit your query statements as Prepare DB & run queries. 
 */

SELECT DISTINCT salary FROM employees
ORDER BY employee_id;

/*
7.	Find all Information About Employees
Write a SQL query to find all information about the employees whose job title is “Sales Representative”.
Sort the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT * FROM employees
WHERE job_title = 'Sales Representative'
ORDER BY employee_id;

/*
8.	Find Names of All Employees by salary in Range
Write a SQL query to find the first name, last name and job title of all 
employees whose salary is in the range [20000, 30000]. Sort the information by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name, job_title FROM employees
WHERE salary BETWEEN 20000 and 30000
ORDER BY employee_id;

/*
9.	 Find Names of All Employees 
Write a SQL query to find the full name of all employees whose salary is 25000, 14000, 12500 or 23600. 
Full Name is combination of first, middle and last name (separated with single space) and they should be in 
one column called “Full Name”. Submit your query statements as Prepare DB & run queries.
*/

SELECT concat_ws(' ',`first_name`, `middle_name`, `last_name`) 
AS 'Full Name' FROM employees
WHERE salary IN(25000, 14000, 12500, 23600);

/*
10.	Find All Employees Without Manager
Write a SQL query to find first and last names about those employees that does not have a manager. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name FROM employees
WHERE manager_id IS NULL;