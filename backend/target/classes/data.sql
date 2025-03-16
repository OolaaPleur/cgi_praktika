-- Insert Aircraft Types
INSERT INTO aircraft_type (id, model_name, manufacturer, total_seats) VALUES 
(1, 'E190', 'Embraer', 96),
(2, 'A220-100', 'Airbus', 110);

-- Insert Aircraft Instances (with registration numbers)
INSERT INTO aircraft (id, registration_number, aircraft_type_id) VALUES 
-- E190 aircraft (IDs 1-10)
(1, 'ES-ABA', 1),
(2, 'ES-ABB', 1),
(3, 'ES-ABC', 1),
(4, 'ES-ABD', 1),
(5, 'ES-ABE', 1),
(6, 'ES-ABF', 1),
(7, 'ES-ABG', 1),
(8, 'ES-ABH', 1),
(9, 'ES-ABI', 1),
(10, 'ES-ABJ', 1),

-- A220-100 aircraft (IDs 11-20)
(11, 'ES-ACA', 2),
(12, 'ES-ACB', 2),
(13, 'ES-ACC', 2),
(14, 'ES-ACD', 2),
(15, 'ES-ACE', 2),
(16, 'ES-ACF', 2),
(17, 'ES-ACG', 2),
(18, 'ES-ACH', 2),
(19, 'ES-ACI', 2),
(20, 'ES-ACJ', 2);


-- Insert Seat Configurations for each aircraft type
INSERT INTO seat_configuration (id, class_name, number_of_rows, seat_layout, color, price_multiplier, aircraft_type_id) VALUES 
-- E190 configurations
(1, 'FIRST', 2, 'AB-CD', '#FFD700', 2.5, 1),
(2, 'BUSINESS', 3, 'AB-CD', '#00008B', 1.8, 1),
(3, 'ECONOMY', 19, 'AB-CD', '#008000', 1.0, 1),

-- A220-100 configurations
(4, 'FIRST', 1, 'AB-CDE', '#FFD700', 2.5, 2),
(5, 'BUSINESS', 2, 'AB-CDE', '#00008B', 1.8, 2),
(6, 'ECONOMY', 19, 'AB-CDE', '#008000', 1.0, 2);

-- Insert seats for E190 (4-seat configuration: AB-CD)
-- First Class (Rows 1-2)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'FIRST' as seat_class,
    CASE WHEN letter IN ('A', 'D') THEN true ELSE false END as window_seat,
    CASE WHEN row_number IN ('1') THEN true ELSE false END as exit_row,
    true as extra_legroom,
    1 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 1,2) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D') AS letters(letter)) seats;

-- Business Class (Rows 3-5)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'BUSINESS' as seat_class,
    CASE WHEN letter IN ('A', 'D') THEN true ELSE false END as window_seat,
    false as exit_row,
    true as extra_legroom,
    1 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 3,4,5) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D') AS letters(letter)) seats;

-- Insert Economy Class for E190 (Rows 5-23)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'ECONOMY' as seat_class,
    CASE WHEN letter IN ('A', 'D') THEN true ELSE false END as window_seat,
    false as exit_row,
    CASE WHEN row_number IN ('5', '12', '13') THEN true ELSE false END as extra_legroom,
    1 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D') AS letters(letter)) seats;

-- Insert seats for A220-100 (5-seat configuration: AB-CDE)
-- First Class (Row 1)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'FIRST' as seat_class,
    CASE WHEN letter IN ('A', 'E') THEN true ELSE false END as window_seat,
    CASE WHEN row_number IN ('1') THEN true ELSE false END as exit_row,
    true as extra_legroom,
    2 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 1) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D','E') AS letters(letter)) seats;

-- Business Class (Rows 2-3)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'BUSINESS' as seat_class,
    CASE WHEN letter IN ('A', 'E') THEN true ELSE false END as window_seat,
    false as exit_row,
    true as extra_legroom,
    2 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 2,3) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D','E') AS letters(letter)) seats;

-- Insert Economy Class for A220-100 (Rows 4-22)
INSERT INTO seat (seat_number, seat_class, window_seat, exit_row, extra_legroom, aircraft_type_id)
SELECT 
    CONCAT(row_number, letter) as seat_number,
    'ECONOMY' as seat_class,
    CASE WHEN letter IN ('A', 'E') THEN true ELSE false END as window_seat,
    false as exit_row,
    CASE WHEN row_number IN ('4', '12', '13') THEN true ELSE false END as extra_legroom,
    2 as aircraft_type_id
FROM 
    (SELECT * FROM (VALUES 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22) AS nums(row_number)) rows,
    (SELECT * FROM (VALUES 'A','B','C','D','E') AS letters(letter)) seats;

-- Insert unique airports
INSERT INTO airport (name, photo_id, arrival_continent) VALUES
('Tallinn', '3224113', 'Europe'),
('London', '672532', 'Europe'),
('Frankfurt', '2106452', 'Europe'),
('Paris', '3922718', 'Europe'),
('Amsterdam', '2031706', 'Europe'),
('Copenhagen', '416024', 'Europe'),
('Stockholm', '1529040', 'Europe'),
('Helsinki', '2311602', 'Europe'),
('Riga', '681405', 'Europe'),
('Warsaw', '10676', 'Europe'),
('Oslo', '2360665', 'Europe'),
('Berlin', '2570063', 'Europe'),
('New York', '466685', 'North America'),
('Los Angeles', '3410816', 'North America'),
('Tokyo', '2614818', 'Asia'),
('Dubai', '1707310', 'Asia'),
('Singapore', '777059', 'Asia'),
('Sydney', '1619854', 'Australia'),
('Johannesburg', '2464890', 'Africa'),
('Sao Paulo', '97906', 'South America'),
('Buenos Aires', '1060803', 'South America'),
('Mexico City', '604661', 'North America');

INSERT INTO company (name, photo_id) VALUES
('airBaltic', 'airbaltic.com'),
('Lufthansa', 'lufthansacityline.com'),
('KLM', 'klm.com'),
('SAS', 'sas.com'),
('Finnair', 'finnair.com'),
('LOT', 'lot.com'),
('Norwegian', 'norwegian.com'),
('United Airlines', 'united.com'),
('Emirates', 'emirates.com'),
('Singapore Airlines', 'singaporeair.com'),
('Qantas', 'qantas.com'),
('South African Airways', 'flysaa.com'),
('LATAM Airlines', 'latam.com'),
('Aeromexico', 'aeromexico.com');

-- Insert flights for each aircraft
INSERT INTO flight (departure_airport_id, arrival_airport_id, departure_date_time, arrival_date_time, flight_duration_minutes, price, company_id, aircraft_id)
VALUES
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'London'), '2025-04-20 08:00:00', '2025-04-20 09:45:00', 105, 159.99, (SELECT id FROM company WHERE name = 'airBaltic'), 1),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Frankfurt'), '2025-04-20 10:30:00', '2025-04-20 12:00:00', 90, 129.99, (SELECT id FROM company WHERE name = 'Lufthansa'), 6),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Paris'), '2025-04-21 07:15:00', '2025-04-21 09:30:00', 135, 179.99, (SELECT id FROM company WHERE name = 'airBaltic'), 2),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Amsterdam'), '2025-04-21 14:00:00', '2025-04-21 15:45:00', 105, 149.99, (SELECT id FROM company WHERE name = 'KLM'), 7),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Copenhagen'), '2025-04-22 09:00:00', '2025-04-22 10:15:00', 75, 119.99, (SELECT id FROM company WHERE name = 'SAS'), 3),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Stockholm'), '2025-04-22 16:30:00', '2025-04-22 17:30:00', 60, 99.99, (SELECT id FROM company WHERE name = 'Finnair'), 8),
((SELECT id FROM airport WHERE name = 'Helsinki'), (SELECT id FROM airport WHERE name = 'Tallinn'), '2025-04-20 07:00:00', '2025-04-20 07:30:00', 30, 69.99, (SELECT id FROM company WHERE name = 'Finnair'), 4),
((SELECT id FROM airport WHERE name = 'Riga'), (SELECT id FROM airport WHERE name = 'Warsaw'), '2025-04-21 11:00:00', '2025-04-21 12:15:00', 75, 109.99, (SELECT id FROM company WHERE name = 'LOT'), 9),
((SELECT id FROM airport WHERE name = 'Stockholm'), (SELECT id FROM airport WHERE name = 'Oslo'), '2025-04-22 13:00:00', '2025-04-22 14:00:00', 60, 89.99, (SELECT id FROM company WHERE name = 'Norwegian'), 5),
((SELECT id FROM airport WHERE name = 'Copenhagen'), (SELECT id FROM airport WHERE name = 'Berlin'), '2025-04-23 10:00:00', '2025-04-23 11:15:00', 75, 119.99, (SELECT id FROM company WHERE name = 'SAS'), 10),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'New York'), '2025-04-24 12:00:00', '2025-04-24 15:00:00', 540, 499.99, (SELECT id FROM company WHERE name = 'United Airlines'), 11),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Dubai'), '2025-04-25 22:00:00', '2025-04-26 06:00:00', 360, 399.99, (SELECT id FROM company WHERE name = 'Emirates'), 12),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Singapore'), '2025-04-26 18:00:00', '2025-04-27 10:00:00', 720, 599.99, (SELECT id FROM company WHERE name = 'Singapore Airlines'), 13),
((SELECT id FROM airport WHERE name = 'Tallinn'), (SELECT id FROM airport WHERE name = 'Sydney'), '2025-04-27 20:00:00', '2025-04-28 12:00:00', 960, 749.99, (SELECT id FROM company WHERE name = 'Qantas'), 14),
((SELECT id FROM airport WHERE name = 'New York'), (SELECT id FROM airport WHERE name = 'London'), '2025-04-28 08:30:00', '2025-04-28 20:30:00', 420, 549.99, (SELECT id FROM company WHERE name = 'United Airlines'), 15),
((SELECT id FROM airport WHERE name = 'Los Angeles'), (SELECT id FROM airport WHERE name = 'Tokyo'), '2025-04-29 15:00:00', '2025-04-30 08:00:00', 780, 899.99, (SELECT id FROM company WHERE name = 'Singapore Airlines'), 16),
((SELECT id FROM airport WHERE name = 'Dubai'), (SELECT id FROM airport WHERE name = 'Johannesburg'), '2025-04-29 23:00:00', '2025-04-30 06:00:00', 420, 329.99, (SELECT id FROM company WHERE name = 'South African Airways'), 17),
((SELECT id FROM airport WHERE name = 'Sao Paulo'), (SELECT id FROM airport WHERE name = 'Buenos Aires'), '2025-04-30 10:00:00', '2025-04-30 12:00:00', 120, 159.99, (SELECT id FROM company WHERE name = 'LATAM Airlines'), 18),
((SELECT id FROM airport WHERE name = 'Mexico City'), (SELECT id FROM airport WHERE name = 'Los Angeles'), '2025-04-30 14:30:00', '2025-04-30 18:00:00', 210, 219.99, (SELECT id FROM company WHERE name = 'Aeromexico'), 19),
((SELECT id FROM airport WHERE name = 'Singapore'), (SELECT id FROM airport WHERE name = 'Sydney'), '2025-04-30 22:00:00', '2025-05-01 06:30:00', 510, 499.99, (SELECT id FROM company WHERE name = 'Qantas'), 20);


-- Initialize seat reservations for all flights and seats
INSERT INTO seat_reservation (flight_id, seat_id, reserved)
SELECT f.id, s.id, FALSE
FROM flight f
JOIN aircraft a ON f.aircraft_id = a.id
JOIN seat s ON s.aircraft_type_id = a.aircraft_type_id;