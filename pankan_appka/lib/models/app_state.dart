import 'package:meta/meta.dart';
import 'package:pankan_appka/models/workers_app_state.dart';

enum AppTab { tasks, tasksMap }

@immutable
class AppState {
  final bool isLoading;
  final DateTime choosenDay;
  final Worker loggedInWorker;
  final Iterable<WorkerDayTask> workerTasks;
  final AppTab activeTab;

  AppState(
      {
        this.isLoading = false,
        this.choosenDay,
        this.loggedInWorker,
        this.workerTasks = const [],
        this.activeTab = AppTab.tasks});

  factory AppState.loading() => AppState(isLoading: true);

  WorkerDayTask get currentDay => workerTasks.firstWhere((task) => task.date == choosenDay, orElse: () => WorkerDayTask(date: choosenDay, firms: []));

  AppState copyWith({
    bool isLoading,
    Worker worker,
    Iterable<WorkerDayTask> tasks,
    AppTab activeTab
    }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      loggedInWorker: worker ?? this.loggedInWorker,
      workerTasks: tasks ?? this.workerTasks,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      loggedInWorker.hashCode ^
      workerTasks.hashCode ^
      activeTab.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          loggedInWorker == other.loggedInWorker &&
          workerTasks == other.workerTasks &&
          activeTab == other.activeTab;

}