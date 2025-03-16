CREATE TABLE aircraft_type (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(255),
    manufacturer VARCHAR(255),
    total_seats INTEGER
);

CREATE TABLE airport (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    arrival_continent VARCHAR(255),
    photo_id VARCHAR(255)
);

CREATE TABLE company (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    photo_id VARCHAR(255)
);

CREATE TABLE aircraft (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(255),
    aircraft_type_id BIGINT,
    FOREIGN KEY (aircraft_type_id) REFERENCES aircraft_type(id)
);

CREATE TABLE seat_configuration (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(255),
    number_of_rows INTEGER,
    seat_layout VARCHAR(255),
    color VARCHAR(255),
    price_multiplier DOUBLE,
    aircraft_type_id BIGINT,
    FOREIGN KEY (aircraft_type_id) REFERENCES aircraft_type(id)
);

CREATE TABLE seat (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    seat_number VARCHAR(255),
    seat_class VARCHAR(255),
    window_seat BOOLEAN,
    exit_row BOOLEAN,
    extra_legroom BOOLEAN,
    aircraft_type_id BIGINT,
    FOREIGN KEY (aircraft_type_id) REFERENCES aircraft_type(id)
);

CREATE TABLE flight (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    departure_airport_id BIGINT,
    arrival_airport_id BIGINT,
    departure_date_time TIMESTAMP,
    arrival_date_time TIMESTAMP,
    flight_duration_minutes INTEGER,
    price DOUBLE,
    company_id BIGINT,
    aircraft_id BIGINT,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(id),
    FOREIGN KEY (company_id) REFERENCES company(id)
);

CREATE TABLE seat_reservation (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    flight_id BIGINT,
    seat_id BIGINT,
    reserved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (flight_id) REFERENCES flight(id),
    FOREIGN KEY (seat_id) REFERENCES seat(id)
);