package com.example.flightbooking.mapper;

import com.example.flightbooking.dto.FlightDetailDTO;
import com.example.flightbooking.dto.FlightListDTO;
import com.example.flightbooking.model.*;
import com.example.flightbooking.service.PexelsService;
import java.util.List;
import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper(componentModel = "spring")
public abstract class FlightMapper {
    
    @Autowired
    protected PexelsService pexelsService;
    
    @Mapping(target = "aircraftId", source = "aircraft.id")
    @Mapping(target = "departureAirport", source = "departureAirport.name")
    @Mapping(target = "arrivalAirport", source = "arrivalAirport.name")
    @Mapping(target = "companyName", source = "company.name")
    @Mapping(target = "companyPhotoId", source = "company.photoId")
    @Mapping(target = "departureAirportImageUrl", source = "departureAirport.photoId")
    @Mapping(target = "arrivalAirportImageUrl", source = "arrivalAirport.photoId")
    @Mapping(target = "arrivalContinent", source = "arrivalAirport.arrivalContinent")
    public abstract FlightListDTO toFlightListDTO(Flight flight);
    
    @Mapping(target = "aircraft", expression = "java(toAircraftDTO(flight.getAircraft(), flight))")
    @Mapping(target = "departureAirport", source = "departureAirport.name")
    @Mapping(target = "arrivalAirport", source = "arrivalAirport.name")
    @Mapping(target = "companyName", source = "company.name")
    @Mapping(target = "companyPhotoId", source = "company.photoId")
    @Mapping(target = "departureAirportImageUrl", source = "departureAirport.photoId")
    @Mapping(target = "arrivalAirportImageUrl", source = "arrivalAirport.photoId")
    @Mapping(target = "arrivalContinent", source = "arrivalAirport.arrivalContinent")
    public abstract FlightDetailDTO toFlightDetailDTO(Flight flight);
    
    @Mapping(target = "id", source = "aircraft.id")
    @Mapping(target = "modelName", source = "aircraft.aircraftType.modelName")
    @Mapping(target = "manufacturer", source = "aircraft.aircraftType.manufacturer")
    @Mapping(target = "totalSeats", source = "aircraft.aircraftType.totalSeats")
    @Mapping(target = "configurations", source = "aircraft.aircraftType.configurations")
    @Mapping(target = "seats", expression = "java(mapSeats(aircraft.getAircraftType().getSeats(), flight))")
    public abstract FlightDetailDTO.AircraftDTO toAircraftDTO(Aircraft aircraft, Flight flight);
    
    @Mapping(target = "className", expression = "java(config.getClassName().name())")
    public abstract FlightDetailDTO.ConfigurationDTO toConfigurationDTO(SeatConfiguration config);
    
    @Mapping(target = "id", source = "seat.id")
    @Mapping(target = "seatClass", expression = "java(seat.getSeatClass().name())")
    @Mapping(target = "reserved", expression = "java(isReserved(seat, flight.getReservations()))")
    public abstract FlightDetailDTO.SeatDTO toSeatDTO(Seat seat, Flight flight);
    
    @Named("isReserved")
    public Boolean isReserved(Seat seat, List<SeatReservation> reservations) {
        return reservations.stream()
            .anyMatch(reservation -> 
                reservation.getSeat().getId().equals(seat.getId()) && 
                reservation.getReserved());
    }

    public List<FlightDetailDTO.SeatDTO> mapSeats(List<Seat> seats, Flight flight) {
        return seats.stream()
            .map(seat -> toSeatDTO(seat, flight))
            .collect(java.util.stream.Collectors.toList());
    }
}