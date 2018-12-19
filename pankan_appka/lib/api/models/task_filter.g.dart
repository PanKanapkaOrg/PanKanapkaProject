// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskFilter _$TaskFilterFromJson(Map<String, dynamic> json) {
  return TaskFilter(workerIds: (json['workerIds'] as List)?.map((e) => e as int),
      date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
      daysBefore: json['daysBefore'] as int,
      daysAfter: json['daysAfter'] as int);
}

Map<String, dynamic> _$TaskFilterToJson(TaskFilter instance) =>
    <String, dynamic>{
      'workerIds': instance.workerIds?.toList(),
      'date': instance.date?.toIso8601String(),
      'daysBefore': instance.daysBefore,
      'daysAfter': instance.daysAfter
    };
