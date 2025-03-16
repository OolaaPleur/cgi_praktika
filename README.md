# Flight Booking System

## Overview
This project is a **Flight Booking System**

- Design partially nspired by **Horizone Flight Page**
- A backend built with **Spring Boot 3.2.3**.
- A frontend built with **Flutter**.
- Integration with **Pexels API** for city photos.
- **Logo fetching** via **Brandfetch API**.
- **H2 in-memory database** for development and testing.
- **Swagger OpenAPI** for API documentation.

## Project Access
### Local Development URLs
- **Backend**: http://localhost:8080
  - Swagger OpenAPI: http://localhost:8080/swagger-ui/index.html#/
- **Frontend**: http://localhost:80

## Getting Started
### Running the Application
To start the entire application, use Docker Compose:
```bash
docker compose up --build
```

## UI Inspiration & Assets
- **Design inspiration**: [Horizone Flight Page on Dribbble](https://dribbble.com/shots/23454376-Horizone-Flight-Page)
- **Search background image**: [Pexels](https://www.pexels.com/photo/airliner-mirror-view-127905/)
- **Frontend icon & database data**: **Partially AI-generated**

## Not developed
- **Flight company API**: Considered but had a **limited free request quota**.

## Technologies Used
- **Backend**: Spring Boot (Web, JPA, Validation)
- **Database**: H2 (in-memory)
- **API Integration**:
  - [Brandfetch API](https://brandfetch.com) (Logos) → *1M requests/month, used on frontend (with caching).*
  - [Pexels API](https://pexels.com) (City Photos) → *200 requests/hour, 20K/month, used on backend (with caching).*
- **Swagger OpenAPI**: API documentation
- **Lombok**: For reducing boilerplate code
- **MapStruct**: DTO mapping
- **JUnit 5**: Testing
