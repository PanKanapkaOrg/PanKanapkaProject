import 'package:json_annotation/json_annotation.dart';
import 'package:pankan_appka/api/models/firm_task.dart';

part 'task_item.g.dart';

@JsonSerializable()
class TaskItem {
 final DateTime date;
 final Iterable<FirmTask> firms;
 TaskItem(this.date, this.firms);

  static fromJson(Map<String, dynamic> jsonMap) => _$TaskItemFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}