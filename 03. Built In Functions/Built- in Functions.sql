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