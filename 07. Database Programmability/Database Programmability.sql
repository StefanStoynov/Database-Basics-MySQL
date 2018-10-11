#Lab: Functions, Triggers and Transactions

/*1.	Count Employees by Town
Write a function ufn_count_employees_by_town(town_name) that accepts town_name as parameter and returns the count of
employees who live in that town. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

DELIMITER $$
CREATE FUNCTION
  ufn_count_employees_by_town(town_name VARCHAR(20))
  RETURNS INTEGER
  BEGIN
    DECLARE e_count INTEGER;
    SET e_count :=(SELECT count(employee_id)FROM employees e
                  JOIN addresses a ON e.address_id = a.address_id
                  JOIN towns t ON t.town_id = a.town_id
                  WHERE t.name = town_name);
    RETURN e_count;
  END$$

CALL ufn_count_employees_by_town('Sofia');

/*2.	Employees Promotion
Write a stored procedure usp_raise_salaries(department_name) to raise the salary of all employees in given
department as parameter by 5%. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

DELIMITER $$

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
  BEGIN UPDATE employees
  SET salary = salary * 1.05
    WHERE department_id = (SELECT department_id FROM departments
                          WHERE name = department_name);
    END $$

CALL usp_raise_salaries('Finance');
/*3.	Employees Promotion By ID
Write a stored procedure usp_raise_salary_by_id(id) that raises a given employee’s salary (by id as parameter) by 5%.
Consider that you cannot promote an employee that doesn’t exist – if that happens, no changes to the database should
be made. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

/*4.	Triggered
Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary)
that will hold information about fired(deleted) employees from the employees table.
Add a trigger to employees table that inserts the corresponding information in deleted_employees.
Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
*/

#Exercises: Functions, Triggers and Transactions


/*1.	Employees with Salary Above 35000
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees’ first and last names for
whose salary is above 35000. The result should be sorted by first_name then by last_name alphabetically, and id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*2.	Employees with Salary Above Number
Create stored procedure usp_get_employees_salary_above that accept a number as parameter and return all employees’
first and last names whose salary is above or equal to the given number. The result should be sorted by first_name
then by last_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*3.	Town Names Starting With
Write a stored procedure usp_get_towns_starting_with that accept string as parameter and returns all town names
starting with that string. The result should be sorted by town_name alphabetically. Submit your query statement as
Run skeleton, run queries & check DB in Judge.
*/

/*4.	Employees from Town
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter and return the employees’
first and last name that live in the given town. The result should be sorted by first_name then by last_name
alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*5.	Salary Level Function
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000 return “Low”
•	If salary is between 30000 and 50000 (inclusive) return “Average”
•	If salary is > 50000 return “High”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*6.	Employees by Salary Level
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary
(low, average or high) and print the names of all employees that have given level of salary.
The result should be sorted by first_name then by last_name both in descending order.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*7.	Define Function
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  that returns true or false
depending on that if the word is a comprised of the given set of letters.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*8.	Find Full Name
You are given a database schema with tables:
•	account_holders(id (PK), first_name, last_name, ssn)
and
•	accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. . The result should be
sorted by full_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge
*/

/*9.	People with Balance Higher Than
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter
and returns all people who have more money in total of all their accounts than the supplied number.
The result should be sorted by first_name then by last_name alphabetically and account id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*	Future Value Function
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum,
yearly interest rate and number of years. It should calculate and return the future value of the initial sum.
Using the following formula:
FV=I×(〖(1+R)〗^T)
	I – Initial sum
	R – Yearly interest rate
	T – Number of years
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*11.	Calculating Interest
Your task is to create a stored procedure usp_calculate_future_value_for_account that uses the function from the
previous problem to give an interest to a person's account for 5 years, along with information about his/her account
id, first name, last name and current balance as it is shown in the example below. It should take the account_id
and the interest_rate as parameters. Interest rate should have precision up to 0.0001, same as the calculated balance
after 5 years. Be extremely careful to achieve the desired precision!
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*12.	Deposit Money
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point.
The procedure should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*13.	Withdraw Money
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number.
Work with precision up to fourth sign after decimal point. The procedure should produce exact results working with
the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*14.	Money Transfer
Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money
from one account to another. Consider cases when one of the account_ids is not valid, the amount of money is negative
number, outgoing balance is enough or transferring from/to one and the same account. Make sure that the whole
procedure passes without errors and if error occurs make no change in the database.
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*15.	Log Accounts Trigger
Create another table – logs(log_id, account_id, old_sum, new_sum). Add a trigger to the accounts table that enters a
new entry into the logs table every time the sum on an account changes.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

/*16.	Emails Trigger
Create another table – notification_emails(id, recipient, subject, body). Add a trigger to logs table to create new
email whenever new record is inserted in logs table. The following data is required to be filled for each email:
•	recipient – account_id
•	subject – “Balance change for account: {account_id}”
•	body - “On {date (current date)} your balance was changed from {old} to {new}.”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/
