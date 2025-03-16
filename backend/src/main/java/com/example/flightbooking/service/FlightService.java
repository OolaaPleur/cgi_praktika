package com.example.flightbooking.service;

import com.example.flightbooking.model.Flight;
import com.example.flightbooking.model.SeatReservation;
import com.example.flightbooking.repository.FlightRepository;
import com.example.flightbooking.repository.SeatReservationRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class FlightService {
    private static final Logger logger = LoggerFactory.getLogger(FlightService.class);
    
    @Autowired
    private FlightRepository flightRepository;
    
    @Autowired
    private SeatReservationRepository seatReservationRepository;
    
    @Autowired
    private PexelsService pexelsService;
    
    public List<Flight> getAllFlights() {
        return flightRepository.findAllWithAirports();
    }
    
    public Flight getFlightById(Long id) {
        return flightRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Flight not found with id: " + id));
    }
    
    @PostConstruct
    @Transactional
    public void init() {
        logger.info("Starting initialization process...");
        
        try {
            // Cache images if possible
            List<Flight> flights = getAllFlights();
            flights.forEach(flight -> {
                try {
                    if (flight.getDepartureAirport().getPhotoId() != null) {
                        pexelsService.cacheImage(flight.getDepartureAirport().getPhotoId());
                    }
                    if (flight.getArrivalAirport().getPhotoId() != null) {
                        pexelsService.cacheImage(flight.getArrivalAirport().getPhotoId());
                    }
                } catch (Exception e) {
                    logger.warn("Failed to cache image for flight {}: {}", flight.getId(), e.getMessage());
                }
            });
        } catch (Exception e) {
            logger.warn("Failed to cache images during initialization: {}", e.getMessage());
        }
        
        // Initialize random reservations
        try {
            Random random = new Random();
            List<Flight> flights = getAllFlights();
            for (Flight flight : flights) {
                List<SeatReservation> reservations = seatReservationRepository.findByFlightId(flight.getId());
                int totalSeats = reservations.size();
            
                if (totalSeats == 0) continue;
            
                int seatsToReserve = (int) (totalSeats * 0.3);
                List<SeatReservation> updatedReservations = new ArrayList<>();
            
                for (int i = 0; i < seatsToReserve; i++) {
                    SeatReservation reservation;
                    do {
                        reservation = reservations.get(random.nextInt(totalSeats));
                    } while (reservation.getReserved());
            
                    reservation.setReserved(true);
                    updatedReservations.add(reservation);
                }
            
                seatReservationRepository.saveAll(updatedReservations);
            }
            
        } catch (Exception e) {
            logger.error("Failed to initialize random reservations: {}", e.getMessage());
        }
        
        logger.info("Initialization process completed");
    }
    
    /**
     * Reserves seats for a specific flight.
     *
     * @param flightId the ID of the flight
     * @param seatNumbers list of seat numbers to reserve
     * @throws RuntimeException if any seat is already reserved or if the flight is not found
     */
    @Transactional
    public void reserveSeats(Long flightId, List<String> seatNumbers) {
        logger.info("Attempting to reserve seats {} for flight ID: {}", seatNumbers, flightId);
        
        List<SeatReservation> existingReservations = seatReservationRepository
                .findByFlightIdAndSeat_SeatNumberIn(flightId, seatNumbers);
        
        if (existingReservations.isEmpty()) {
            throw new IllegalArgumentException("One or more seat numbers not found for this flight");
        }
        
        if (existingReservations.stream().anyMatch(reservation -> reservation.getReserved())) {
            logger.error("Seat reservation failed: one or more seats are already reserved");
            throw new RuntimeException("One or more seats are already reserved");
        }
        
        existingReservations.forEach(reservation -> reservation.setReserved(true));
        seatReservationRepository.saveAll(existingReservations);
        logger.info("Successfully reserved {} seats for flight ID: {}", seatNumbers.size(), flightId);
    }
} 