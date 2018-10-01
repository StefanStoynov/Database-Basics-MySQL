# Lab: Data Aggregation

/*
1.	 Departments Info
Write a query to count the number of employees in each department by id. Order the information by deparment_id,
then by employees count. Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT department_id, count(department_id) AS `count` FROM employees
GROUP BY department_id
ORDER BY department_id, `count`;
