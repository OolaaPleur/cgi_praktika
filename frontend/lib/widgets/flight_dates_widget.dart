import 'package:flutter/material.dart';

class FlightDatesWidget extends StatelessWidget {
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final double fontSize;

  const FlightDatesWidget({
    super.key,
    required this.departureDateTime,
    required this.arrivalDateTime,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${departureDateTime.day}/${departureDateTime.month}/${departureDateTime.year} - ${arrivalDateTime.day}/${arrivalDateTime.month}/${arrivalDateTime.year}',
      style: TextStyle(fontSize: fontSize, color: Colors.grey),
      overflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}
