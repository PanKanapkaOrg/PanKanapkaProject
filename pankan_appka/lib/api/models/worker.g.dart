// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worker _$WorkerFromJson(Map<String, dynamic> json) {
  return Worker(
      json['id'] as int, json['name'] as String, json['surname'] as String);
}

Map<String, dynamic> _$WorkerToJson(Worker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname
    };
