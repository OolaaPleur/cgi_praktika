package com.example.flightbooking.dto;

import java.time.LocalDateTime;

public record FlightListDTO(
    Long id,
    String departureAirport,
    String arrivalAirport,
    LocalDateTime departureDateTime,
    LocalDateTime arrivalDateTime,
    Integer flightDurationMinutes,
    Double price,
    String companyName,
    String companyPhotoId,
    Long aircraftId,
    String departureAirportImageUrl,
    String arrivalAirportImageUrl,
    String arrivalContinent
) {} 