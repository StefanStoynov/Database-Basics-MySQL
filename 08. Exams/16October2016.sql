CREATE TABLE towns(
  town_id INT(11) PRIMARY KEY,
  town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports(
  airport_id INT(11) PRIMARY KEY ,
  airport_name VARCHAR(50) NOT NULL,
  town_id INT(11),
  CONSTRAINT fk_airports_towns FOREIGN KEY (town_id) REFERENCES towns(town_id)
);

CREATE TABLE airlines(
  airline_id INT(11) PRIMARY KEY ,
  airline_name VARCHAR(30) NOT NULL,
  nationality VARCHAR(30) NOT NULL,
  rating INT(11) DEFAULT 0
);

CREATE TABLE customers(
  customer_id INT(11) PRIMARY KEY ,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(1),
  home_town_id INT(11),
  CONSTRAINT fk_customers_towns FOREIGN KEY (home_town_id) REFERENCES towns(town_id),
  CHECK (gender='M' OR gender='F')
);

CREATE TABLE flights(
  flight_id INT(11) PRIMARY KEY ,
  departure_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL,
  status VARCHAR(9) NOT NULL,
  origin_airport_id INT(11),
  destination_airport_id INT(11),
  airline_id INT(11),
  CONSTRAINT fk_flights_origin_airports FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
  CONSTRAINT fk_flights_destination_airports FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id),
  CONSTRAINT fk_flights_airlines FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
  CHECK (status IN ('Departing','Delayed','Arrived','Cancelled'))
);

CREATE TABLE tickets(
  ticket_id INT(11) PRIMARY KEY ,
  price DECIMAL(8,2) NOT NULL,
  class VARCHAR(6),
  seat VARCHAR(5) NOT NULL,
  customer_id INT(11),
  flight_id INT(11),
  CONSTRAINT fk_tickets_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_tickets_flights FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
  CHECK (class IN ('First','Second','Third'))
);