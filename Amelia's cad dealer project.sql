CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY, 
  full_name VARCHAR(50),
  phone VARCHAR(30),
  address VARCHAR(100),
  email VARCHAR(50)

);


CREATE TABLE parts (
  parts_id SERIAL PRIMARY KEY,
  invoice_id VARCHAR(50)
  
);


CREATE TABLE Service (
  service_id SERIAL PRIMARY KEY,
  order_date DATE,
  service_date VARCHAR(50),
  next_service VARCHAR(50),
  service_invoice VARCHAR(50),
  service_invoice_id INTEGER,
  parts_id INTEGER,
  FOREIGN KEY (service_id) REFERENCES service(service_id)
);


CREATE TABLE Invoice (
  invoice_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  billing_address VARCHAR(100),
  payment_medhod VARCHAR(50),
  card_number VARCHAR(50),
  service_invoice VARCHAR(50),
  salesperson_id INTEGER,
  customer_id INTEGER,
  service_id INTEGER,
  FOREIGN KEY (service_id) REFERENCES service(service_id)
);


CREATE TABLE cars (
  car_id SERIAL PRIMARY KEY,
  price NUMERIC(6,2),
  description_serial_number VARCHAR(200),
  model VARCHAR(50),
  make VARCHAR(100),
  invoice_id INTEGER,
  FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

	
	
CREATE TABLE Salesperson (
  salesperson_id SERIAL PRIMARY KEY,
  full_name  VARCHAR(50),
  user_name  VARCHAR(50)
  
  
);

	
CREATE TABLE mechanics  (
  mechanic_id SERIAL PRIMARY KEY, 
  full_name VARCHAR(50),
  user_name VARCHAR(50),
  service_date VARCHAR(50),
  service_id INTEGER
  
);

	
CREATE TABLE service_invoice (
  service_invoice_id SERIAL PRIMARY KEY, 
  service_type VARCHAR(50),
  service_date DATE,
  basic_service VARCHAR(50),
  mechanic_id VARCHAR(50),
  premium_service VARCHAR(50)

);

DROP TABLE service_invoice, mechanics, Salesperson, cars, Invoice, Service, parts, Customer CASCADE


CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  phone VARCHAR(30),
  address VARCHAR(100),
  email VARCHAR(50)
 );


CREATE TABLE parts (
  parts_id SERIAL PRIMARY KEY ,
  invoice_id VARCHAR(50)
);


CREATE TABLE Service (
  service_id SERIAL PRIMARY KEY,
  order_date DATE,
  service_date DATE,
  next_service DATE,
  service_invoice VARCHAR(50),
  service_invoice_id INTEGER,
  parts_id INTEGER,
  FOREIGN KEY (service_invoice_id) REFERENCES service_invoice(service_invoice_id),
  FOREIGN KEY (parts_id) REFERENCES parts(parts_id)
);


CREATE TABLE Invoice (
  invoice_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  billing_address VARCHAR(100),
  payment_medhod VARCHAR(50),
  card_number VARCHAR(50),
  service_invoice VARCHAR(50),
  salesperson_id INTEGER,
  customer_id INTEGER,
  service_id INTEGER,
  FOREIGN KEY (salesperson_id)  REFERENCES Salesperson(salesperson_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (service_id) REFERENCES service(service_id)
);


CREATE TABLE cars (
  car_id SERIAL PRIMARY KEY ,
  price NUMERIC(6,2),
  description_serial_number VARCHAR(200),
  model VARCHAR(50),
  make VARCHAR(100),
  invoice_id INTEGER,
  FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);


CREATE TABLE Salesperson (
  salesperson_id SERIAL PRIMARY KEY,
  full_name  VARCHAR(50),
  user_name  VARCHAR(50)
);


CREATE TABLE mechanics  (
  mechanic_id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  user_name VARCHAR(50),
  service_date VARCHAR(50),
  service_id INTEGER
);


CREATE TABLE service_invoice (
  service_invoice_id SERIAL PRIMARY KEY,
  service_type VARCHAR(50),
  service_date DATE,
  basic_service VARCHAR(50),
  mechanic_id VARCHAR(50),
  premium_service VARCHAR(50)
);


SELECT *
FROM customer;

INSERT INTO customer
VALUES ('1', 'Berik Baibatyr', '343-454-6655', '122 Main st.', 'berik@gmail.com')
INSERT INTO customer
VALUES ('2', 'Kym Baibatyr', '343-444-6655', '123 Main st.', 'kym@gmail.com')
INSERT INTO customer
VALUES ('3', 'Amelia Baibatyr', '333-444-6666', '133 Main st.', 'amelia@gmail.com')
INSERT INTO customer
VALUES ('4', 'Asanali Baibatyr', '344-444-5555', '144 Main st.', 'asanali@gmail.com')
	


SELECT *
FROM Salesperson;

INSERT INTO Salesperson
VALUES ('1', 'John Snow', 'Iceman')
INSERT INTO Salesperson
VALUES ('2', 'Daenerys Targaryen', 'Dragmom')
INSERT INTO Salesperson
VALUES ('3', 'Arya Stark', 'Needle')


SELECT *
FROM invoice
INSERT INTO invoice
VALUES ('1', 'Tyrion Lannister', '777 Westeros Ave', 'gold_coins', '111111111', '1', '1', '3', '1');


SELECT *
FROM service_invoice
INSERT INTO service_invoice
VALUES ('1', 'oil change', '2019.11.11', 'filter_change', 'ZZZ767', 'tire rotation');



SELECT *
FROM service
INSERT INTO service
VALUES ('1', '2020.05.05', '2020.11.11', '2021.05.05', '1', '1', '1');


SELECT *
FROM cars;

INSERT INTO cars
VALUES ('1', '1250.00', 'RR112233', 'RangeRover', 'Sport', '1')
INSERT INTO cars
VALUES ('2', '2120.00', 'BMW112233', 'BMW', 'XM', '1')
INSERT INTO cars
VALUES ('3', '202.00', 'M123123', 'Mercedes', 'S550', '1');

SELECT *
FROM parts;

INSERT INTO parts
VALUES ('1', '1')



CREATE OR REPLACE FUNCTION add_salesperson(
    _salesperson_id INTEGER,
    _first_name VARCHAR(50),
    _last_name VARCHAR(50)
)
RETURNS void
LANGUAGE plpgsql
AS $$ 
BEGIN
    INSERT INTO salesperson
    VALUES (_salesperson_id, _first_name, _last_name);
END;
$$;



-- After your database is complete ADD a column to your vehicle table 
-- called "is_serviced"
-- Create a procedure to update a purchased vehicle's  service 
-- boolean if it had not previously received service but then comes 
-- in for an oil change. 

SELECT *
FROM cars;

ALTER TABLE cars
ADD COLUMN is_serviced VARCHAR(50);

CREATE OR REPLACE PROCEDURE is_serviced(_car_id INTEGER)
LANGUAGE plpgsql
AS $$
	BEGIN
		UPDATE cars
		SET is_serviced = TRUE
		WHERE car_id IN (
			SELECT car_id
			FROM cars
			
		);

		UPDATE cars
		SET is_serviced = FALSE
		WHERE car_id IN (
			SELECT car_id
			FROM cars
			
		);
		COMMIT;
	END;
$$;

CALL is_serviced();

SELECT *
FROM cars
