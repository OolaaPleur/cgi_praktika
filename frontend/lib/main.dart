import 'package:flutter/material.dart';
import 'package:frontend/constants/app_routes.dart';
import 'package:frontend/services/flight_service.dart';
import 'models/flight.dart';
import 'screens/flight_details_screen/flight_details_screen.dart';
import 'screens/flight_search_screen/flight_search_screen.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<
      NavigatorState
    >(); // To guarantee that page pops after user selects seats for a flight.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final FlightService? initialFlightService;

  const MyApp({super.key, this.initialFlightService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: _onGenerateRoute,
      home: FlightSearchScreen(flightService: initialFlightService),
      navigatorKey: navigatorKey,
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder:
              (context) =>
                  FlightSearchScreen(flightService: initialFlightService),
        );

      case AppRoutes.flightDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final flightDetails = args['flight'] as FlightDetails;
        final passengerCount = args['passengerCount'] as int;

        return MaterialPageRoute(
          builder:
              (context) => FlightDetailsScreen(
                flight: flightDetails,
                passengerCount: passengerCount,
              ),
        );

      default:
        return null;
    }
  }
}
