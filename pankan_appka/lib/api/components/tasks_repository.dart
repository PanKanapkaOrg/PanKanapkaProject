import 'package:pankan_appka/api/models/models.dart';

abstract class ITasksRepository {
  Future<Iterable<WorkerTask>> getWorkerTasks(TaskFilter taskFilter);
}