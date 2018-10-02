# Lab: Data Aggregation

/*
1.	 Departments Info
Write a query to count the number of employees in each department by id. Order the information by deparment_id,
then by employees count. Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT department_id, count(department_id) AS `count` FROM employees
GROUP BY department_id
ORDER BY department_id, `count`;

/*
2.	Average Salary
Write a query to calculate the average salary in each department.
Order the information by department_id.
Round the salary result to two digits after the decimal point.
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT department_id, round(avg(salary),2) AS `Average Salary` FROM employees
GROUP BY department_id;


/*
3.	 Min Salary
Write a query to retrieve information about the departments grouped by department_id with minumum salary higher than 800.
Round the salary result to two digits after the decimal point.
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT department_id,round(min(salary),2) AS `Min Salary` FROM employees
GROUP BY department_id
HAVING `Min Salary`>800;

/*
4.	 Appetizers Count
Write a query to retrieve the count of all appetizers (category id = 2) with price higher than 8.
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT count(category_id) AS `Appetizers cost > 8` FROM products
WHERE  category_id = 2 AND price > 8;

/*
5.	 Menu Prices
Write a query to retrieve information about the prices of each category. The output should consist of:
•	Category_id
•	Average Price
•	Cheapest Product
•	Most Expensive Product
See the examples for more information. Round the results to 2 digits after the decimal point.
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT category_id,
       round(avg(price),2) AS 'Average Price',
       round(min(price),2) AS 'Cheapest Product',
       round(max(price),2) AS 'Most Expensive Product'
FROM products
GROUP BY category_id;

# Exercises: Data Aggregation

/*
1. Records’ Count
Import the database and send the total count of records to Mr. Bodrog. Make sure nothing got lost.
*/

SELECT count(id)AS `count`
FROM wizzard_deposits;

/*
2.	 Longest Magic Wand
Select the size of the longest magic wand. Rename the new column appropriately.
*/

SELECT max(magic_wand_size) AS `longest_magic_wand`
FROM wizzard_deposits;

/*
3. Longest Magic Wand per Deposit Groups
For wizards in each deposit group show the longest magic wand.
Sort result by longest magic wand for each deposit group in increasing order, then by deposit_group alphabetically.
Rename the new column appropriately.
*/

SELECT deposit_group, max(magic_wand_size) AS `longest_magic_wand`
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand, deposit_group;
