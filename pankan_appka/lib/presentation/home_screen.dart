import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/containers/active_tab.dart';
import 'package:pankan_appka/containers/app_loading.dart';
import 'package:pankan_appka/containers/choose_day.dart';
import 'package:pankan_appka/containers/firm_tasks_list.dart';
import 'package:pankan_appka/containers/tab_selector.dart';
import 'package:pankan_appka/containers/tasks_map.dart';
import 'package:pankan_appka/models/models.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  Widget getTab(AppTab tab) {
    switch(tab) {
      case AppTab.tasks:
        return FirmTasksList();
      case AppTab.tasksMap:
        return TasksMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(builder: (BuildContext context, AppTab appTab) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Serwis kateringowy'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.power_settings_new),
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(WorkerLogOffAction())),
              SizedBox(width: 20)
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: ChooseDayBar()
                ),
              ),
          ),
          body: Padding(
            padding: EdgeInsets.all(0.0),
            child: AppLoading(builder: (context, isLoading) {
                  return isLoading
                      ? Center(child: CircularProgressIndicator())
                      : getTab(appTab);
                })
            ),
          bottomNavigationBar: TabSelector(),
        );
    });
  }
}
