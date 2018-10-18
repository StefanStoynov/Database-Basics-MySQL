# 01.	Table Design
CREATE TABLE pictures(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  path VARCHAR(255) NOT NULL,
  size DECIMAL(10,2) NOT NULL
);

CREATE TABLE users(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(30) NOT NULL UNIQUE ,
  password VARCHAR(30) NOT NULL,
  profile_picture_id INT(11),
  CONSTRAINT fk_profile_picture FOREIGN KEY (profile_picture_id) REFERENCES pictures(id)
);

CREATE TABLE posts(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  caption VARCHAR(255) NOT NULL  ,
  user_id INT(11) NOT NULL ,
  picture_id INT(11) NOT NULL,
  CONSTRAINT fk_posts_users FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_posts_pictures FOREIGN KEY (picture_id) REFERENCES pictures(id)
);

CREATE TABLE comments(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(255) NOT NULL  ,
  user_id INT(11) NOT NULL ,
  post_id INT(11) NOT NULL,
  CONSTRAINT fk_comments_users FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_comments_posts FOREIGN KEY (post_id) REFERENCES posts(id)
);

CREATE TABLE users_followers(
  user_id INT(11),
  follower_id INT(11),
  CONSTRAINT fk_user_followers_users FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_user_followers_users_followers FOREIGN KEY (follower_id) REFERENCES users(id)
);
# 02.	Data Insertion

INSERT INTO comments(content, user_id, post_id)
SELECT
       (concat('Omg!',u.username,'!This is so cool!'))`content`,
       (ceil(p.id * 3 / 2))`user_id`,
       p.id `post_id`
FROM posts p
JOIN users u
ON p.user_id = u.id
WHERE p.id BETWEEN 1 and 10;

# 03.	Data Update

# 04.	Data Deletion

DELETE u
FROM users u
LEFT JOIN users_followers uf ON u.id = uf.user_id
WHERE uf.follower_id is NULL;

# 05.	Users

SELECT id, username FROM users
ORDER BY id;

# 06.	Cheaters

SELECT u.id, u.username FROM users u
JOIN users_followers uf ON uf.user_id = u.id
WHERE uf.user_id = uf.follower_id
ORDER BY u.id;

# 07.	High Quality Pictures

SELECT p.id, p.path, p.size FROM pictures p
WHERE p.size > 50000 AND (p.path LIKE '%jpeg%' OR path LIKE '%png%')
ORDER BY p.size DESC;

# 08.	Comments and Users

SELECT c.id,concat(u.username, ' : ', c.content)
FROM comments c
JOIN users u on c.user_id = u.id
ORDER BY c.id DESC ;

# 09.	Profile Pictures
SELECT u.id, u.username, concat(p.size,'KB')
FROM (SELECT u1.username, u1.id, u1.profile_picture_id FROM users u1
      JOIN (SELECT cq.profile_picture_id
           FROM users `cq`
           GROUP BY cq.profile_picture_id
           HAVING count(cq.profile_picture_id)>1) cq
     ON u1.profile_picture_id = cq.profile_picture_id)`u`
       JOIN pictures p
ON u.profile_picture_id = p.id
ORDER BY u.id;


# 10. Spam Posts

SELECT p.id, p.caption, (SELECT count(p.id)) as `count` FROM posts p
JOIN comments c ON p.id = c.post_id
WHERE p.id = c.post_id
GROUP BY c.post_id
ORDER BY count DESC, p.id
LIMIT 5;

# 11.	Most Popular User

SELECT u.id, u.username, count_posts, count_followers FROM users u
JOIN(
      SELECT user_id, count(follower_id)`count_followers`
      FROM users_followers
      GROUP BY user_id
    ) `up` ON u.id = user_id
JOIN (
     SELECT user_id, count(user_id)`count_posts`
     FROM posts
     GROUP BY user_id
     ) `up1` ON u.id = up1.user_id
ORDER BY count_followers DESC
LIMIT 1;

# 12.	Commenting Myself

SELECT u.id, u.username,if(count_comments IS NULL,0,count_comments)FROM users u
LEFT JOIN (SELECT c.user_id, count(c.post_id)`count_comments` FROM comments c
JOIN posts p ON c.user_id = p.user_id
WHERE p.id = c.post_id
GROUP BY c.user_id)`c1` ON c1.user_id = u.id
ORDER BY count_comments DESC, u.id;

# 13.	User Top Posts

SELECT cq.user_id,u.username, cq.caption
FROM(
    SELECT p.user_id,p.caption ,count(c.post_id)`count1` FROM posts p
    LEFT JOIN comments c on p.id = c.post_id
    GROUP BY p.caption
    ORDER BY p.user_id, count1 DESC
    ) `cq`
JOIN users u ON cq.user_id = u.id
GROUP BY cq.user_id;

# 14.	Posts and Commentators

SELECT p.id, p.caption, count(DISTINCT c.user_id)`c1`FROM posts p
left JOIN comments c ON p.id = c.post_id
GROUP BY p.id
ORDER BY c1 DESC , p.id;

# 15.	Post
DELIMITER $$
CREATE PROCEDURE udp_post (username VARCHAR(30), password VARCHAR(30),caption VARCHAR(255),path VARCHAR(255))
  BEGIN
    IF ( (SELECT u.password FROM users u WHERE u.username = username) <> password)THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password is incorrect!';
    ELSEIF ((SELECT count(p.id) FROM pictures p WHERE p.path = path)= 0)THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The picture does not exist!';
    ELSE
      INSERT INTO posts(caption,user_id,picture_id)
      VALUES (
                 caption,
                 (SELECT u.id FROM users u WHERE u.username = username ),
                 (SELECT p.id FROM pictures p WHERE p.path = path)
                 );
      END IF ;
  END $$

CALL udp_post('UnderSinduxrein','4l8nYGTKMW','#alabala','src/1folders/resources/images/post/formed/digi/6YLvj97k03.digi');

# 16.	Filter

CREATE PROCEDURE udp_filter (hashtag VARCHAR(300))
  BEGIN
   SELECT p1.id, p2.post_filter, u.username FROM posts p1
   JOIN users u ON p1.user_id = u.id
   JOIN (SELECT p.id ,p.caption`post_filter`
         FROM posts p
         WHERE p.caption LIKE concat('%#',hashtag,'%'))
       `p2` ON p2.id = p1.id
   ORDER BY p1.id;
  END $$

CALL udp_filter('cool')