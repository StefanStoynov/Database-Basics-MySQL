#2.	Section: Data Definition Language (DDL) – 40pts

CREATE TABLE planets(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL
);

CREATE TABLE spaceports(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  planet_id INT(11),
  CONSTRAINT fk_spaceports_planets FOREIGN KEY (planet_id) REFERENCES planets(id)
);

CREATE TABLE spaceships(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  light_speed_rate INT(11) DEFAULT 0
);

CREATE TABLE colonists(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  ucn CHAR(10) NOT NULL UNIQUE ,
  birth_date DATE NOT NULL
);

CREATE TABLE journeys(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  journey_start DATETIME NOT NULL,
  journey_end DATETIME NOT NULL,
  purpose ENUM ('Medical','Technical','Educational', 'Military'),
  destination_spaceport_id INT(11),
  spaceship_id INT(11),
  CONSTRAINT fk_journeys_spaceports FOREIGN KEY (destination_spaceport_id) REFERENCES spaceports(id),
  CONSTRAINT fk_journeys_spaceships FOREIGN KEY (spaceship_id) REFERENCES spaceships(id)
);

CREATE TABLE travel_cards(
  id INT(11)PRIMARY KEY AUTO_INCREMENT,
  card_number CHAR(10) NOT NULL UNIQUE,
  job_during_journey ENUM ('Pilot','Engineer','Trooper','Cleaner','Cook'),
  colonist_id INT(11),
  journey_id INT(11),
  CONSTRAINT fk_travel_cards_colonists FOREIGN KEY (colonist_id) REFERENCES colonists(id),
  CONSTRAINT fk_travel_cards_journeys FOREIGN KEY (journey_id) REFERENCES journeys(id)
);
#01.	Data Insertion

INSERT INTO travel_cards (card_number, job_during_journey, colonist_id, journey_id)
SELECT
        CASE
           WHEN c.birth_date > '1980-01-01' THEN concat(extract(YEAR FROM c.birth_date),extract(DAY FROM c.birth_date),substring(c.ucn,1,4))
           ELSE concat(extract(YEAR FROM c.birth_date),extract(MONTH FROM c.birth_date), right(c.ucn,4))
           END
           `card_number`,

        CASE
           WHEN c.id % 2 = 0 THEN 'Pilot'
           WHEN c.id % 3 = 0 THEN 'Cook'
           ELSE 'Engineer'
           END
           `job_during_journey`,
        c.id,
       left(c.ucn,1)`journey_id`
FROM colonists c
WHERE c.id BETWEEN 96 AND 100;

#02.	Data Update

UPDATE journeys j
set j.purpose = CASE
    WHEN j.id % 2 = 0 THEN 'Medical'
    WHEN j.id % 3 = 0 THEN 'Technical'
    WHEN j.id % 5 = 0 THEN 'Educational'
    WHEN j.id % 7 = 0 THEN 'Military'
    ELSE j.purpose
    END;

#03.	Data Deletion

delete c
FROM colonists c
LEFT JOIN travel_cards tc ON c.id = tc.colonist_id
LEFT JOIN journeys j ON tc.journey_id = j.id
WHERE j.id is NULL;

#04.Extract all travel cards
SELECT c.card_number,c.job_during_journey FROM travel_cards c
ORDER BY c.card_number;

# 05. Extract all colonists

SELECT c.id, concat(c.first_name,' ',c.last_name), c.ucn FROM colonists c
ORDER BY c.first_name,c.last_name,c.id;

#06.	Extract all military journeys

SELECT j.id, j.journey_start, j.journey_end FROM journeys j
WHERE j.purpose = 'Military'
ORDER BY j.journey_start;

# 07.	Extract all pilots

SELECT c.id, concat(c.first_name,' ', c.last_name) FROM colonists c
JOIN travel_cards t ON c.id = t.colonist_id
WHERE t.job_during_journey = 'Pilot'
ORDER BY c.id;

#08.	Count all colonists that are on technical journey

SELECT count(t.colonist_id) FROM travel_cards t
JOIN journeys j ON t.journey_id = j.id
WHERE j.purpose = 'Technical';

# 09.Extract the fastest spaceship

SELECT s.name,s1.name FROM spaceships s
JOIN journeys j ON s.id = j.spaceship_id
JOIN spaceports s1 ON j.destination_spaceport_id = s1.id
ORDER BY s.light_speed_rate DESC
LIMIT 1;

# 10.Extract spaceships with pilots younger than 30 years

SELECT s.name, s.manufacturer FROM spaceships s
JOIN journeys j on s.id = j.spaceship_id
JOIN travel_cards tc ON j.id = tc.journey_id
JOIN colonists c ON tc.colonist_id = c.id
WHERE tc.job_during_journey = 'Pilot'
AND c.birth_date >= date_sub(str_to_date('01/01/2019', '%m/%d/%Y'),INTERVAL 30 YEAR )
order by  s.name;
#check left/right join

# 11. Extract all educational mission planets and spaceports

SELECT p.name, s.name FROM planets p
JOIN spaceports s ON p.id = s.planet_id
JOIN journeys j ON s.id = j.destination_spaceport_id
WHERE j.purpose = 'Educational'
ORDER BY s.name DESC;

# 12. Extract all planets and their journey count

SELECT p.name, count(j.id) FROM planets p
JOIN spaceports s ON p.id = s.planet_id
JOIN journeys j ON s.id = j.destination_spaceport_id
GROUP BY p.name
ORDER BY count(j.id) DESC ,p.name;

# 13.Extract the shortest journey

SELECT j.id, p.name, s.name, j.purpose FROM journeys j
LEFT JOIN spaceports s ON j.destination_spaceport_id = s.id
left JOIN planets p ON s.planet_id = p.id
ORDER BY DATE (journey_end) - DATE (journey_start)
limit 1;

#14.Extract the less popular job

SELECT (SELECT tc.job_during_journey FROM travel_cards tc
       WHERE longest_journey.id = tc.journey_id
       GROUP BY tc.job_during_journey
       ORDER BY count(tc.id) ASC
       limit 1) as job_name FROM (SELECT * FROM journeys j ORDER BY datediff(j.journey_end,j.journey_start)
    DESC LIMIT 1)`longest_journey`;

#15. Get colonists count
DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet (planet_name VARCHAR (30))
  RETURNS INT
  BEGIN
    DECLARE result INT;
    SET result := (SELECT count(c.id) FROM colonists c
                   JOIN travel_cards tc ON c.id = tc.colonist_id
                   JOIN journeys j ON tc.journey_id = j.id
                   JOIN spaceports s ON j.destination_spaceport_id = s.id
                   JOIN planets p ON s.planet_id = p.id
                   WHERE p.name = planet_name);
    RETURN result;
  END $$

SELECT p.name, udf_count_colonists_by_destination_planet('Otroyphus') AS count
FROM planets AS p
WHERE p.name = 'Otroyphus';

#16. Modify spaceship

CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
  BEGIN
    IF ( (SELECT count(*) FROM spaceships s WHERE s.name = spaceship_name) <> 1)THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Spaceship you are trying to modify does not exists.';
      ROLLBACK ;
      ELSE UPDATE spaceships s2
      SET s2.light_speed_rate = s2.light_speed_rate + light_speed_rate_increse
        WHERE s2.name = spaceship_name;
      END IF ;
  END $$

CALL udp_modify_spaceship_light_speed_rate ('Na Pesho koraba', 1914);
SELECT name, light_speed_rate FROM spacheships WHERE name = 'Na Pesho koraba'


