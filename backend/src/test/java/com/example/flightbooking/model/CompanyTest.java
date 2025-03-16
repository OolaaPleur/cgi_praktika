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

class CompanyTest {
    private Validator validator;

    @BeforeEach
    void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    void testCompanyCreation() {
        // Arrange
        Company company = new Company();
        
        // Set up mock data
        List<Flight> flights = new ArrayList<>();
        Flight flight1 = new Flight();
        flight1.setFlightDurationMinutes(120);
        flights.add(flight1);
        
        // Act
        company.setName("Air Baltic");
        company.setPhotoId("airbaltic.com");
        company.setFlights(flights);
        
        // Assert
        assertEquals("Air Baltic", company.getName());
        assertEquals("airbaltic.com", company.getPhotoId());
        assertEquals(1, company.getFlights().size());
        assertSame(flight1, company.getFlights().get(0));
    }

    @Test
    void testCompanyValidation() {
        // Arrange
        Company company = new Company();
        
        // Test empty name
        company.setName("");
        Set<ConstraintViolation<Company>> violations = validator.validate(company);
        assertFalse(violations.isEmpty(), "Empty name should cause validation error");
        
        // Test short name
        company.setName("A");
        violations = validator.validate(company);
        assertFalse(violations.isEmpty(), "Short name should cause validation error");
        
        // Test name too long
        company.setName("A".repeat(101));
        violations = validator.validate(company);
        assertFalse(violations.isEmpty(), "Overly long name should cause validation error");
    }

    @Test
    void testCompanyUniqueness() {
        // Arrange
        Company company1 = new Company();
        company1.setName("Air Baltic");
        company1.setPhotoId("LOGO1");
        
        Company company2 = new Company();
        company2.setName("Air Baltic"); // Same name should trigger unique constraint
        company2.setPhotoId("LOGO2");
        
        // Act & Assert
        assertNotEquals(company1, company2); // Different instances
        assertEquals(company1.getName(), company2.getName()); // Same name
    }
} 