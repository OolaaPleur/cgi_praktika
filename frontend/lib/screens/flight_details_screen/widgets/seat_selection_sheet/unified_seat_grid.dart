import 'package:flutter/material.dart';
import 'package:frontend/models/aircraft.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_sheet/seat_widget.dart';

class UnifiedSeatGrid extends StatelessWidget {
  final Aircraft aircraft;
  final Set<String> selectedSeats;
  final int passengerCount;
  final bool Function(Seat seat) isSeatAvailable;
  final void Function(Seat seat, SeatConfiguration config) onSeatTap;

  const UnifiedSeatGrid({
    super.key,
    required this.aircraft,
    required this.selectedSeats,
    required this.passengerCount,
    required this.isSeatAvailable,
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get the first class configuration for letter layout
    final firstConfig = aircraft.configurations.first;
    final sections = firstConfig.seatLayout.split('-');

    // Create letter headers
    final letterRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Row number placeholder for alignment
        Container(width: 32, height: 32, margin: const EdgeInsets.all(2)),
        ...sections.map((section) {
          return Row(
            children: [
              ...section.split('').map((letter) {
                return Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.all(2),
                  child: Center(
                    child: Text(
                      letter,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
              // Add space between sections
              if (section != sections.last) const SizedBox(width: 16),
            ],
          );
        }),
        // Row number placeholder for alignment
        Container(width: 32, height: 32, margin: const EdgeInsets.all(2)),
      ],
    );

    // Build all rows from all configurations
    final seatRows = <Widget>[];
    int currentRow = 1;

    for (var config in aircraft.configurations) {
      final configSeats =
          aircraft.seats
              .where(
                (seat) =>
                    seat.seatClass.toUpperCase() ==
                    config.className.toUpperCase(),
              )
              .toList();

      for (var row = 0; row < config.numberOfRows; row++) {
        final rowSeats =
            configSeats
                .where(
                  (seat) =>
                      int.parse(
                        seat.seatNumber.substring(
                          0,
                          seat.seatNumber.length - 1,
                        ),
                      ) ==
                      currentRow,
                )
                .toList();

        final rowWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...sections.map((section) {
              return Row(
                children: [
                  ...section.split('').map((letter) {
                    final seatNumber = '$currentRow$letter';
                    final seat =
                        rowSeats
                            .where((s) => s.seatNumber == seatNumber)
                            .firstOrNull;
                    if (seat != null) {
                      return SeatWidget(
                        seat: seat,
                        config: config,
                        selectedSeats: selectedSeats,
                        passengerCount: passengerCount,
                        isSeatAvailable: isSeatAvailable,
                        onSeatTap: onSeatTap,
                      );
                    } else {
                      // Create an empty seat with default values
                      final emptySeat = Seat(
                        id: -1,
                        seatNumber: seatNumber,
                        seatClass: config.className,
                        reserved: false,
                        exitRow: false,
                        extraLegroom: false,
                        windowSeat:
                            letter == section.characters.first ||
                            letter == section.characters.last,
                      );
                      return SeatWidget(
                        seat: emptySeat,
                        config: config,
                        selectedSeats: selectedSeats,
                        passengerCount: passengerCount,
                        isSeatAvailable: isSeatAvailable,
                        onSeatTap: onSeatTap,
                      );
                    }
                  }),
                  // Add space between sections
                  if (section != sections.last)
                    Container(
                      width: 34,
                      height: 34,
                      margin: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          currentRow.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        );
        seatRows.add(rowWidget);
        currentRow++;
      }
    }

    return Column(children: [letterRow, ...seatRows]);
  }
}
