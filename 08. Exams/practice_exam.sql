# 01. Table Design
CREATE TABLE users(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  nickname VARCHAR(25),
  gender CHAR(1),
  age INT(11),
  location_id INT(11),
  credential_id INT(11)
);

CREATE TABLE locations(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  latitude FLOAT,
  longitude FLOAT
);

CREATE TABLE credentials(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(30),
  password VARCHAR(20)
);

CREATE TABLE chats(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(32),
  start_date DATE,
  is_active BIT
);

CREATE TABLE messages(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(200),
  sent_on DATE,
  chat_id INT(11),
  user_id INT(11),
  CONSTRAINT fk_messages_chats FOREIGN KEY (chat_id) REFERENCES chats(id),
  CONSTRAINT fk_messages_users FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE users_chats(
  user_id INT(11),
  chat_id INT(11),
  CONSTRAINT fk_users_chats_users FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_users_chats_chats FOREIGN KEY (chat_id) REFERENCES chats(id)
);

ALTER TABLE users
    ADD CONSTRAINT fk_users_locations FOREIGN KEY users(location_id) REFERENCES locations(id),
    ADD CONSTRAINT fk_users_credentials FOREIGN KEY users(credential_id) REFERENCES credentials(id);

ALTER TABLE users
    ADD UNIQUE (credential_id);

ALTER TABLE users_chats
    ADD PRIMARY KEY (user_id, chat_id);

#02. Insert

INSERT INTO messages(content, sent_on, chat_id, user_id)
SELECT
       (concat(u.age,'-',u.gender,'-',l.latitude,'-',l.longitude))`content`,
       ('2016-12-15') `sent_on`,
        CASE u.gender
          WHEN 'F' THEN ceil(sqrt(u.age * 2))
          WHEN 'M' THEN ceil(pow(u.age/18,3))
        end `chat_id`,
       u.id `user_id`
FROM users u JOIN locations l ON u.location_id = l.id
WHERE u.id BETWEEN 10 and 20;

#04. Delete

DELETE l
FROM locations l
LEFT JOIN users u ON l.id = u.location_id
WHERE u.nickname is NULL;


#05. Age Range

SELECT u.nickname, u.gender, u.age FROM users u
WHERE age BETWEEN 22 and 37
ORDER BY u.id;

#06. Messages

SELECT m.content, m.sent_on FROM messages m
WHERE sent_on > '2014-05-12' AND m.content LIKE '%just%'
ORDER BY m.id DESC;

#07. Chats

SELECT c.title, c.is_active FROM chats c
WHERE (is_active = 0 AND char_length(title)<5 ) OR title LIKE '__tl%'
ORDER BY c.title DESC;

#08. Chat Messages

SELECT c.id, c.title, m.id FROM chats c
JOIN messages m ON c.id = m.chat_id
WHERE m.sent_on < '2012-03-26' AND c.title LIKE '%x'
ORDER BY c.id, m.id;

#09. Message Count

SELECT c.id, count(m.chat_id) FROM chats c
RIGHT JOIN messages m ON c.id = m.chat_id
WHERE m.id < 90
GROUP BY c.id
ORDER BY count(m.chat_id) DESC , c.id
LIMIT 5;

#10. Credentials

SELECT u.nickname, c.email, c.password FROM users u
JOIN credentials c  ON u.credential_id = c.id
WHERE c.email LIKE '%.co.uk'
ORDER BY c.email;

#11. Locations

SELECT u.id, u.nickname, u.age FROM users u
WHERE u.location_id is NULL
ORDER BY u.id;

#12. Left Users

SELECT m.id, m.chat_id, u.id FROM  messages m
left JOIN users u ON m.user_id = u.id
WHERE m.chat_id = 17
ORDER BY m.id DESC;

#13. Users in Bulgaria

SELECT u.nickname, c.title, l.latitude, l.longitude FROM users u
JOIN users_chats uc ON u.id = uc.user_id
JOIN chats c ON uc.chat_id = c.id
left JOIN locations l ON u.location_id = l.id
WHERE (l.latitude >= 41.129999 AND l.latitude <= 44.13)
AND (l.longitude >= 22.19999 AND l.longitude <= 28.36)
ORDER BY c.title;

# 14. Last Chat

SELECT c.title, m.content FROM chats c
LEFT JOIN messages m ON c.id = m.chat_id
WHERE c.start_date = (SELECT max(start_date)FROM chats)
AND m.sent_on =(SELECT max(sent_on) FROM messages WHERE c.id = m.chat_id)
ORDER BY m.id;

#15. Radians
DELIMITER $$
SET GLOBAL log_bin_trust_function_creators = 1;
CREATE FUNCTION udf_get_radians(degrees FLOAT)
  RETURNS FLOAT
  BEGIN
    DECLARE result FLOAT;
    SET result := (degrees * PI())/180;
    RETURN result;
  END $$

#16. Change Password

CREATE PROCEDURE udp_change_password(email1 VARCHAR(30), password1 VARCHAR(20))
  BEGIN
    IF ((SELECT c.email FROM credentials c WHERE c.email = email1)<> email1) THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'The email does`t exist!';
    ELSE UPDATE credentials
        SET password = password1;
    END IF;
  END $$

CALL udp_change_password('abarnes10@sogou.com','new_pass');
