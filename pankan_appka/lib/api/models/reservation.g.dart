// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
      reservationId: json['reservationId'] as int,
      clientFirmId: json['clientFirmId'] as int,
      isActiveReservation: json['isActiveReservation'] as bool,
      reservationItems: (json['reservationItems'] as List)
          ?.map<ReservationItem>((e) => e == null
              ? null
              : ReservationItem.fromJson(e))
          ?.toList());
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'clientFirmId': instance.clientFirmId,
      'isActiveReservation': instance.isActiveReservation,
      'reservationItems': instance.reservationItems
    };
