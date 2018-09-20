# 1.	Create Tables
CREATE DATABASE minions;
use minions;
CREATE TABLE minions(
	id int(11) UNIQUE AUTO_INCREMENT,
    name VARCHAR(20),
    age int(11)
);
CREATE TABLE towns(
	id int(11) PRIMARY KEY,
    name VARCHAR(20)
);

ALTER TABLE minions
ADD PRIMARY KEY (id);

# 2.	Alter Minions Table
ALTER TABLE minions
ADD town_id int(11); 
ALTER TABLE minions
ADD FOREIGN KEY (town_id) REFERENCES towns(id);

# 3.		Insert Records in Both Tables
INSERT INTO towns
VALUES(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

INSERT INTO minions
VALUES (1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);

# 4.	Truncate Table Minions
TRUNCATE TABLE minions;

# 5.	Drop All Tables
DROP TABLE minions, towns;

# 6. Create Database People 
/*
Using SQL query create table “people” with columns:
•	id – unique number for every person there will be no more than 231-1people. (Auto incremented)
•	name – full name of the person will be no more than 200 Unicode characters. (Not null)
•	picture – image with size up to 2 MB. (Allow nulls)
•	height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
•	weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
•	gender – Possible states are m or f. (Not null)
•	birthdate – (Not null)
•	biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
Make id primary key. Populate the table with 5 records.  Submit your CREATE and INSERT statements in Judge as Run queries & check DB.
*/
CREATE DATABASE people;
USE people;
CREATE TABLE people(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture MEDIUMBLOB,
    height DOUBLE(3,2),
    weight DOUBLE(5,2),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography LONGTEXT
);
INSERT INTO people(name, picture, height, weight, gender, birthdate, biography)
VALUES('Gosho',NULL,1.80,54.10,'m','1999-01-20','az sum Gosho'),
('Pesho',NULL,1.82,54.50,'m','1999-01-22','az sum Pesho'),
('Gopeto',NULL,1.83,54.70,'m','1999-11-20','az sum Gopeto'),
('Gopeto',NULL,1.83,54.70,'m','1999-11-20','az sum Gopeto'),
('Gopeto',NULL,1.83,54.70,'m','1999-11-20','az sum Gopeto');
