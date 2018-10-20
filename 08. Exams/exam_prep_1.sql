# 01.	Table Design
CREATE TABLE towns(
  town_id INT(11)PRIMARY KEY,
  town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports(
  airport_id INT(11)PRIMARY KEY,
  airport_name VARCHAR(50) NOT NULL,
  town_id INT(11),
  CONSTRAINT fk_airports_towns FOREIGN KEY (town_id) REFERENCES towns(town_id)
);

CREATE TABLE airlines(
  airline_id INT(11)PRIMARY KEY,
  airline_name VARCHAR(30) NOT NULL,
  nationality VARCHAR(30) NOT NULL,
  rating INT(11) DEFAULT 0
);

CREATE TABLE customers(
  customer_id INT(11)PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(1) CHECK ('M' or 'F'),
  home_town_id INT(11),
  CONSTRAINT fk_customers_towns FOREIGN KEY (home_town_id) REFERENCES towns(town_id)
);

CREATE TABLE flights(
  flight_id INT(11)PRIMARY KEY AUTO_INCREMENT,
  departure_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL,
  status VARCHAR(9) CHECK ('Departing' OR 'Delayed' OR 'Arrived' OR 'Cancelled'),
  origin_airport_id INT(11),
  destination_airport_id INT(11),
  airline_id INT(11),
  CONSTRAINT fk_flights_origin_airports FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
  CONSTRAINT fk_flights_destination_airports FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id),
  CONSTRAINT fk_flights_airlines FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE tickets(
  ticket_id INT(11)PRIMARY KEY AUTO_INCREMENT,
  price DECIMAL(8,2) NOT NULL,
  class VARCHAR(6) CHECK ('First' OR 'Second' OR 'Third'),
  seat VARCHAR(5) NOT NULL ,
  customer_id INT(11),
  flight_id INT(11),
  CONSTRAINT fk_tickets_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_tickets_flights FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

#02.	Data Insertion

INSERT INTO flights(departure_time, arrival_time, status, origin_airport_id, destination_airport_id, airline_id)
SELECT
         ('2017-06-19 14:00:00')`departure_time`,
         ('2017-06-21 11:00:00')`arrival_time`,
         case (a.airline_id % 4)
             WHEN 0 THEN 'Departing'
             WHEN 1 THEN 'Delayed'
             WHEN 2 THEN 'Arrived'
             WHEN 3 THEN 'Canceled'
         END `status`,
         ceil(SQRT(char_length(a.airline_name)))`origin_airport_id`,
         ceil(SQRT(char_length(a.nationality)))`destination_airport_id`,
         a.airline_id `airline_id`
FROM airlines a
WHERE airline_id BETWEEN 1 AND 10;

#03.	Update Arrived Flights

UPDATE flights f
SET f.airline_id = 1
WHERE f.status = 'Arrived';

#04.	Update Tickets

UPDATE tickets t
JOIN flights f ON t.flight_id = f.flight_id
JOIN airlines a ON f.airline_id = a.airline_id
SET t.price = t.price * 1.5
WHERE a.rating = (SELECT max(rating)FROM airlines);

