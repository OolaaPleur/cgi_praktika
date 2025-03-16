import 'package:json_annotation/json_annotation.dart';

part 'aircraft.g.dart';

@JsonSerializable()
class Aircraft {
  final int id;
  final String modelName;
  final String manufacturer;
  final int totalSeats;
  final List<SeatConfiguration> configurations;
  final List<Seat> seats;

  Aircraft({
    required this.id,
    required this.modelName,
    required this.manufacturer,
    required this.totalSeats,
    required this.configurations,
    required this.seats,
  });

  factory Aircraft.fromJson(Map<String, dynamic> json) =>
      _$AircraftFromJson(json);
  Map<String, dynamic> toJson() => _$AircraftToJson(this);
}

@JsonSerializable()
class SeatConfiguration {
  final String className;
  final String seatLayout;
  final String color;
  final int numberOfRows;
  final double priceMultiplier;

  SeatConfiguration({
    required this.className,
    required this.seatLayout,
    required this.color,
    required this.numberOfRows,
    required this.priceMultiplier,
  });

  factory SeatConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SeatConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$SeatConfigurationToJson(this);
}

@JsonSerializable()
class Seat {
  final int id;
  final String seatNumber;
  final String seatClass;
  final bool windowSeat;
  final bool reserved;
  final bool extraLegroom;
  final bool exitRow;

  Seat({
    required this.id,
    required this.seatNumber,
    required this.seatClass,
    required this.windowSeat,
    required this.reserved,
    required this.extraLegroom,
    required this.exitRow,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);
  Map<String, dynamic> toJson() => _$SeatToJson(this);
}
