# Flight Booking System

A Spring Boot application that manages flights and seat reservations.

## Technologies Used

- Java 21
- Spring Boot 3.2.3
- Spring Data JPA
- H2 Database
- Lombok
- MapStruct
- OpenAPI (Swagger) UI
- Maven

## Features

- RESTful API for flight management
- Database persistence with H2
- OpenAPI documentation
- Data validation
- DTO mapping with MapStruct

## Prerequisites

- Java 21 or higher
- Maven

## API Documentation

The API documentation is available through Swagger UI at:
```
http://localhost:8080/swagger-ui.html
```

## Database

The application uses an H2 in-memory database. You can access the H2 console at:
```
http://localhost:8080/h2-console
```

Default H2 Console configuration:
- JDBC URL: `jdbc:h2:mem:flightdb`
- Username: `sa`
- Password: (empty)

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── example/
│   │           └── flightbooking/
│   └── resources/
│       ├── application.properties
│       └── data.sql
```

## Building

To build the project:
```bash
mvn clean install
```

This will:
1. Clean the target directory
2. Compile the source code
3. Run tests
4. Create an executable JAR file

## API Endpoints

### GET /api/flights
Returns a list of all available flights.

Response format:
```json
[
  {
    "id": 0,
    "departureAirport": "string",
    "arrivalAirport": "string",
    "departureDateTime": "2024-03-16T10:00:00",
    "arrivalDateTime": "2024-03-16T12:00:00",
    "flightDurationMinutes": 120,
    "price": 299.99,
    "companyName": "string",
    "companyPhotoId": "string",
    "aircraftId": 0,
    "departureAirportImageUrl": "string",
    "arrivalAirportImageUrl": "string",
    "arrivalContinent": "string"
  }
]
```

### GET /api/flights/{id}
Returns detailed information about a specific flight, including aircraft and seat information.

Response format:
```json
{
  "id": 0,
  "departureAirport": "string",
  "arrivalAirport": "string",
  "departureDateTime": "2024-03-16T10:00:00",
  "arrivalDateTime": "2024-03-16T12:00:00",
  "flightDurationMinutes": 120,
  "price": 299.99,
  "companyName": "string",
  "companyPhotoId": "string",
  "departureAirportImageUrl": "string",
  "arrivalAirportImageUrl": "string",
  "arrivalContinent": "string",
  "aircraft": {
    "id": 0,
    "modelName": "string",
    "manufacturer": "string",
    "totalSeats": 0,
    "configurations": [
      {
        "className": "string",
        "numberOfRows": 0,
        "seatLayout": "string",
        "color": "string",
        "priceMultiplier": 0
      }
    ],
    "seats": [
      {
        "id": 0,
        "seatNumber": "string",
        "seatClass": "string",
        "windowSeat": true,
        "extraLegroom": true,
        "reserved": true,
        "exitRow": true
      }
    ]
  }
}
```

### PUT /api/flights/{flightId}/seats
Reserve seats for a flight.

Request format:
```json
{
  "seatNumbers": [
    "1A",
    "1B"
  ]
}
```

Response codes:
- 200 OK: Seats successfully reserved
- 400 Bad Request: Invalid request or seats already reserved
- 404 Not Found: Flight not found or seats not found

### GET /api/images/{photoId}
Returns the original image for a given photo ID.

Response:
- 200 OK: Returns the image file (JPEG format)
- 404 Not Found: Image not found

### GET /api/images/medium/{photoId}
Returns a resized version (600px width) of the image for a given photo ID.

Response:
- 200 OK: Returns the resized image file (JPEG format)
- 404 Not Found: Image not found
- 500 Internal Server Error: Error processing the image 

## Testing the Application

### Running Tests

To run all tests in the project, use the following Maven command:
```bash
mvn test
```