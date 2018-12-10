
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE screenings;
DROP TABLE films;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
  );

  CREATE TABLE films(
    id SERIAL4 PRIMARY KEY,
    title VARCHAR(255),
    price INT
  );

-- Advanced extension --
  CREATE TABLE screenings(
    id SERIAL4 PRIMARY KEY,
    screening_time VARCHAR(255),
    film_id INT4 REFERENCES films(id)
  );
-----------------
  CREATE TABLE tickets(
    id SERIAL4 PRIMARY KEY,
    customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
    film_id INT4 REFERENCES films(id) ON DELETE CASCADE
  );
