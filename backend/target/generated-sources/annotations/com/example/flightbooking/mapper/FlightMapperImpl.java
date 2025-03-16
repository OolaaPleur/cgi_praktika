package com.example.flightbooking.mapper;

import com.example.flightbooking.dto.FlightDetailDTO;
import com.example.flightbooking.dto.FlightListDTO;
import com.example.flightbooking.model.Aircraft;
import com.example.flightbooking.model.AircraftType;
import com.example.flightbooking.model.Airport;
import com.example.flightbooking.model.Company;
import com.example.flightbooking.model.Flight;
import com.example.flightbooking.model.Seat;
import com.example.flightbooking.model.SeatConfiguration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-03-16T17:05:38+0200",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.41.0.z20250213-2037, environment: Java 21.0.6 (Eclipse Adoptium)"
)
@Component
public class FlightMapperImpl extends FlightMapper {

    @Override
    public FlightListDTO toFlightListDTO(Flight flight) {
        if ( flight == null ) {
            return null;
        }

        Long aircraftId = null;
        String departureAirport = null;
        String arrivalAirport = null;
        String companyName = null;
        String companyPhotoId = null;
        String departureAirportImageUrl = null;
        String arrivalAirportImageUrl = null;
        String arrivalContinent = null;
        Long id = null;
        LocalDateTime departureDateTime = null;
        LocalDateTime arrivalDateTime = null;
        Integer flightDurationMinutes = null;
        Double price = null;

        aircraftId = flightAircraftId( flight );
        departureAirport = flightDepartureAirportName( flight );
        arrivalAirport = flightArrivalAirportName( flight );
        companyName = flightCompanyName( flight );
        companyPhotoId = flightCompanyPhotoId( flight );
        departureAirportImageUrl = flightDepartureAirportPhotoId( flight );
        arrivalAirportImageUrl = flightArrivalAirportPhotoId( flight );
        arrivalContinent = flightArrivalAirportArrivalContinent( flight );
        id = flight.getId();
        departureDateTime = flight.getDepartureDateTime();
        arrivalDateTime = flight.getArrivalDateTime();
        flightDurationMinutes = flight.getFlightDurationMinutes();
        price = flight.getPrice();

        FlightListDTO flightListDTO = new FlightListDTO( id, departureAirport, arrivalAirport, departureDateTime, arrivalDateTime, flightDurationMinutes, price, companyName, companyPhotoId, aircraftId, departureAirportImageUrl, arrivalAirportImageUrl, arrivalContinent );

        return flightListDTO;
    }

    @Override
    public FlightDetailDTO toFlightDetailDTO(Flight flight) {
        if ( flight == null ) {
            return null;
        }

        String departureAirport = null;
        String arrivalAirport = null;
        String companyName = null;
        String companyPhotoId = null;
        String departureAirportImageUrl = null;
        String arrivalAirportImageUrl = null;
        String arrivalContinent = null;
        Long id = null;
        LocalDateTime departureDateTime = null;
        LocalDateTime arrivalDateTime = null;
        Integer flightDurationMinutes = null;
        Double price = null;

        departureAirport = flightDepartureAirportName( flight );
        arrivalAirport = flightArrivalAirportName( flight );
        companyName = flightCompanyName( flight );
        companyPhotoId = flightCompanyPhotoId( flight );
        departureAirportImageUrl = flightDepartureAirportPhotoId( flight );
        arrivalAirportImageUrl = flightArrivalAirportPhotoId( flight );
        arrivalContinent = flightArrivalAirportArrivalContinent( flight );
        id = flight.getId();
        departureDateTime = flight.getDepartureDateTime();
        arrivalDateTime = flight.getArrivalDateTime();
        flightDurationMinutes = flight.getFlightDurationMinutes();
        price = flight.getPrice();

        FlightDetailDTO.AircraftDTO aircraft = toAircraftDTO(flight.getAircraft(), flight);

        FlightDetailDTO flightDetailDTO = new FlightDetailDTO( id, departureAirport, arrivalAirport, departureDateTime, arrivalDateTime, flightDurationMinutes, price, companyName, companyPhotoId, departureAirportImageUrl, arrivalAirportImageUrl, arrivalContinent, aircraft );

        return flightDetailDTO;
    }

    @Override
    public FlightDetailDTO.AircraftDTO toAircraftDTO(Aircraft aircraft, Flight flight) {
        if ( aircraft == null && flight == null ) {
            return null;
        }

        Long id = null;
        String modelName = null;
        String manufacturer = null;
        Integer totalSeats = null;
        List<FlightDetailDTO.ConfigurationDTO> configurations = null;
        if ( aircraft != null ) {
            id = aircraft.getId();
            modelName = aircraftAircraftTypeModelName( aircraft );
            manufacturer = aircraftAircraftTypeManufacturer( aircraft );
            totalSeats = aircraftAircraftTypeTotalSeats( aircraft );
            List<SeatConfiguration> configurations1 = aircraftAircraftTypeConfigurations( aircraft );
            configurations = seatConfigurationListToConfigurationDTOList( configurations1 );
        }

        List<FlightDetailDTO.SeatDTO> seats = mapSeats(aircraft.getAircraftType().getSeats(), flight);

        FlightDetailDTO.AircraftDTO aircraftDTO = new FlightDetailDTO.AircraftDTO( id, modelName, manufacturer, totalSeats, configurations, seats );

        return aircraftDTO;
    }

    @Override
    public FlightDetailDTO.ConfigurationDTO toConfigurationDTO(SeatConfiguration config) {
        if ( config == null ) {
            return null;
        }

        Integer numberOfRows = null;
        String seatLayout = null;
        String color = null;
        Double priceMultiplier = null;

        numberOfRows = config.getNumberOfRows();
        seatLayout = config.getSeatLayout();
        color = config.getColor();
        priceMultiplier = config.getPriceMultiplier();

        String className = config.getClassName().name();

        FlightDetailDTO.ConfigurationDTO configurationDTO = new FlightDetailDTO.ConfigurationDTO( className, numberOfRows, seatLayout, color, priceMultiplier );

        return configurationDTO;
    }

    @Override
    public FlightDetailDTO.SeatDTO toSeatDTO(Seat seat, Flight flight) {
        if ( seat == null && flight == null ) {
            return null;
        }

        Long id = null;
        String seatNumber = null;
        Boolean windowSeat = null;
        Boolean extraLegroom = null;
        Boolean exitRow = null;
        if ( seat != null ) {
            id = seat.getId();
            seatNumber = seat.getSeatNumber();
            windowSeat = seat.getWindowSeat();
            extraLegroom = seat.getExtraLegroom();
            exitRow = seat.getExitRow();
        }

        String seatClass = seat.getSeatClass().name();
        Boolean reserved = isReserved(seat, flight.getReservations());

        FlightDetailDTO.SeatDTO seatDTO = new FlightDetailDTO.SeatDTO( id, seatNumber, seatClass, windowSeat, extraLegroom, reserved, exitRow );

        return seatDTO;
    }

    private Long flightAircraftId(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Aircraft aircraft = flight.getAircraft();
        if ( aircraft == null ) {
            return null;
        }
        Long id = aircraft.getId();
        if ( id == null ) {
            return null;
        }
        return id;
    }

    private String flightDepartureAirportName(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Airport departureAirport = flight.getDepartureAirport();
        if ( departureAirport == null ) {
            return null;
        }
        String name = departureAirport.getName();
        if ( name == null ) {
            return null;
        }
        return name;
    }

    private String flightArrivalAirportName(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Airport arrivalAirport = flight.getArrivalAirport();
        if ( arrivalAirport == null ) {
            return null;
        }
        String name = arrivalAirport.getName();
        if ( name == null ) {
            return null;
        }
        return name;
    }

    private String flightCompanyName(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Company company = flight.getCompany();
        if ( company == null ) {
            return null;
        }
        String name = company.getName();
        if ( name == null ) {
            return null;
        }
        return name;
    }

    private String flightCompanyPhotoId(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Company company = flight.getCompany();
        if ( company == null ) {
            return null;
        }
        String photoId = company.getPhotoId();
        if ( photoId == null ) {
            return null;
        }
        return photoId;
    }

    private String flightDepartureAirportPhotoId(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Airport departureAirport = flight.getDepartureAirport();
        if ( departureAirport == null ) {
            return null;
        }
        String photoId = departureAirport.getPhotoId();
        if ( photoId == null ) {
            return null;
        }
        return photoId;
    }

    private String flightArrivalAirportPhotoId(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Airport arrivalAirport = flight.getArrivalAirport();
        if ( arrivalAirport == null ) {
            return null;
        }
        String photoId = arrivalAirport.getPhotoId();
        if ( photoId == null ) {
            return null;
        }
        return photoId;
    }

    private String flightArrivalAirportArrivalContinent(Flight flight) {
        if ( flight == null ) {
            return null;
        }
        Airport arrivalAirport = flight.getArrivalAirport();
        if ( arrivalAirport == null ) {
            return null;
        }
        String arrivalContinent = arrivalAirport.getArrivalContinent();
        if ( arrivalContinent == null ) {
            return null;
        }
        return arrivalContinent;
    }

    private String aircraftAircraftTypeModelName(Aircraft aircraft) {
        if ( aircraft == null ) {
            return null;
        }
        AircraftType aircraftType = aircraft.getAircraftType();
        if ( aircraftType == null ) {
            return null;
        }
        String modelName = aircraftType.getModelName();
        if ( modelName == null ) {
            return null;
        }
        return modelName;
    }

    private String aircraftAircraftTypeManufacturer(Aircraft aircraft) {
        if ( aircraft == null ) {
            return null;
        }
        AircraftType aircraftType = aircraft.getAircraftType();
        if ( aircraftType == null ) {
            return null;
        }
        String manufacturer = aircraftType.getManufacturer();
        if ( manufacturer == null ) {
            return null;
        }
        return manufacturer;
    }

    private Integer aircraftAircraftTypeTotalSeats(Aircraft aircraft) {
        if ( aircraft == null ) {
            return null;
        }
        AircraftType aircraftType = aircraft.getAircraftType();
        if ( aircraftType == null ) {
            return null;
        }
        Integer totalSeats = aircraftType.getTotalSeats();
        if ( totalSeats == null ) {
            return null;
        }
        return totalSeats;
    }

    private List<SeatConfiguration> aircraftAircraftTypeConfigurations(Aircraft aircraft) {
        if ( aircraft == null ) {
            return null;
        }
        AircraftType aircraftType = aircraft.getAircraftType();
        if ( aircraftType == null ) {
            return null;
        }
        List<SeatConfiguration> configurations = aircraftType.getConfigurations();
        if ( configurations == null ) {
            return null;
        }
        return configurations;
    }

    protected List<FlightDetailDTO.ConfigurationDTO> seatConfigurationListToConfigurationDTOList(List<SeatConfiguration> list) {
        if ( list == null ) {
            return null;
        }

        List<FlightDetailDTO.ConfigurationDTO> list1 = new ArrayList<FlightDetailDTO.ConfigurationDTO>( list.size() );
        for ( SeatConfiguration seatConfiguration : list ) {
            list1.add( toConfigurationDTO( seatConfiguration ) );
        }

        return list1;
    }
}
