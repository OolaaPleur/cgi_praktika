package com.example.flightbooking.model;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Set;
import java.util.ArrayList;
import java.util.List;

class AircraftTest {
    private Validator validator;

    @BeforeEach
    void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    void testAircraftCreation() {
        // Arrange
        Aircraft aircraft = new Aircraft();
        
        // Set up mock data
        AircraftType aircraftType = new AircraftType();
        aircraftType.setModelName("Boeing 737");
        aircraftType.setManufacturer("Boeing");
        aircraftType.setTotalSeats(180);
        
        List<Flight> flights = new ArrayList<>();
        Flight flight1 = new Flight();
        flight1.setFlightDurationMinutes(120);
        flights.add(flight1);
        
        // Act
        aircraft.setRegistrationNumber("EE-ABC");
        aircraft.setAircraftType(aircraftType);
        aircraft.setFlights(flights);
        
        // Assert
        assertEquals("EE-ABC", aircraft.getRegistrationNumber());
        assertSame(aircraftType, aircraft.getAircraftType());
        assertEquals(1, aircraft.getFlights().size());
        assertSame(flight1, aircraft.getFlights().get(0));
    }

    @Test
    void testAircraftValidation() {
        // Arrange
        Aircraft aircraft = new Aircraft();
        
        // Test empty registration number
        aircraft.setRegistrationNumber("");
        Set<ConstraintViolation<Aircraft>> violations = validator.validate(aircraft);
        assertFalse(violations.isEmpty(), "Empty registration number should cause validation error");
        
        // Test short registration number
        aircraft.setRegistrationNumber("A");
        violations = validator.validate(aircraft);
        assertFalse(violations.isEmpty(), "Short registration number should cause validation error");
    }
} 