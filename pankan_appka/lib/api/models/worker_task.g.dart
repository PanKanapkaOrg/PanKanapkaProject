// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerTask _$WorkerTaskFromJson(Map<String, dynamic> json) {
  return WorkerTask(
      json['worker'] == null
          ? null
          : Worker.fromJson(json['worker'] as Map<String, dynamic>),
      (json['taskItems'] as List)?.map((e) =>
          e == null ? null : TaskItem.fromJson(e as Map<String, dynamic>)));
}

Map<String, dynamic> _$WorkerTaskToJson(WorkerTask instance) =>
    <String, dynamic>{
      'worker': instance.worker,
      'taskItems': instance.taskItems?.toList()
    };
