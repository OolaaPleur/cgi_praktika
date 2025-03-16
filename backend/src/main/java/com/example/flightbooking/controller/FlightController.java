package com.example.flightbooking.controller;

import com.example.flightbooking.dto.FlightDetailDTO;
import com.example.flightbooking.dto.FlightListDTO;
import com.example.flightbooking.dto.SeatReservationRequest;
import com.example.flightbooking.mapper.FlightMapper;
import com.example.flightbooking.service.FlightService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/flights")
@Tag(name = "Flight", description = "Flight management APIs")
public class FlightController {

    private static final Logger log = LoggerFactory.getLogger(FlightController.class);
    
    private final FlightService flightService;
    private final FlightMapper flightMapper;

    public FlightController(FlightService flightService, FlightMapper flightMapper) {
        this.flightService = flightService;
        this.flightMapper = flightMapper;
    }

    @Operation(summary = "Get all flights", description = "Retrieves a list of all available flights with basic information")
    @ApiResponse(
        responseCode = "200",
        description = "Successfully retrieved the list of flights",
        content = @Content(mediaType = "application/json", schema = @Schema(implementation = FlightListDTO.class))
    )
    @GetMapping
    public ResponseEntity<List<FlightListDTO>> getAllFlights() {
        List<FlightListDTO> flights = flightService.getAllFlights().stream()
                .map(flightMapper::toFlightListDTO)
                .collect(Collectors.toList());

        return ResponseEntity.ok(flights);
    }

    @Operation(summary = "Get flight by ID", description = "Retrieves detailed information about a specific flight including aircraft and seat details")
    @ApiResponses({
        @ApiResponse(
            responseCode = "200",
            description = "Successfully retrieved the flight",
            content = @Content(mediaType = "application/json", schema = @Schema(implementation = FlightDetailDTO.class))
        ),
        @ApiResponse(
            responseCode = "404",
            description = "Flight not found",
            content = @Content
        )
    })
    @GetMapping("/{id}")
    public ResponseEntity<FlightDetailDTO> getFlightById(
        @Parameter(description = "ID of the flight to retrieve") 
        @PathVariable Long id
    ) {
        FlightDetailDTO flightDetail = flightMapper.toFlightDetailDTO(flightService.getFlightById(id));
        return ResponseEntity.ok(flightDetail);
    }

    @Operation(summary = "Reserve seats", description = "Reserve seats by their seat numbers (e.g. '1A', '2B') for a specific flight")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Successfully reserved the seats"),
        @ApiResponse(responseCode = "400", description = "Invalid request or seats already reserved"),
        @ApiResponse(responseCode = "404", description = "Flight not found or seats not found")
    })
    @PutMapping("/{flightId}/seats")
    public ResponseEntity<Void> reserveSeats(
        @Parameter(description = "ID of the flight") 
        @PathVariable Long flightId,
        @Parameter(description = "List of seat numbers to reserve (e.g. ['1A', '2B'])")
        @Valid @RequestBody SeatReservationRequest request
    ) {
        try {
            flightService.reserveSeats(flightId, request.getSeatNumbers());
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.error("Error reserving seats for flight ID {}: {}", flightId, e.getMessage());
            throw e;
        }
    }
}
