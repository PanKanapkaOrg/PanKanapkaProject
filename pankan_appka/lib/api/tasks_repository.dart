import 'dart:convert';
import 'dart:async';

import 'package:pankan_appka/api/components/tasks_repository.dart';
import 'package:pankan_appka/api/http_requester.dart';
import 'package:pankan_appka/api/models/models.dart';

class ApiTasksRepository implements ITasksRepository {
  final HttpRequester requester;

  ApiTasksRepository(this.requester);

  @override
  Future<Iterable<WorkerTask>> getWorkerTasks(TaskFilter taskFilter) async {
    String response = await requester.post("api/tasks", taskFilter.toJson());

    final responseJson = json.decode(response) as List<dynamic>;
    return responseJson.map((i) => WorkerTask.fromJson(i)).toList();
  }
}
