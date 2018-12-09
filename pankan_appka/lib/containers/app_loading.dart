import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/models/models.dart';

class AppLoading extends StatelessWidget {
  final ViewModelBuilder<bool> builder;
  
  AppLoading({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.isLoading,
      builder: builder);
  }
}