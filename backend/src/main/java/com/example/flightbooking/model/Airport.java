package com.example.flightbooking.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
@Entity
@Table(name = "airport")
public class Airport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    @NotBlank(message = "Airport name cannot be blank")
    @Size(min = 2, max = 100, message = "Airport name must be between 2 and 100 characters")
    private String name;

    @Column(name = "photo_id", nullable = false)
    @NotBlank(message = "Photo ID cannot be blank")
    private String photoId;

    @Column(name = "arrival_continent", nullable = false)
    @NotBlank(message = "Arrival continent cannot be blank")
    @Size(max = 50, message = "Arrival continent must be less than 50 characters")
    private String arrivalContinent;
}

