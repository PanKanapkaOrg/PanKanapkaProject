import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    activeTab: tabsReducer(state.activeTab, action),
    choosenDay: updateChoosenDayReducer(state.choosenDay, action),
    loggedInWorker: state.loggedInWorker,
    isLoading: loadingReducer(state.isLoading, action),
    workerTasks: workerTasksReducer(state.workerTasks, action)
    );
}

final updateChoosenDayReducer = TypedReducer<DateTime, dynamic>((state, action) =>
  action is ChangeDayAction ? action.choosenDay : state
);

final workerTasksReducer = TypedReducer<Iterable<WorkerDayTask>, dynamic>((state, action){
  if(action is WorkerTasksLoadedAction) {
    return List<WorkerDayTask>.from(action.tasks)..addAll(state);
  }
  return state;
});

final loadingReducer = combineReducers<bool>(
  [
    TypedReducer<bool, LoadWorkerTasksAction>((state, action) => true),
    TypedReducer<bool, WorkerTasksLoadedAction>((state, action) => false),
    TypedReducer<bool, WorkerTasksNotLoadedAction>((state, action) => false)
  ]
);

final tabsReducer = TypedReducer<AppTab, UpdateTabAction>((activeTab, action) => action.newTab);