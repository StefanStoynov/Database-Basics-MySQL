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
