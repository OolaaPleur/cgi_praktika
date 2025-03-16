package com.example.flightbooking.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDateTime;

class FlightTest {

    @Test
    void testFlightCreation() {
        // Arrange
        Flight flight = new Flight();
        
        // Set up mock data
        Airport departureAirport = new Airport();
        departureAirport.setName("Tallinn");
        
        Airport arrivalAirport = new Airport();
        arrivalAirport.setName("Helsinki");
        
        Company company = new Company();
        company.setName("Air Baltic");
        
        Aircraft aircraft = new Aircraft();
        aircraft.setRegistrationNumber("ABC123");
        
        LocalDateTime departureTime = LocalDateTime.now();
        LocalDateTime arrivalTime = departureTime.plusHours(2);
        
        // Act
        flight.setDepartureAirport(departureAirport);
        flight.setArrivalAirport(arrivalAirport);
        flight.setCompany(company);
        flight.setAircraft(aircraft);
        flight.setDepartureDateTime(departureTime);
        flight.setArrivalDateTime(arrivalTime);
        flight.setFlightDurationMinutes(120); // 2 hours
        flight.setPrice(50.0);
        
        // Assert
        assertSame(departureAirport, flight.getDepartureAirport());
        assertSame(arrivalAirport, flight.getArrivalAirport());
        assertSame(company, flight.getCompany());
        assertSame(aircraft, flight.getAircraft());
        assertEquals(departureTime, flight.getDepartureDateTime());
        assertEquals(arrivalTime, flight.getArrivalDateTime());
        assertEquals(120, flight.getFlightDurationMinutes());
        assertEquals(50.0, flight.getPrice());
    }
} 