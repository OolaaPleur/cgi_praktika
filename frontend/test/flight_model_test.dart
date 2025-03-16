import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/flight.dart';
import 'package:frontend/models/aircraft.dart';

void main() {
  group('FlightDetails', () {
    test('FlightDetails can be created with correct properties', () {
      final aircraft = Aircraft(
        id: 1,
        modelName: 'E190',
        manufacturer: 'Embraer',
        totalSeats: 96,
        configurations: [
          SeatConfiguration(
            className: 'FIRST',
            seatLayout: 'AB-CD',
            color: '#FFD700',
            numberOfRows: 2,
            priceMultiplier: 2.5,
          ),
          SeatConfiguration(
            className: 'BUSINESS',
            seatLayout: 'AB-CD',
            color: '#00008B',
            numberOfRows: 3,
            priceMultiplier: 1.8,
          ),
          SeatConfiguration(
            className: 'ECONOMY',
            seatLayout: 'AB-CD',
            color: '#008000',
            numberOfRows: 19,
            priceMultiplier: 1.0,
          ),
        ],
        seats: [
          Seat(
            id: 1,
            seatNumber: '1A',
            seatClass: 'FIRST',
            windowSeat: true,
            extraLegroom: true,
            reserved: false,
            exitRow: false,
          ),
        ],
      );

      final flightDetails = FlightDetails(
        id: 1,
        departureAirport: 'Tallinn',
        arrivalAirport: 'London',
        departureDateTime: DateTime(2025, 4, 20, 8, 0),
        arrivalDateTime: DateTime(2025, 4, 20, 9, 45),
        flightDurationMinutes: 105,
        price: 159.99,
        companyName: 'airBaltic',
        aircraft: aircraft,
        companyPhotoId: 'airbaltic.com',
        departureAirportImageUrl: '3224113',
        arrivalAirportImageUrl: '672532',
      );

      expect(flightDetails.id, 1);
      expect(flightDetails.departureAirport, 'Tallinn');
      expect(flightDetails.arrivalAirport, 'London');
      expect(flightDetails.companyName, 'airBaltic');
      expect(flightDetails.price, 159.99);
    });

    test('FlightDetails calculates flight duration correctly', () {
      final aircraft = Aircraft(
        id: 1,
        modelName: 'E190',
        manufacturer: 'Embraer',
        totalSeats: 96,
        configurations: [
          SeatConfiguration(
            className: 'FIRST',
            seatLayout: 'AB-CD',
            color: '#FFD700',
            numberOfRows: 2,
            priceMultiplier: 2.5,
          ),
        ],
        seats: [],
      );

      final flightDetails = FlightDetails(
        id: 2,
        departureAirport: 'Tallinn',
        arrivalAirport: 'London',
        departureDateTime: DateTime(2025, 4, 20, 8, 0),
        arrivalDateTime: DateTime(2025, 4, 20, 9, 45),
        flightDurationMinutes: 105,
        price: 159.99,
        companyName: 'airBaltic',
        aircraft: aircraft,
        companyPhotoId: 'airbaltic.com',
        departureAirportImageUrl: '3224113',
        arrivalAirportImageUrl: '672532',
      );

      expect(flightDetails.duration, '1h 45m');
    });
  });
}
