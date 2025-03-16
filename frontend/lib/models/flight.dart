import 'package:json_annotation/json_annotation.dart';
import 'package:frontend/utils/date_utils.dart';
import 'aircraft.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight {
  final int id;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final double price;
  final String companyName;
  final int flightDurationMinutes;
  final String companyPhotoId;
  final String arrivalAirportImageUrl;
  final String departureAirportImageUrl;
  final int aircraftId;
  final String arrivalContinent;

  Flight({
    required this.id,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.price,
    required this.companyName,
    required this.flightDurationMinutes,
    required this.companyPhotoId,
    required this.arrivalAirportImageUrl,
    required this.departureAirportImageUrl,
    required this.aircraftId,
    required this.arrivalContinent,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);
  Map<String, dynamic> toJson() => _$FlightToJson(this);
}

@JsonSerializable()
class FlightDetails {
  final int id;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureDateTime;
  final DateTime arrivalDateTime;
  final int flightDurationMinutes;
  final double price;
  final String companyName;
  final Aircraft aircraft;
  final String companyPhotoId;
  final String departureAirportImageUrl;
  final String arrivalAirportImageUrl;

  FlightDetails({
    required this.id,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.flightDurationMinutes,
    required this.price,
    required this.companyName,
    required this.aircraft,
    required this.companyPhotoId,
    required this.departureAirportImageUrl,
    required this.arrivalAirportImageUrl,
  });

  factory FlightDetails.fromJson(Map<String, dynamic> json) =>
      _$FlightDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightDetailsToJson(this);
}

extension FlightDuration on Flight {
  String get duration {
    return formatDuration(arrivalDateTime.difference(departureDateTime));
  }
}

extension FlightDurationDetails on FlightDetails {
  String get duration {
    return formatDuration(arrivalDateTime.difference(departureDateTime));
  }
}

extension FlightListExtensions on List<Flight> {
  Set<String> get uniqueContinents {
    return map((flight) => flight.arrivalContinent).toSet();
  }
}
