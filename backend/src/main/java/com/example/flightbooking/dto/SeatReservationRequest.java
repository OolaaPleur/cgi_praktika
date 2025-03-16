package com.example.flightbooking.dto;

import jakarta.validation.constraints.NotEmpty;
import java.util.List;

public record SeatReservationRequest(
    @NotEmpty(message = "At least one seat number must be provided")
    List<String> seatNumbers
) {
    public List<String> getSeatNumbers() {
        return seatNumbers;
    }
} 