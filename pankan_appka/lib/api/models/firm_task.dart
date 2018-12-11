import 'package:json_annotation/json_annotation.dart';

part 'firm_task.g.dart';

@JsonSerializable()
class FirmTask {
  final int id;
  final String logoUrl;
  final String name;
  final bool isActiveTask;
  final String address;

  FirmTask(this.id, this.name, this.address, this.isActiveTask, {this.logoUrl});

  static fromJson(Map<String, dynamic> jsonMap) => _$FirmTaskFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$FirmTaskToJson(this);
}