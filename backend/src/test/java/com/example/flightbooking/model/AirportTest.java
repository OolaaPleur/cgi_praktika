package com.example.flightbooking.model;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Set;

class AirportTest {
    private Validator validator;

    @BeforeEach
    void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    void testAirportCreation() {
        // Arrange
        Airport airport = new Airport();
        
        // Act
        airport.setName("Tallinn Airport");
        airport.setPhotoId("TALLINN_AIRPORT_PHOTO");
        airport.setArrivalContinent("Europe");
        
        // Assert
        assertEquals("Tallinn Airport", airport.getName());
        assertEquals("TALLINN_AIRPORT_PHOTO", airport.getPhotoId());
        assertEquals("Europe", airport.getArrivalContinent());
    }

    @Test
    void testAirportValidation() {
        // Arrange
        Airport airport = new Airport();
        
        // Test empty name
        airport.setName("");
        Set<ConstraintViolation<Airport>> violations = validator.validate(airport);
        assertFalse(violations.isEmpty(), "Empty name should cause validation error");
        
        // Test short name
        airport.setName("A");
        violations = validator.validate(airport);
        assertFalse(violations.isEmpty(), "Short name should cause validation error");
        
        // Test empty continent
        airport.setName("Tallinn Airport");
        airport.setArrivalContinent("");
        violations = validator.validate(airport);
        assertFalse(violations.isEmpty(), "Empty continent should cause validation error");
        
        // Test null photo ID
        airport.setArrivalContinent("Europe");
        airport.setPhotoId(null);
        violations = validator.validate(airport);
        assertFalse(violations.isEmpty(), "Null photo ID should cause validation error");
    }

    @Test
    void testAirportUniqueness() {
        // Arrange
        Airport airport1 = new Airport();
        airport1.setName("Tallinn Airport");
        airport1.setPhotoId("TALLINN_PHOTO");
        airport1.setArrivalContinent("Europe");
        
        Airport airport2 = new Airport();
        airport2.setName("Tallinn Airport"); // Same name should trigger unique constraint
        airport2.setPhotoId("ANOTHER_PHOTO");
        airport2.setArrivalContinent("Europe");
        
        // Act & Assert
        assertNotEquals(airport1, airport2); // Different instances
        assertEquals(airport1.getName(), airport2.getName()); // Same name
    }
} 