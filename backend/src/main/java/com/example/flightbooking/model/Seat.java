package com.example.flightbooking.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
@Entity
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "seat_number")
    @NotBlank(message = "Seat number cannot be blank")
    @Size(min = 1, max = 5, message = "Seat number must be between 1 and 5 characters")
    private String seatNumber;
    
    @Column(name = "seat_class")
    @Enumerated(EnumType.STRING)
    private SeatClass seatClass;
    
    @Column(name = "window_seat")
    private Boolean windowSeat;
    
    @Column(name = "exit_row")
    private Boolean exitRow;
    
    @Column(name = "extra_legroom")
    private Boolean extraLegroom;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aircraft_type_id")
    @JsonBackReference
    private AircraftType aircraftType;
} 