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

/*
6.	 Find Towns Starting With
Write a SQL query to find all towns that start with letters M, K, B or E (case insensitively). 
Order them alphabetically by town name. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT town_id, name FROM towns
WHERE LEFT(name,1) IN ('M','K','B','E')
ORDER BY name;

/*
7.	 Find Towns Not Starting With
Write a SQL query to find all towns that does not start with letters R, B or D (case insensitively). 
Order them alphabetically by name. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT town_id, name FROM towns
WHERE name REGEXP'^[^R|B|D]+'
ORDER BY name;

/*
8.	Create View Employees Hired After 2000 Year
Write a SQL query to create view v_employees_hired_after_2000 with first and last name to all employees 
hired after 2000 year. Submit your query statements as Run skeleton, run queries & check DB.
*/

CREATE VIEW `v_employees_hired_after_2000`
AS SELECT first_name, last_name FROM employees
WHERE YEAR(hire_date) > 2000;

/*
9.	Length of Last Name
Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
*/

SELECT first_name, last_name FROM employees
WHERE char_length(`last_name`) = 5;

/*
10.	Countries Holding ‘A’ 3 or More Times
Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), 
sorted by ISO code. Display the country name and ISO code. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT country_name, iso_code FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

/*
11.	 Mix of Peak and River Names
Combine all peak names with all river names, so that the last letter of each peak name is the same like the first
letter of its corresponding river name. Display the peak names, river names, and the obtained mix. Sort the results
by the obtained mix. Submit your query statements as Prepare DB & run queries.
*/

SELECT peaks.peak_name, rivers.river_name,
    (LOWER(CONCAT(peak_name,SUBSTRING(rivers.river_name,2)))) AS mix
FROM peaks, rivers
WHERE RIGHT(peak_name,1) = LEFT(river_name,1)
ORDER BY mix;

/*
12.	Games from 2011 and 2012 year
Find the top 50 games ordered by start date, then by name of the game. Display only games from 2011 and 2012 year.
Display start date in the format “YYYY-MM-DD”.
Submit your query statements as Prepare DB & run queries.
*/

USE diablo;
SELECT name, DATE_FORMAT(`start`,'%Y-%m-%d')
FROM games
WHERE YEAR(start) IN (2011,2012)
LIMIT 50;

/*
13.	 User Email Providers
Find all users along with information about their email providers. Display the user_name and email provider.
Sort the results by email provider alphabetically, then by username.
Submit your query statements as Prepare DB & run queries.
*/

SELECT user_name, SUBSTRING(email,locate('@',`email`)+1) AS `Email Provider`
FROM users
ORDER BY `Email Provider`, user_name;

/*
14.	 Get Users with IP Address Like Pattern
Find all user_name and  ip_address for each user sorted by user_name alphabetically.
Display only rows that ip_address matches the pattern: “___.1%.%.___”.
Submit your query statements as Prepare DB & run queries.
*/

SELECT user_name, ip_address FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

/*
15.	 Show All Games with Duration and Part of the Day
Find all games with part of the day and duration.
Parts of the day should be Morning (start time is >= 0 and < 12), Afternoon (start time is >= 12 and < 18),
Evening (start time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3),
Short (between 3 and 6 including), Long (between 6 and 10 including) and Extra Long in any other cases or without
duration. Submit your query statements as Prepare DB & run queries.
*/

SELECT name, (case
                WHEN HOUR(`start`)>=0 AND HOUR(`start`)<12 THEN 'Morning'
                WHEN HOUR(`start`)>=12 AND HOUR(`start`)<18 THEN 'Afternoon'
                WHEN HOUR(`start`)>=18 AND HOUR(`start`)<24 THEN 'Evening'
                END
    ) AS `Part of the Day`,
            (case WHEN duration <= 3 THEN 'Extra Short'
    WHEN duration BETWEEN 3 AND 6 THEN 'Short'
    WHEN duration BETWEEN 6 AND 10 THEN 'Long'
    ELSE 'Extra Long'
    END
    ) AS Duration
FROM games;

