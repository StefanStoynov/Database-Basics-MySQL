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

CREATE TABLE mountains (
  id   INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE peaks (
  id          INT PRIMARY KEY  AUTO_INCREMENT,
  name        VARCHAR(20) NOT NULL,
  mountain_id INT,
  CONSTRAINT fk_mountain_id FOREIGN KEY (mountain_id) REFERENCES mountains (id)
);

/*
2.	 Posts and Authors
Write a query to create a one-to-many relationship between a table, holding information about books and other -about
authors, so that when an author gets removed from the database all his books are deleted too. The tables should have:
-	Books
•	id
•	name
•	author_id
-	Authors
•	id
•	name
Submit your queries using the “MySQL run queries & check DB” strategy.
*/

CREATE TABLE authors (
  id   INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20)
);

CREATE TABLE books (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  name      VARCHAR(50),
  author_id INT,
  CONSTRAINT fk_authors_id FOREIGN KEY (author_id) REFERENCES camp.authors (id)
    ON DELETE CASCADE
);

/*
3.	 Trip Organization
Write a query to retrieve information about the SoftUni camp’s transportation organization.
Get information about the people who drive(name and age) and their vehicle type.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT driver_id, vehicle_type, concat(first_name, ' ', last_name) AS 'driver_name'
FROM vehicles
       JOIN campers ON driver_id = campers.id;

/*
4.	 SoftUni Hiking
Get information about the hiking routes and their leaders – name and id.
Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
*/

SELECT starting_point                     AS 'route_starting_point',
       end_point                          AS 'route_ending_point',
       leader_id,
       concat(first_name, ' ', last_name) AS 'leader_name'
FROM routes
       JOIN campers ON leader_id = campers.id;

/*
5.	 Project Management DB*
Write a query to create a project management db according to the following E/R Diagram:
*/

CREATE TABLE clients (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  client_name VARCHAR(100),
  project_id  INT
);
CREATE TABLE employees (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30),
  last_name  VARCHAR(30),
  project_id INT
);
CREATE TABLE projects (
  id              INT PRIMARY KEY AUTO_INCREMENT ,
  client_id       INT,
  project_lead_id INT,
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (project_lead_id) REFERENCES employees(id)
);

  ALTER TABLE employees
      ADD FOREIGN KEY (project_id) REFERENCES projects(id);

ALTER TABLE clients
    ADD FOREIGN KEY (project_id) REFERENCES projects(id);

#Exercises: Table Relations

/*
1.	One-To-One Relationship
Create two tables as follows. Use appropriate data types.
Insert the data from the example above.
•	Alter table persons and make person_id a primary key.
•	Create a foreign key between persons and passports by using passport_id column.
•	Think about which passport field should be UNIQUE
Submit your queries by using “MySQL run queries & check DB” strategy.
*/

CREATE TABLE passports(
  passport_id INT PRIMARY KEY UNIQUE,
  passport_number VARCHAR(30)
);

CREATE TABLE persons(
  person_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(20),
  salary DECIMAL(7,2),
  passport_id INT UNIQUE
);

ALTER TABLE persons
    ADD CONSTRAINT fk_persons_passports FOREIGN KEY (passport_id) REFERENCES passports(passport_id);

INSERT INTO passports(passport_id, passport_number) VALUES (101,'N34FG21B'),(102,'K65LO4R7'),(103,'ZE657QP2');
INSERT INTO persons(first_name, salary, passport_id) VALUES ('Roberto',43300.00,102),('Tom',56100.00,103),('Yana',60200.00,101);
/*
2.	One-To-Many Relationship
Create two tables as follows. Use appropriate data types.
Insert the data from the example above. Add primary and foreign keys.
Submit your queries by using “MySQL run queries & check DB” strategy.
*/

/*
3.	Many-To-Many Relationship
Create three tables as follows. Use appropriate data types.
Insert the data from the example above.
Add primary keys and foreign keys. Have in mind that table student_exams should have a composite primary key.
Submit your queries by using “MySQL run queries & check DB” strategy.
*/

/*
4.	Self-Referencing
Create a single table as follows. Use appropriate data types.
Insert the data from the example above. Add primary keys and foreign keys. The foreign key should be between manager_id
and teacher_id.
Submit your queries by using “	MySQL run queries & check DB” strategy.
*/

/*
5.	Online Store Database
*/

/*
6.	University Database
*/

/*
7.	SoftUni Design
Create an E/R Diagram of the SoftUni Database. There are some special relations you should check out:
employees are self-referenced (manager_id) and departments have One-to-One with the employees (manager_id) while
the employees have One-to-Many (department_id). You might find it interesting how it looks on the diagram. 
*/

/*
8.	Geography Design
Create an E/R Diagram of the Geography Database.
*/

/*
9.	Peaks in Rila
Display all peaks for "Rila" mountain_range. Include:
•	mountain_range
•	peak_name
•	peak_elevation
Peaks should be sorted by peak_elevation descending.
*/