import 'package:json_annotation/json_annotation.dart';

part 'task_filter.g.dart';

@JsonSerializable()
class TaskFilter {
  final Iterable<int> workerIds;
  final DateTime date;
  final int daysBefore;
  final int daysAfter;
  TaskFilter({this.workerIds, this.date, this.daysBefore = 1, this.daysAfter = 1});

  fromJson(Map<String, dynamic> jsonMap) {
    // List<BigInt> workers = new List<BigInt>.from(jsonMap['WorkerIds']);
    // DateTime date = jsonMap['Date'];
    // int daysBefore = jsonMap['DaysBefore'];
    // int daysAfter = jsonMap['DaysAfter'];

    // return TaskFilter(workers, date, daysBefore: daysBefore, daysAfter: daysAfter);
    return _$TaskFilterFromJson(jsonMap);
  }

  Map<String, dynamic> toJson() {
    // return {
    //   "WorkerIds" : workerIds,
    // };
    return _$TaskFilterToJson(this);
  }
}