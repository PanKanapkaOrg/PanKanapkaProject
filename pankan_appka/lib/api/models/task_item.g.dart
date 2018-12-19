// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) {
  return TaskItem(
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      (json['firms'] as List)?.map((e) =>
          e == null ? null : FirmTask.fromJson(e as Map<String, dynamic>)));
}

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'firms': instance.firms?.toList()
    };
