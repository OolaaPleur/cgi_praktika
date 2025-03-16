package com.example.flightbooking.repository;

import com.example.flightbooking.model.SeatReservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SeatReservationRepository extends JpaRepository<SeatReservation, Long> {
    List<SeatReservation> findByFlightIdAndSeatIdIn(Long flightId, List<Long> seatIds);
    List<SeatReservation> findByFlightId(Long flightId);
    List<SeatReservation> findByFlightIdAndSeat_SeatNumberIn(Long flightId, List<String> seatNumbers);
} 