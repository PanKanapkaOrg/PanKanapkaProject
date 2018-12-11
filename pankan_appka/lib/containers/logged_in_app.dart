import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/models/models.dart';

class LoggedInApp extends StatelessWidget {
  final ViewModelBuilder<bool> builder;
  
  LoggedInApp({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.loggedInWorker != null,
      builder: builder);
  }
}