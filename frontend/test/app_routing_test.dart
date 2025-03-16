import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/constants/app_routes.dart';
import 'package:frontend/models/flight.dart';
import 'package:frontend/models/aircraft.dart';
import 'package:frontend/services/flight_service.dart';
import 'package:mockito/mockito.dart';

// Mock FlightService
class MockFlightService extends Mock implements FlightService {
  @override
  Future<List<Flight>> getFlights() async {
    // Return a mock list of flights using the provided data
    return [
      Flight(
        id: 1,
        departureAirport: 'Tallinn',
        arrivalAirport: 'London',
        departureDateTime: DateTime(2025, 4, 20, 8, 0),
        arrivalDateTime: DateTime(2025, 4, 20, 9, 45),
        flightDurationMinutes: 105,
        price: 159.99,
        companyName: 'airBaltic',
        companyPhotoId: 'airbaltic.com',
        departureAirportImageUrl: '3224113',
        arrivalAirportImageUrl: '672532',
        arrivalContinent: 'Europe',
        aircraftId: 1,
      ),
    ];
  }
}

void main() {
  testWidgets('App routes to correct screens', (WidgetTester tester) async {
    // Set a larger screen size for tests
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Create a mock flight service
    final mockFlightService = MockFlightService();

    // Create a mock FlightDetails for testing
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
        // Add a few more seats for testing
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

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(
          initialFlightService: mockFlightService, // Inject mock service
        ),
      ),
    );

    // Pump again to allow async operations to complete
    await tester.pump();

    // Verify that the initial route is the home screen
    expect(find.text('Discover Your Flight Experience'), findsOneWidget);

    // Simulate navigation to flight details
    final route = MaterialPageRoute(
      settings: RouteSettings(
        name: AppRoutes.flightDetails,
        arguments: {'flight': flightDetails, 'passengerCount': 2},
      ),
      builder:
          (context) => Scaffold(
            body: Text(
              'Flight Details for ${flightDetails.departureAirport} to ${flightDetails.arrivalAirport}',
            ),
          ),
    );

    // Verify route generation
    expect(route.settings.name, AppRoutes.flightDetails);
    expect(route.settings.arguments, isNotNull);
  });
}
