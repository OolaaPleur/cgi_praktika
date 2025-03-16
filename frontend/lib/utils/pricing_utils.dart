import 'package:frontend/models/aircraft.dart';
import 'package:frontend/models/flight.dart';

class PricingUtils {
  /// Calculates the total price for selected seats
  ///
  /// [selectedSeats] is a list of seat numbers to calculate price for
  /// [aircraft] provides seat configurations and details
  /// [flight] provides base flight price
  static double calculateTotalPrice(
    List<String> selectedSeats,
    Aircraft aircraft,
    FlightDetails flight,
  ) {
    double totalPrice = 0;

    // Group selected seats by class
    final seatsByClass = <String, List<String>>{};
    for (var seatNumber in selectedSeats) {
      final seat = aircraft.seats.firstWhere(
        (s) => s.seatNumber == seatNumber,
        orElse:
            () => Seat(
              id: 0,
              seatNumber: seatNumber,
              seatClass: 'ECONOMY', // Default to economy if seat not found
              reserved: false,
              exitRow: false,
              extraLegroom: false,
              windowSeat: false,
            ),
      );
      seatsByClass.putIfAbsent(seat.seatClass, () => []).add(seatNumber);
    }

    // Calculate price for each class
    for (var entry in seatsByClass.entries) {
      final seatClass = entry.key;
      final numberOfSeats = entry.value.length;
      final config = aircraft.configurations.firstWhere(
        (c) => c.className.toUpperCase() == seatClass.toUpperCase(),
        orElse:
            () => SeatConfiguration(
              className: seatClass,
              seatLayout: '',
              color: '#000000',
              numberOfRows: 0,
              priceMultiplier: 1.0, // Default to 1.0 if config not found
            ),
      );

      // Calculate price for this class: base price * multiplier * number of seats
      totalPrice += flight.price * config.priceMultiplier * numberOfSeats;
    }

    return totalPrice;
  }
}
