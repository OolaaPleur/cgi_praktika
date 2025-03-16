import 'package:flutter/material.dart';
import 'package:frontend/widgets/flight_airports_widget.dart';
import 'package:frontend/widgets/flight_company_widget.dart';
import 'package:frontend/widgets/flight_dates_widget.dart';
import 'package:frontend/widgets/flight_time_and_duration_widget.dart';

class FlightInformationWidget extends StatelessWidget {
  final String departureAirport;
  final String arrivalAirport;
  final double price;
  final String companyName;
  final String companyPhotoId;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final String duration;

  const FlightInformationWidget({
    super.key,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.price,
    required this.companyName,
    required this.companyPhotoId,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlightAirportsWidget(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          price: price,
          fontSize: 23,
          priceFontSize: 20,
        ),
        const SizedBox(height: 6),
        FlightCompanyWidget(
          companyName: companyName,
          companyPhotoId: companyPhotoId,
          fontSize: 18,
        ),
        const SizedBox(height: 6),
        FlightDatesWidget(
          departureDateTime: departureDateTime,
          arrivalDateTime: arrivalDateTime,
          fontSize: 16,
        ),
        const SizedBox(height: 6),
        FlightTimeDurationWidget(
          departureDateTime: departureDateTime,
          arrivalDateTime: arrivalDateTime,
          duration: duration,
        ),
      ],
    );
  }
}
