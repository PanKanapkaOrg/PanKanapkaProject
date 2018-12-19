import 'package:json_annotation/json_annotation.dart';

part 'reservations_filter.g.dart';

@JsonSerializable()
class ReservationsFilter {
  final DateTime date;
  final int cateringFirmId;
  final List<int> clientFirmIds;

  ReservationsFilter({this.date, this.cateringFirmId, this.clientFirmIds});

  static fromJson(Map<String, dynamic> jsonMap) => _$ReservationsFilterFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$ReservationsFilterToJson(this);
}