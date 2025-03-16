package com.example.flightbooking.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Data;
import java.util.List;

@Data
@Entity
@Table(name = "aircraft_type")
public class AircraftType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "model_name")
    @NotBlank(message = "Model name cannot be blank")
    @Size(min = 2, max = 100, message = "Model name must be between 2 and 100 characters")
    private String modelName;
    
    @Column
    @NotBlank(message = "Manufacturer cannot be blank")
    @Size(min = 2, max = 100, message = "Manufacturer must be between 2 and 100 characters")
    private String manufacturer;
    
    @Column(name = "total_seats")
    @Positive(message = "Total seats must be a positive number")
    private Integer totalSeats;
    
    @OneToMany(mappedBy = "aircraftType", fetch = FetchType.LAZY)
    @JsonBackReference
    private List<SeatConfiguration> configurations;
    
    @OneToMany(mappedBy = "aircraftType", fetch = FetchType.LAZY)
    @JsonBackReference
    private List<Aircraft> aircraft;
    
    @OneToMany(mappedBy = "aircraftType", fetch = FetchType.LAZY)
    @JsonBackReference
    private List<Seat> seats;
} 