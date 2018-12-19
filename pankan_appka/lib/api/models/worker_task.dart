import 'package:json_annotation/json_annotation.dart';
import 'package:pankan_appka/api/models/task_item.dart';
import 'package:pankan_appka/api/models/worker.dart';

part 'worker_task.g.dart';

@JsonSerializable()
class WorkerTask {
  final Worker worker;
  final Iterable<TaskItem> taskItems;
  WorkerTask(this.worker, this.taskItems);

  static WorkerTask fromJson(Map<String, dynamic> jsonMap) => _$WorkerTaskFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$WorkerTaskToJson(this);
}