import 'package:flutter/material.dart';
import 'package:frontend/constants/app_routes.dart';
import 'package:frontend/models/flight.dart';
import 'package:frontend/services/flight_service.dart';
import '../screens/flight_search_screen/widgets/flight_card_image.dart';
import '../../../widgets/flight_information_widget.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  final int passengerCount;
  final FlightService flightService;

  FlightCard({
    super.key,
    required this.flight,
    required this.passengerCount,
    FlightService? flightService,
  }) : flightService = flightService ?? FlightService();

  Future<void> _onCardTap(BuildContext context) async {
    try {
      final flightDetails = await flightService.getFlightDetails(flight.id);
      if (!context.mounted) return;

      Navigator.pushNamed(
        context,
        AppRoutes.flightDetails,
        arguments: {'flight': flightDetails, 'passengerCount': passengerCount},
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading flight details: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCardTap(context),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlightCardImage(imageUrl: flight.arrivalAirportImageUrl),
            Padding(
              padding: const EdgeInsets.all(12),
              child: FlightInformationWidget(
                departureAirport: flight.departureAirport,
                arrivalAirport: flight.arrivalAirport,
                price: flight.price,
                companyName: flight.companyName,
                companyPhotoId: flight.companyPhotoId,
                departureDateTime: flight.departureDateTime,
                arrivalDateTime: flight.arrivalDateTime,
                duration: flight.duration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
