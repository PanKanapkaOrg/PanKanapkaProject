import 'package:json_annotation/json_annotation.dart';
import 'package:pankan_appka/api/models/reservation_item.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  final int reservationId;
  final int clientFirmId;
  final bool isActiveReservation;
  final List<ReservationItem> reservationItems;

  Reservation({this.reservationId, this.clientFirmId, this.isActiveReservation, this.reservationItems});

  static fromJson(Map<String, dynamic> jsonMap) => _$ReservationFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}