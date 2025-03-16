import 'package:flutter/material.dart';
import '../../../models/flight.dart';
import 'seat_selection_sheet/seat_selection_sheet.dart';

class SeatSelectionButton extends StatelessWidget {
  final FlightDetails flight;
  final int passengerCount;

  const SeatSelectionButton({
    super.key,
    required this.flight,
    required this.passengerCount,
  });

  void _showSeatSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => SeatSelectionSheet(
            aircraft: flight.aircraft,
            flight: flight,
            passengerCount: passengerCount,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showSeatSelection(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        child: const Text('Pick seats', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
