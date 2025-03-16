// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flight _$FlightFromJson(Map<String, dynamic> json) => Flight(
  id: (json['id'] as num).toInt(),
  departureAirport: json['departureAirport'] as String,
  arrivalAirport: json['arrivalAirport'] as String,
  departureDateTime: DateTime.parse(json['departureDateTime'] as String),
  arrivalDateTime: DateTime.parse(json['arrivalDateTime'] as String),
  price: (json['price'] as num).toDouble(),
  companyName: json['companyName'] as String,
  flightDurationMinutes: (json['flightDurationMinutes'] as num).toInt(),
  companyPhotoId: json['companyPhotoId'] as String,
  arrivalAirportImageUrl: json['arrivalAirportImageUrl'] as String,
  departureAirportImageUrl: json['departureAirportImageUrl'] as String,
  aircraftId: (json['aircraftId'] as num).toInt(),
  arrivalContinent: json['arrivalContinent'] as String,
);

Map<String, dynamic> _$FlightToJson(Flight instance) => <String, dynamic>{
  'id': instance.id,
  'departureAirport': instance.departureAirport,
  'arrivalAirport': instance.arrivalAirport,
  'departureDateTime': instance.departureDateTime.toIso8601String(),
  'arrivalDateTime': instance.arrivalDateTime.toIso8601String(),
  'price': instance.price,
  'companyName': instance.companyName,
  'flightDurationMinutes': instance.flightDurationMinutes,
  'companyPhotoId': instance.companyPhotoId,
  'arrivalAirportImageUrl': instance.arrivalAirportImageUrl,
  'departureAirportImageUrl': instance.departureAirportImageUrl,
  'aircraftId': instance.aircraftId,
  'arrivalContinent': instance.arrivalContinent,
};

FlightDetails _$FlightDetailsFromJson(Map<String, dynamic> json) =>
    FlightDetails(
      id: (json['id'] as num).toInt(),
      departureAirport: json['departureAirport'] as String,
      arrivalAirport: json['arrivalAirport'] as String,
      departureDateTime: DateTime.parse(json['departureDateTime'] as String),
      arrivalDateTime: DateTime.parse(json['arrivalDateTime'] as String),
      flightDurationMinutes: (json['flightDurationMinutes'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      companyName: json['companyName'] as String,
      aircraft: Aircraft.fromJson(json['aircraft'] as Map<String, dynamic>),
      companyPhotoId: json['companyPhotoId'] as String,
      departureAirportImageUrl: json['departureAirportImageUrl'] as String,
      arrivalAirportImageUrl: json['arrivalAirportImageUrl'] as String,
    );

Map<String, dynamic> _$FlightDetailsToJson(FlightDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'departureAirport': instance.departureAirport,
      'arrivalAirport': instance.arrivalAirport,
      'departureDateTime': instance.departureDateTime.toIso8601String(),
      'arrivalDateTime': instance.arrivalDateTime.toIso8601String(),
      'flightDurationMinutes': instance.flightDurationMinutes,
      'price': instance.price,
      'companyName': instance.companyName,
      'aircraft': instance.aircraft,
      'companyPhotoId': instance.companyPhotoId,
      'departureAirportImageUrl': instance.departureAirportImageUrl,
      'arrivalAirportImageUrl': instance.arrivalAirportImageUrl,
    };
