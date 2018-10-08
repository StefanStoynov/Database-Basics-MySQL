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

SELECT starting_point AS 'route_starting_point',
       end_point AS 'route_ending_point',
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

INSERT INTO passports(passport_id, passport_number) VALUES
                                                           (101,'N34FG21B'),
                                                           (102,'K65LO4R7'),
                                                           (103,'ZE657QP2');
INSERT INTO persons(first_name, salary, passport_id) VALUES
                                                            ('Roberto',43300.00,102),
                                                            ('Tom',56100.00,103),
                                                            ('Yana',60200.00,101);

/*
2.	One-To-Many Relationship
Create two tables as follows. Use appropriate data types.
Insert the data from the example above. Add primary and foreign keys.
Submit your queries by using “MySQL run queries & check DB” strategy.
*/

CREATE TABLE manufacturers(
  manufacturer_id INT PRIMARY KEY NOT NULL ,
  name VARCHAR(20) NOT NULL ,
  established_on DATE NOT NULL
);

CREATE TABLE models(
  model_id INT PRIMARY KEY NOT NULL ,
  name VARCHAR(20) NOT NULL,
  manufacturer_id INT NOT NULL
);

ALTER TABLE models
ADD CONSTRAINT fk_models_manufacturers FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id);

INSERT INTO manufacturers
VALUES (1,'BMW', '1916-03-01'),
       (2,'Tesla', '2003-01-01'),
       (3,'Lada', '1966-05-01');

INSERT INTO models
VALUES (101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

/*
3.	Many-To-Many Relationship
Create three tables as follows. Use appropriate data types.
Insert the data from the example above.
Add primary keys and foreign keys. Have in mind that table student_exams should have a composite primary key.
Submit your queries by using “MySQL run queries & check DB” strategy.
*/

CREATE TABLE students(
  student_id INT NOT NULL PRIMARY KEY ,
  name VARCHAR(50)NOT NULL
);

CREATE TABLE exams(
  exam_id INT NOT NULL PRIMARY KEY,
  name  VARCHAR(50)NOT NULL
);

CREATE TABLE students_exams(
  student_id INT NOT NULL,
  exam_id INT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students
VALUES (1,'Mila'),(2,'Toni'),(3,'Ron');

INSERT INTO exams
VALUES (101,'Spring MVC'),(102,'Neo4j'),(103,'Oracle 11g');

INSERT INTO students_exams
VALUES (1,101),(1,102),(2,101),(3,103),(2,102),(2,103);

ALTER TABLE students_exams
    ADD PRIMARY KEY (student_id,exam_id);
/*
4.	Self-Referencing
Create a single table as follows. Use appropriate data types.
Insert the data from the example above. Add primary keys and foreign keys. The foreign key should be between manager_id
and teacher_id.
Submit your queries by using “	MySQL run queries & check DB” strategy.
*/

CREATE TABLE teachers(
  teacher_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL ,
  manager_id INT
);

INSERT INTO teachers
VALUES (101,'John', NULL ),(102,'Maya', 106),
 (103,'Silvia', 106 ),(104,'Ted', 105),
  (105,'Mark', 101 ),(106,'Greta', 101);

ALTER TABLE teachers
    ADD CONSTRAINT fk_teachers_managers FOREIGN KEY (manager_id) REFERENCES teachers(teacher_id);

/*
5.	Online Store Database
*/

CREATE TABLE customers(
  customer_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  birthday DATE,
  city_id INT NOT NULL
);

CREATE TABLE cities(
  city_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

ALTER TABLE customers
    ADD CONSTRAINT fk_customers_cities FOREIGN KEY (city_id) REFERENCES cities(city_id);

CREATE TABLE orders(
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE items(
  item_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NUll,
  item_type_id INT NOT NULL
);

CREATE TABLE item_types(
  item_type_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

ALTER TABLE items
    ADD CONSTRAINT fk_items_item_types FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id);

CREATE TABLE order_items(
  order_id INT,
  item_id INT,
  CONSTRAINT pk_order_item PRIMARY KEY (order_id, item_id),
  CONSTRAINT fk_order_items_items FOREIGN KEY (item_id) REFERENCES items(item_id),
  CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

/*
6.	University Database
*/

CREATE TABLE students(
  student_id INT PRIMARY KEY NOT NULL ,
  student_number VARCHAR(12) NOT NULL,
  student_name VARCHAR(50) NOT NULL ,
  major_id INT NOT NULL
);

CREATE TABLE majors(
  major_id INT PRIMARY KEY NOT NULL ,
  name VARCHAR(50) NOT NULL
);

ALTER TABLE students
     ADD CONSTRAINT fk_students_majors FOREIGN KEY (major_id) REFERENCES majors(major_id);

CREATE TABLE payments(
  payment_id INT PRIMARY KEY NOT NULL,
  payment_date DATE NOT NULL ,
  payment_amount DECIMAL(8,2) NOT NULL ,
  student_id INT NOT NULL
);

ALTER TABLE payments
    ADD CONSTRAINT fk_payments_students FOREIGN KEY (student_id) REFERENCES students(student_id);

CREATE TABLE subjects(
  subject_id INT PRIMARY KEY NOT NULL,
  subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE agenda(
  student_id INT NOT NULL,
  subject_id INT NOT NULL,
  CONSTRAINT pk_student_subject PRIMARY KEY (student_id,subject_id),
  CONSTRAINT fk_agende_students FOREIGN KEY (student_id) REFERENCES students(student_id),
  CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

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

SELECT mountain_range, peak_name, elevation as `peak_elevation`
FROM mountains
JOIN peaks ON mountains.id = peaks.mountain_id
WHERE mountain_id = 17
ORDER BY `peak_elevation` DESC ;