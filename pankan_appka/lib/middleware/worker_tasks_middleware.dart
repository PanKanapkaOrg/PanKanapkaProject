import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/api/components/tasks_repository.dart';
import 'package:pankan_appka/api/http_requester.dart';
import 'package:pankan_appka/api/login_provider.dart';
import 'package:pankan_appka/api/models/models.dart' as ApiModels;
import 'package:pankan_appka/api/reservations_repository.dart';
import 'package:pankan_appka/api/tasks_repository.dart';
import 'package:pankan_appka/middleware/geocoder.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createWorkerTasksMiddleware() {
  var requester = ApiHttpRequester();
  ITasksRepository tasksRepository = ApiTasksRepository(requester);
  ReservationsRepository reservationsRepository =
      ReservationsRepository(requester);

  Geocoder geocoder = GeolocatorGeocoder();

  LoginProvider loginProvider = new LoginProvider(requester);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  return [
    TypedMiddleware<AppState, LoadWorkerTasksAction>(_loadWorkerTasksMiddleware(
        tasksRepository, reservationsRepository, geocoder)),
    TypedMiddleware<AppState, ChangeDayAction>(_changeChoosenDayMiddleware()),
    TypedMiddleware<AppState, WorkerLoggingInAction>(_workerAuthenticationMiddleware(loginProvider, _firebaseMessaging)),
  ];
}

Middleware<AppState> _loadWorkerTasksMiddleware(ITasksRepository tasksRepostory,
    ReservationsRepository reservationsRepository, Geocoder geocoder) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is LoadWorkerTasksAction) {
      ApiModels.TaskFilter tasksFilter = ApiModels.TaskFilter(
          workerIds: [store.state.loggedInWorker.id], date: action.date);

      var tasks = await tasksRepostory.getWorkerTasks(tasksFilter);

      var taskItems = tasks.map((t) => t.taskItems).expand((ti) => ti).toList();

      List<WorkerDayTask> workerDayTasks = [];

      for (var ti in taskItems) {
        var reservations = await reservationsRepository.getWorkerReservations(
            ApiModels.ReservationsFilter(
                date: ti.date,
                cateringFirmId: store.  state.loggedInWorker.cateringFirmId,
                clientFirmIds: ti.firms.map((f) => f.id).toList()));

        List<Firm> firms = [];
        for (var f in ti.firms) {
          var position = await geocoder.decodeAddress(f.address);

          firms.add(Firm(
              id: f.id,
              isActiveTask: f.isActiveTask,
              position: position,
              name: f.name,
              reservations: reservations
                  .where((r) => r.clientFirmId == f.id)
                  .map((r) => Reservation(
                      reservationId: r.reservationId,
                      clientFirmId: r.clientFirmId,
                      isActiveReservation: r.isActiveReservation,
                      reservationItems: r.reservationItems.map((ri) =>
                          ReservationItem(
                              itemImageUrl: ri.itemImageUrl,
                              name: ri.name,
                              priceTotal: ri.priceTotal,
                              quantity: ri.quantity)).toList())).toList(),
              logoUrl: f.logoUrl));

        }
        
        workerDayTasks.add(WorkerDayTask(date: ti.date, firms: firms));
      }

      store.dispatch(WorkerTasksLoadedAction(workerDayTasks));
    }
  };
}

Middleware<AppState> _changeChoosenDayMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) {
    if (action is ChangeDayAction) {
      if (!store.state.workerTasks
          .any((task) => task.date == action.choosenDay)) {
        store.dispatch(LoadWorkerTasksAction(date: action.choosenDay));
      }
    }

    next(action);
  };
}

Middleware<AppState> _workerAuthenticationMiddleware(LoginProvider loginProvider, FirebaseMessaging firebaseMessaging) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if(action is WorkerLoggingInAction)
    {
      String token = await firebaseMessaging.getToken();
      print("Before login token: $token");
      var values = await loginProvider.processLoginData(action.mail, action.password, token);
      var worker = Worker(
              cateringFirmId: values['firmId'] as int,
              id: values['id'] as int,
              name: values['name'] as String,
              surname: values['surname'] as String);

      if(worker.id != null)
      {
        print("Worker logged in");
        store.dispatch(WorkerLoggedInAction(worker));
      }
      else {
        store.dispatch(WorkerLogOffAction());
        print("Worker logged off");
        print("isLoading = ${store.state.isLoading}");
      }
    }

    next(action);
  };
}
