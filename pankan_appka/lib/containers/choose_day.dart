import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/models/app_state.dart';
import 'package:redux/redux.dart';

class ChooseDayBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, viewModel) => Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
                child: IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () => viewModel.chooseYesterday(),
              color: Colors.white,
            )),
            Expanded(
                flex: 3,
                child: Text(
                  DateFormat.yMMMd("en_US").format(viewModel.choosenDay),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors
                          .white), // TextStyle(color: Colors.white, fontSize: 24),
                )),
            Expanded(
                child: IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () => viewModel.chooseTomorrow(),
                      color: Colors.white,
                    )),
          ])),
    );
  }
}

class _ViewModel {
  final DateTime choosenDay;
  final Function chooseYesterday;
  final Function chooseTomorrow;

  _ViewModel({this.chooseYesterday, this.choosenDay, this.chooseTomorrow});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        chooseYesterday: () => store.dispatch(ChangeDayAction(
            choosenDay: store.state.choosenDay.subtract(Duration(days: 1)))),
        choosenDay: store.state.choosenDay,
        chooseTomorrow: () => store.dispatch(ChangeDayAction(
            choosenDay: store.state.choosenDay.add(Duration(days: 1)))),
      );
}
