package com.example.flightbooking.dto;

import java.time.LocalDateTime;
import java.util.List;

public record FlightDetailDTO(
    Long id,
    String departureAirport,
    String arrivalAirport,
    LocalDateTime departureDateTime,
    LocalDateTime arrivalDateTime,
    Integer flightDurationMinutes,
    Double price,
    String companyName,
    String companyPhotoId,
    String departureAirportImageUrl,
    String arrivalAirportImageUrl,
    String arrivalContinent,
    AircraftDTO aircraft
) {
    public record AircraftDTO(
        Long id,
        String modelName,
        String manufacturer,
        Integer totalSeats,
        List<ConfigurationDTO> configurations,
        List<SeatDTO> seats
    ) {}

    public record ConfigurationDTO(
        String className,
        Integer numberOfRows,
        String seatLayout,
        String color,
        Double priceMultiplier
    ) {}

    public record SeatDTO(
        Long id,
        String seatNumber,
        String seatClass,
        Boolean windowSeat,
        Boolean extraLegroom,
        Boolean reserved,
        Boolean exitRow
    ) {}
} 