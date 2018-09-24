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

# 7.	Create Table Users
/*
Using SQL query create table users with columns:
•	id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
•	username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
•	password – password will be no longer than 26 characters (non Unicode). (Required)
•	profile_picture – image with size up to 900 KB. 
•	last_login_time
•	is_deleted – shows if the user deleted his/her profile. Possible states are true or false.
Make id primary key. Populate the table with 5 records. Submit your CREATE and INSERT statements. Submit your CREATE and INSERT statements as Run queries & check DB.
*/
USE people;
CREATE TABLE users(
	id INT(11) UNIQUE AUTO_INCREMENT NOT NULL,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB(900),
    last_login_time DATETIME,
    is_deleted BIT
);
ALTER TABLE users
ADD PRIMARY KEY(id);
INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted)
VALUES ('username1','12345', NULL, now(), 0),
('username2','12345', NULL, now(), 0),
('username3','12345', NULL, now(), 0),
('username4','12345', NULL, now(), 0),
('username5','12345', NULL, now(), 0); 

# 8.	Change Primary Key
/*
Using SQL queries modify table users from the previous task. 
First remove current primary key then create new primary key that would be combination of fields id and username.
The initial primary key name on id is pk_users.
Submit your query in Judge as Run skeleton, run queries & check DB.
*/
ALTER TABLE users
MODIFY id INT NOT NULL;
ALTER TABLE users
DROP PRIMARY KEY;
ALTER TABLE users
ADD PRIMARY KEY (id, username);
ALTER TABLE users
MODIFY id INT NOT NULL AUTO_INCREMENT;

# 9.	Set Default Value of a Field
/*
Using SQL queries modify table users. Make the default value of last_login_time field to be the current time. 
Submit your query in Judge as Run skeleton, run queries & check DB.
*/

USE people;
ALTER TABLE users
MODIFY last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

# 10. Set Unique Field
/*
Using SQL queries modify table users. 
Remove username field from the primary key so only the field id would be primary key. 
Now add unique constraint to the username field. The initial primary key name on (id, username) is pk_users.
Submit your query in Judge as Run skeleton, run queries & check DB.
*/
ALTER TABLE users
MODIFY id INT NOT NULL;

ALTER TABLE users
DROP PRIMARY KEY;

ALTER TABLE users
MODIFY id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
MODIFY username VARCHAR(30) NOT NULL UNIQUE;

# 11.	Movies Database
/*
Using SQL queries create Movies database with the following entities:
•	directors (id, director_name, notes) 
•	genres (id, genre_name, notes) 
•	categories (id, category_name, notes)  
•	movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
Set most appropriate data types for each column.
Set primary key to each table. Populate each table with 5 records. 
Make sure the columns that are present in 2 tables would be of the same data type. 
Consider which fields are always required and which are optional. 
Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
*/

CREATE DATABASE movies;
USE movies;
CREATE TABLE directors(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    director_name VARCHAR(20) NOT NULL,
    notes TEXT
);

CREATE TABLE genres(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY UNIQUE,
    genre_name VARCHAR(20) NOT NULL,
    notes TEXT
);

CREATE TABLE categories(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(20) NOT NULL,
    notes TEXT
);

CREATE TABLE movies(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
    title VARCHAR(20) NOT NULL,
    director_id INT NOT NULL,
    copyright_year YEAR NOT NULL,
    length TIME,
    genre_id INT,
    category_id INT,
    rating INT,
    notes TEXT
);

INSERT INTO directors(director_name, notes)
VALUES ('name1', 'null'),
('name2', 'null'),
('name3', 'null'),
('name4', 'null'),
('name5', 'null');

INSERT INTO categories (category_name, notes)
VALUES ('category_name1', 'null'),
('category_name2', 'ull'),
('category_name3','ull'),
('category_name4', 'ull'),
('category_name5', 'ull');

INSERT INTO genres(genre_name, notes)
VALUES ('genre_name1', 'null'),
('genre_name2', 'null'),
('genre_name3', 'null'),
('genre_name4', 'null'),
('genre_name5', 'null');

INSERT INTO movies (title, director_id, copyright_year)
VALUES ('title1', 1, '2000'),
('title2', 1, '2000'),
('title3', 1, '2000'),
('title4', 1, '2000'),
('title5', 1, '2000');
