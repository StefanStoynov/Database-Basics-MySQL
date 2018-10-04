# Lab: Table Relations

/*
1.	 Mountains and Peaks
Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
-	Mountains:
•	id
•	name
-	Peaks:
•	id
•	name
•	mountain_id
Check your solutions using the “Run Queries and Check DB” strategy.
*/

CREATE TABLE mountains(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE peaks(
  id INT PRIMARY KEY  AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  mountain_id INT,
  CONSTRAINT fk_mountain_id FOREIGN KEY (mountain_id) REFERENCES mountains(id)
);

/*
2.	 Posts and Authors
Write a query to create a one-to-many relationship between a table, holding information about books and other -about authors, so that when an author gets removed from the database all his books are deleted too. The tables should have:
-	Books
•	id
•	name
•	author_id
•	Authors
•	id
•	name
Submit your queries using the “MySQL run queries & check DB” strategy.
*/

/*
3.	 Trip Organization
Write a query to retrieve information about the SoftUni camp’s transportation organization.
Get information about the people who drive(name and age) and their vehicle type.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

/*
4.	 SoftUni Hiking
Get information about the hiking routes and their leaders – name and id.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

/*
5.	 Project Management DB*
Write a query to create a project management db according to the following E/R Diagram:
*/

