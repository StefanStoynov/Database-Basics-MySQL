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

/*
4.	 Smallest Deposit Group per Magic Wand Size*
Select the deposit group with the lowest average wand size.
*/

SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY avg(magic_wand_size)
LIMIT 1;

/*
5.	 Deposits Sum
Select all deposit groups and its total deposit sum. Sort result by total_sum in increasing order.
*/

SELECT deposit_group, sum(deposit_amount) FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY sum(deposit_amount);


/*
6.	 Deposits Sum for Ollivander family
Select all deposit groups and its total deposit sum but only for the wizards who has their magic wand crafted
by Ollivander family.
Sort result by deposit_group alphabetically.
*/

SELECT deposit_group, sum(deposit_amount) FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;


/*
7.	Deposits Filter
Select all deposit groups and its total deposit sum but only for the wizards who has their magic wand crafted by
Ollivander family.
After this, filter total deposit sums lower than 150000.
Order by total deposit sum in descending order.
*/

SELECT deposit_group, sum(deposit_amount) AS `sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING `sum`< 150000
ORDER BY `sum` DESC ;

/*
8.	 Deposit charge
Create a query that selects:
•	Deposit group
•	Magic wand creator
•	Minimum deposit charge for each group
Group by deposit_group and magic_wand_creator.
Select the data in ascending order by magic_wand_creator and deposit_group.
*/

SELECT deposit_group, magic_wand_creator, min(deposit_charge) AS `min_deposit_charge`
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group;

/*
9. Age Groups
Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
•	[0-10]
•	[11-20]
•	[21-30]
•	[31-40]
•	[41-50]
•	[51-60]
•	[61+]
The query should return:
•	Age groups
•	Count of wizards in it
Sort result by increasing size of age groups.
*/

SELECT CASE
    WHEN age <= 10 THEN '[0-10]'
    WHEN age <= 20 THEN '[11-20]'
    WHEN age <= 30 THEN '[21-30]'
    WHEN age <= 40 THEN '[31-40]'
    WHEN age <= 50 THEN '[41-50]'
    WHEN age <= 60 THEN '[51-60]'
    ELSE '[61+]'
    END AS `age_group`, count(id) AS 'wizzard_count' FROM wizzard_deposits
GROUP BY `age_group`
ORDER BY `age_group`;

/*
10. First Letter
Write a query that returns all unique wizard first letters of their first names only if they have deposit
of type Troll Chest.
Order them alphabetically.
Use GROUP BY for uniqueness.
*/

SELECT left(first_name,1) AS `first_letter` FROM wizzard_deposits
where deposit_group = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

/*
11.	Average Interest
Mr. Bodrog is highly interested in profitability.
He wants to know the average interest of all deposits groups split by whether the deposit has expired or not.
But that’s not all. He wants you to select deposits with start date after 01/01/1985.
Order the data descending by Deposit Group and ascending by Expiration Flag.
*/

SELECT deposit_group, is_deposit_expired, avg(deposit_interest)FROM wizzard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

/*
12.	Rich Wizard, Poor Wizard*
Give Mr. Bodrog some data to play his favorite game Rich Wizard, Poor Wizard.
The rules are simple: You compare the deposits of every wizard with the wizard after him.
If a wizard is the last one in the database, simply ignore it. At the end you have to sum the difference between the deposits.
At the end your query should return a single value: the SUM of all differences.
*/

SELECT SUM(sums) AS sum_difference FROM
	(SELECT (deposit_amount -
					(SELECT deposit_amount FROM wizzard_deposits AS t2
					WHERE t2.id = t1.id + 1)
			) AS sums
		FROM wizzard_deposits AS t1
	) AS derived_table;

/*
13.	 Employees Minimum Salaries
That’s it! You no longer work for Mr. Bodrog. You have decided to find a proper job as an analyst in SoftUni.
It’s not a surprise that you will use the soft_uni database.
Select the minimum salary from the employees for departments with ID (2,5,7) but only for those who are hired
after 01/01/2000. Sort result by department_id in ascending order.
Your query should return:
•	department_id
*/

SELECT department_id , min(salary) FROM employees
WHERE department_id IN (2,5,7) AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id;

/*
14.	Employees Average Salaries
Select all high paid employees who earn more than 30000 into a new table.
Then delete all high paid employees who have manager_id = 42 from the new table;
Then increase the salaries of all high paid employees with department_id =1 with 5000 in the new table.
Finally, select the average salaries in each department from the new table. Sort result by department_id in
increasing order.
*/

CREATE TABLE high_paid_employees as SELECT * FROM employees WHERE salary > 30000;

DELETE FROM high_paid_employees
WHERE manager_id = 42;

UPDATE high_paid_employees
SET salary = salary + 5000
WHERE department_id = 1;

SELECT department_id, avg(salary) AS `avg_salary` FROM high_paid_employees
GROUP BY department_id
ORDER BY department_id;

DROP TABLE high_paid_employees;
/*
15. Employees Maximum Salaries
Find the max salary for each department. Filter those which have max salaries not in the range 30000 and 70000.
Sort result by department_id in increasing order.
*/

SELECT department_id, max(salary) FROM employees
GROUP BY department_id
HAVING max(salary) NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

/*
16.	Employees Count Salaries
Count the salaries of all employees who don’t have a manager.
*/

SELECT count(employee_id) FROM employees
WHERE manager_id IS NULL ;

/*
17.	3rd Highest Salary*
Find the third highest salary in each department if there is such. Sort result by department_id in increasing order.
*/

SELECT department_id,
(
	SELECT DISTINCT salary FROM employees AS t2
	WHERE t1.department_id = t2.department_id
	ORDER BY salary DESC LIMIT 2, 1
) AS third_highest_salary FROM employees AS t1
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL
ORDER BY department_id;

/*
18.	 Salary Challenge**
Write a query that returns:
•	first_name
•	last_name
•	department_id
for all employees who have salary higher than the average salary of their respective departments.
Select only the first 10 rows. Order by department_id.
*/

SELECT first_name, last_name, department_id FROM employees AS t1
WHERE salary > (SELECT AVG(salary) FROM employees AS t2
				WHERE t1.department_id = t2.department_id)
ORDER BY department_id, employee_id
LIMIT 10;

/*
19.	Departments Total Salaries
Create a query which shows the total sum of salaries for each department. Order by department_id.
Your query should return:
•	department_id
*/

SELECT department_id, sum(salary)FROM employees
GROUP BY department_id
ORDER BY department_id;