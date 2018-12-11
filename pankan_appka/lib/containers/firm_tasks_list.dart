import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:pankan_appka/presentation/firm_task_list_item.dart';

class FirmTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => state.currentDay.firms.isEmpty ? 
      Center(child: Text("Nie ma zadan na na ten dzien", style: Theme.of(context).textTheme.headline)) : 
      Column(children:
        state.currentDay.firms.map((f) => FirmTaskListItem(f)).toList()
      ));
  }
}