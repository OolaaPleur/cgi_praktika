package com.example.flightbooking.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
@Entity
@Table(name = "seat_configuration")
public class SeatConfiguration {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "class_name")
    @Enumerated(EnumType.STRING)
    private SeatClass className;
    
    @Column(name = "number_of_rows")
    @Positive(message = "Number of rows must be positive")
    @Max(value = 100, message = "Number of rows cannot exceed 100")
    private Integer numberOfRows;
    
    @Column(name = "seat_layout")
    @Size(min = 3, max = 20, message = "Seat layout must be between 3 and 20 characters")
    private String seatLayout;
    
    private String color;
    
    @Column(name = "price_multiplier")
    @Positive(message = "Price multiplier must be positive")
    @Max(value = 10, message = "Price multiplier cannot exceed 10")
    private Double priceMultiplier;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aircraft_type_id")
    @JsonBackReference
    private AircraftType aircraftType;
} 