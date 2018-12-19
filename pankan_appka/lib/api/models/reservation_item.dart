import 'package:json_annotation/json_annotation.dart';

part 'reservation_item.g.dart';

@JsonSerializable()
class ReservationItem {
  final String name;
  final int quantity;
  final double priceTotal;
  final String itemImageUrl;

  ReservationItem({
    this.name,
    this.quantity,
    this.priceTotal,
    this.itemImageUrl
  });

  static fromJson(Map<String, dynamic> jsonMap) => _$ReservationItemFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$ReservationItemToJson(this);
}