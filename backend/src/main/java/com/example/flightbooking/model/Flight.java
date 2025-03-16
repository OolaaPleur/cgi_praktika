package com.example.flightbooking.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
public class Flight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "departure_airport_id", nullable = false)
    @NotNull(message = "Departure airport is required")
    private Airport departureAirport;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "arrival_airport_id", nullable = false)
    @NotNull(message = "Arrival airport is required")
    private Airport arrivalAirport;

    @Column(name = "departure_date_time", nullable = false)
    @NotNull(message = "Departure date and time are required")
    private LocalDateTime departureDateTime;

    @Column(name = "arrival_date_time", nullable = false)
    @NotNull(message = "Arrival date and time are required")
    private LocalDateTime arrivalDateTime;

    @Column(name = "flight_duration_minutes", nullable = false)
    @Positive(message = "Flight duration must be positive")
    private Integer flightDurationMinutes;

    @Column(nullable = false)
    @Positive(message = "Price must be positive")
    private Double price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id", nullable = false)
    @NotNull(message = "Company is required")
    private Company company;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aircraft_id", nullable = false)
    @JsonManagedReference
    @NotNull(message = "Aircraft is required")
    private Aircraft aircraft;

    @OneToMany(mappedBy = "flight", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<SeatReservation> reservations;
}
