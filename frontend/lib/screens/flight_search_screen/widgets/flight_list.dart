import 'package:flutter/material.dart';
import '../../../models/flight.dart';
import 'flight_card.dart';

class FlightList extends StatelessWidget {
  final List<Flight> flights;
  final bool isLoading;
  final int passengerCount;

  const FlightList({
    super.key,
    required this.flights,
    required this.isLoading,
    required this.passengerCount,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (flights.isEmpty) {
      return const Center(child: Text('No flights available'));
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children:
          flights.map((flight) {
            return SizedBox(
              width: 450,
              child: FlightCard(flight: flight, passengerCount: passengerCount),
            );
          }).toList(),
    );
  }
}
