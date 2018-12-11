// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationItem _$ReservationItemFromJson(Map<String, dynamic> json) {
  return ReservationItem(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      priceTotal: (json['priceTotal'] as num)?.toDouble(),
      itemImageUrl: json['itemImageUrl'] as String);
}

Map<String, dynamic> _$ReservationItemToJson(ReservationItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'priceTotal': instance.priceTotal,
      'itemImageUrl': instance.itemImageUrl
    };
