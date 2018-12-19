// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firm_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirmTask _$FirmTaskFromJson(Map<String, dynamic> json) {
  return FirmTask(json['id'] as int, json['name'] as String,
      json['address'] as String, json['isActiveTask'] as bool,
      logoUrl: json['logoUrl'] as String);
}

Map<String, dynamic> _$FirmTaskToJson(FirmTask instance) => <String, dynamic>{
      'id': instance.id,
      'logoUrl': instance.logoUrl,
      'name': instance.name,
      'isActiveTask': instance.isActiveTask,
      'address': instance.address
    };
