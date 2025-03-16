package com.example.flightbooking.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Entity
@Table(name = "seat_reservation")
public class SeatReservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flight_id")
    @NotNull(message = "Flight is required for seat reservation")
    private Flight flight;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seat_id")
    @NotNull(message = "Seat is required for seat reservation")
    private Seat seat;
    
    @Column(name = "reserved", nullable = false, columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean reserved;
} 