import 'package:pankan_appka/models/models.dart';

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}

class LoadWorkerTasksAction {
  final DateTime date;

  LoadWorkerTasksAction({this.date});
}

class WorkerTasksNotLoadedAction {}

class WorkerTasksLoadedAction {
  final List<WorkerDayTask> tasks;

  WorkerTasksLoadedAction(this.tasks);
}

class ChangeDayAction {
  final DateTime choosenDay;

  ChangeDayAction({this.choosenDay});
}

class WorkerLoggedInAction {
  Worker worker;

  WorkerLoggedInAction(this.worker);
}