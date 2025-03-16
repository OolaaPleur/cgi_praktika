// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aircraft _$AircraftFromJson(Map<String, dynamic> json) => Aircraft(
  id: (json['id'] as num).toInt(),
  modelName: json['modelName'] as String,
  manufacturer: json['manufacturer'] as String,
  totalSeats: (json['totalSeats'] as num).toInt(),
  configurations:
      (json['configurations'] as List<dynamic>)
          .map((e) => SeatConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
  seats:
      (json['seats'] as List<dynamic>)
          .map((e) => Seat.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AircraftToJson(Aircraft instance) => <String, dynamic>{
  'id': instance.id,
  'modelName': instance.modelName,
  'manufacturer': instance.manufacturer,
  'totalSeats': instance.totalSeats,
  'configurations': instance.configurations,
  'seats': instance.seats,
};

SeatConfiguration _$SeatConfigurationFromJson(Map<String, dynamic> json) =>
    SeatConfiguration(
      className: json['className'] as String,
      seatLayout: json['seatLayout'] as String,
      color: json['color'] as String,
      numberOfRows: (json['numberOfRows'] as num).toInt(),
      priceMultiplier: (json['priceMultiplier'] as num).toDouble(),
    );

Map<String, dynamic> _$SeatConfigurationToJson(SeatConfiguration instance) =>
    <String, dynamic>{
      'className': instance.className,
      'seatLayout': instance.seatLayout,
      'color': instance.color,
      'numberOfRows': instance.numberOfRows,
      'priceMultiplier': instance.priceMultiplier,
    };

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
  id: (json['id'] as num).toInt(),
  seatNumber: json['seatNumber'] as String,
  seatClass: json['seatClass'] as String,
  windowSeat: json['windowSeat'] as bool,
  reserved: json['reserved'] as bool,
  extraLegroom: json['extraLegroom'] as bool,
  exitRow: json['exitRow'] as bool,
);

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
  'id': instance.id,
  'seatNumber': instance.seatNumber,
  'seatClass': instance.seatClass,
  'windowSeat': instance.windowSeat,
  'reserved': instance.reserved,
  'extraLegroom': instance.extraLegroom,
  'exitRow': instance.exitRow,
};
