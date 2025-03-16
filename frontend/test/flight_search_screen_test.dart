import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend/screens/flight_search_screen/flight_search_screen.dart';
import 'package:frontend/services/flight_service.dart';
import 'package:frontend/models/flight.dart';

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
  testWidgets('FlightSearchScreen renders correctly', (
    WidgetTester tester,
  ) async {
    // Set a larger screen size for tests
    tester.view.physicalSize = const Size(1600, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Create a mock flight service
    final mockFlightService = MockFlightService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: FlightSearchScreen(
          flightService: mockFlightService, // Inject mock service
        ),
      ),
    );

    // Pump to allow async operations to complete
    await tester.pump(const Duration(seconds: 4));

    // Verify that the search screen has key elements
    expect(find.text('Discover Your Flight Experience'), findsOneWidget);

    // Check for search input fields
    expect(find.byType(TextField), findsWidgets);

    // Verify flight details are displayed
    expect(find.text('airBaltic'), findsOneWidget);
    expect(find.text('Tallinn → London'), findsOneWidget);
    expect(find.text('\$159.99'), findsOneWidget);
  });
}
