import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:redux/redux.dart';

class TasksMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return GestureDetector(
            child: new FlutterMap(
              options: new MapOptions(
                center: new LatLng(51.786029, 19.392623),
                zoom: 12.0,
              ),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(markers: vm.markers)
              ],
            ),
          );
      },
    );
  }
}

class _ViewModel {
  List<Marker> markers;

  _ViewModel(this.markers);

  static _ViewModel fromStore(Store<AppState> store) {
    List<Marker> markers = [];

    markers = store.state.currentDay.firms
          .map((f) => Marker(
              width: 40.0,
              height: 40.0,
              point: new LatLng(
                  f.position.position.latitude, f.position.position.longitude),
              builder: (ctx) => new Container(
                  key: new Key("blue"),
                  child: new Icon(Icons.location_on,
                      color: Colors.blue.shade400))))
          .toList();

    return _ViewModel(markers);
  }
}
