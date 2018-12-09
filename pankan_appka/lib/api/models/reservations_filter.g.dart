// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationsFilter _$ReservationsFilterFromJson(Map<String, dynamic> json) {
  return ReservationsFilter(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      cateringFirmId: json['cateringFirmId'] as int,
      clientFirmIds:
          (json['clientFirmIds'] as List)?.map((e) => e as int)?.toList());
}

Map<String, dynamic> _$ReservationsFilterToJson(ReservationsFilter instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'cateringFirmId': instance.cateringFirmId,
      'clientFirmIds': instance.clientFirmIds
    };
