# Lab: Built-in Functions

/*
1.	Find Book Titles
Write a SQL query to find books which titles start with “The”.
Order the result by id. Submit your query statements as Prepare DB & run queries. 
*/

SELECT title FROM books
WHERE substring(`title`,1,3) = 'The'
ORDER BY id;