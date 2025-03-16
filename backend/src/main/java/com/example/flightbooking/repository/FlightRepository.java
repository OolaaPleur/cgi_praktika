package com.example.flightbooking.repository;

import com.example.flightbooking.model.Flight;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {
    @Query("SELECT f FROM Flight f JOIN FETCH f.departureAirport JOIN FETCH f.arrivalAirport")
    List<Flight> findAllWithAirports();
} 