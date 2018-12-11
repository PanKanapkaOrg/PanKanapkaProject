import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Worker {
  final int id;
  final String name; 
  final String surname;
  Worker(this.id, this.name, this.surname);

  static fromJson(Map<String, dynamic> jsonMap) => _$WorkerFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$WorkerToJson(this);
}