import 'package:flutter/material.dart';

class FlightTimeDurationWidget extends StatelessWidget {
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final String duration;

  const FlightTimeDurationWidget({
    super.key,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${departureDateTime.hour}:${departureDateTime.minute.toString().padLeft(2, '0')} - ${arrivalDateTime.hour}:${arrivalDateTime.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            duration,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
