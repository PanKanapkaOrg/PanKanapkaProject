import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      activeTab: tabsReducer(state.activeTab, action),
      choosenDay: updateChoosenDayReducer(state.choosenDay, action),
      loggedInWorker: loggedInWorkerReducer(state.loggedInWorker, action),
      isLoading: loadingReducer(state.isLoading, action),
      workerTasks: workerTasksReducer(state.workerTasks, action));
}

final updateChoosenDayReducer = TypedReducer<DateTime, dynamic>(
    (state, action) => action is ChangeDayAction ? action.choosenDay : state);

final workerTasksReducer = combineReducers<Iterable<WorkerDayTask>>([
  TypedReducer<Iterable<WorkerDayTask>, WorkerTasksLoadedAction>(
      (state, action) => List<WorkerDayTask>.from(action.tasks)..addAll(state)),
  TypedReducer<Iterable<WorkerDayTask>, WorkerLogOffAction>(
      (state, action) => [])
]);

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, WorkerLogOffAction>((state, action){ print("Inside logoff reducer"); return false; }),
  TypedReducer<bool, WorkerLoggingInAction>((state, action) => true),
  TypedReducer<bool, LoadWorkerTasksAction>((state, action) => true),
  TypedReducer<bool, WorkerTasksLoadedAction>((state, action) => false),
  TypedReducer<bool, WorkerTasksNotLoadedAction>((state, action) => false)
]);

final tabsReducer =
    TypedReducer<AppTab, UpdateTabAction>((activeTab, action) => action.newTab);

final loggedInWorkerReducer = combineReducers<Worker>([
  TypedReducer<Worker, WorkerLoggedInAction>(
      (activeTab, action) => action.worker),
  TypedReducer<Worker, WorkerLogOffAction>((activeTab, action) => null),
]);
