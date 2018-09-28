# Lab: Built-in Functions

/*
1.	Find Book Titles
Write a SQL query to find books which titles start with “The”.
Order the result by id. Submit your query statements as Prepare DB & run queries. 
*/

SELECT title FROM books
WHERE substring(`title`,1,3) = 'The'
ORDER BY id;

/*
2.	Replace Titles
Write a SQL query to find books which titles start with “The” and replace the substring with 3 asterisks. 
Retrieve data about the updated titles. Order the result by id. 
Submit your query statements as Prepare DB & run queries. 
*/

UPDATE books 
SET title = replace(`title`,'The','***');

SELECT title FROM books
WHERE substring(`title`,1,3) = '***'
ORDER BY id;

/*
3.	Sum Cost of All Books
Write a SQL query to sum prices of all books. 
Format the output to 2 digits after decimal point. 
Submit your query statements as Prepare DB & run queries. 
*/

SELECT FORMAT(sum(cost),2) FROM books;

/*
4.	Days Lived
Write a SQL query to calculate the days that the authors have lived. 
NULL values mean that the author is still alive. 
Submit your query statements as Prepare DB & run queries. 
*/

SELECT concat(`first_name`, ' ', `last_name`) AS 'Full Name', 
TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

/*
5.	Harry Potter Books
Write a SQL query to retrieve titles of all the Harry Potter books. 
Order the information by id. Submit your query statements as Prepare DB & run queries. 
*/

SELECT title FROM books
WHERE title LIKE 'Harry Potter%';

# Exercises: Built-in Functions

/*
1.	Find Names of All Employees by First Name
Write a SQL query to find first and last names of all employees whose first name starts with “Sa” 
(case insensitively). Order the information by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name
FROM employees
WHERE LEFT(first_name, 2) = 'Sa'
ORDER BY employee_id;

/*
2.	Find Names of All employees by Last Name 
Write a SQL query to find first and last names of all employees whose last name contains “ei” 
(case insensitively). Order the information by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name 
FROM employees
WHERE last_name LIKE '%ei%';

/*
3.	Find First Names of All Employees
Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose 
hire year is between 1995 and 2005 inclusive. Order the information by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name FROM employees
WHERE (department_id = 3 OR department_id = 10) 
AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

/*
4.	Find All Employees Except Engineers
Write a SQL query to find the first and last names of all employees whose job titles does not contain 
“engineer”. Order by id. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT first_name, last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'; 

/*
5.	Find Towns with Name Length
Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by 
town name. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT name FROM towns
WHERE char_length(name) BETWEEN 5 AND 6
ORDER BY name;