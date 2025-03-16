import 'package:flutter/material.dart';
import 'package:frontend/models/aircraft.dart';
import 'package:frontend/utils/color_utils.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final SeatConfiguration config;
  final Set<String> selectedSeats;
  final int passengerCount;
  final bool Function(Seat seat) isSeatAvailable;
  final void Function(Seat seat, SeatConfiguration config) onSeatTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.config,
    required this.selectedSeats,
    required this.passengerCount,
    required this.isSeatAvailable,
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        seat.reserved ? Colors.grey : parseColor(config.color);
    Color seatColor;
    bool isDisabled =
        seat.reserved ||
        (selectedSeats.length >= passengerCount &&
            !selectedSeats.contains(seat.seatNumber)) ||
        !isSeatAvailable(seat);

    if (!isSeatAvailable(seat)) {
      seatColor = Colors.grey[300]!;
    } else if (seat.reserved) {
      seatColor = Colors.red;
    } else if (isDisabled) {
      seatColor = Colors.grey;
    } else if (selectedSeats.contains(seat.seatNumber)) {
      seatColor = Colors.blue;
    } else {
      seatColor = backgroundColor;
    }

    return GestureDetector(
      onTap:
          (seat.reserved || !isSeatAvailable(seat))
              ? null
              : () => onSeatTap(seat, config),
      child: MouseRegion(
        cursor:
            (seat.reserved || !isSeatAvailable(seat))
                ? SystemMouseCursors.forbidden
                : (selectedSeats.length < passengerCount ||
                    selectedSeats.contains(seat.seatNumber))
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic,
        child: Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: seatColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color:
                  selectedSeats.contains(seat.seatNumber)
                      ? Colors.blue.shade800
                      : Colors.black26,
              width: selectedSeats.contains(seat.seatNumber) ? 2 : 1,
            ),
          ),
          child:
              selectedSeats.contains(seat.seatNumber)
                  ? Center(
                    child: Text(
                      seat.seatNumber,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
