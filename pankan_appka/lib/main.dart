import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:pankan_appka/presentation/home_screen.dart';
import 'package:redux/redux.dart';
import 'package:pankan_appka/reducers/reducers.dart';
import 'package:pankan_appka/middleware/worker_tasks_middleware.dart';

void main() {
  final store = new Store<AppState>(
      appReducer,
      initialState: AppState.loading().copyWith(worker: Worker(
        id: 2,
        name: "Yevhenii",
        surname: "Kyshko",
        cateringFirmId: 2
      )),
      middleware: createWorkerTasksMiddleware());
  runApp(
    StoreProvider<AppState>(
        store: store,
        
      child: PanKanapkaApp()
    ));
}

class PanKanapkaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Serwis kateringowy',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: HomeScreen(
            onInit: () {
              StoreProvider.of<AppState>(context).dispatch(
                ChangeDayAction(choosenDay: DateTime.parse("2018-10-27"))
              );
            },
          ),
        );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   ApiTasksRepository repo = new ApiTasksRepository(new ApiHttpRequester());
//   List<Marker> markers = [];

//   List<String> _getAddreses(List<WorkerTask> tasks) {
//     List<String> addreses = [];
//     tasks.forEach((task) {
//       task.taskItems.forEach((taksItem) {
//         taksItem.firms.forEach((f) {
//           addreses.add(f.address);
//         });
//       });
//     });

//     return addreses;
//   }

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       // repo
//       //     .getWorkerTasks(new TaskFilter([2], DateTime.parse("2018-10-27"),
//       //         daysBefore: 1, daysAfter: 1))
//       //     .then((tasks) {
//       //   var addreses = _getAddreses(tasks);
//       //   addreses.forEach((a) {
//       //     Geolocator()
//       //         .placemarkFromAddress("$a, Lodz", localeIdentifier: "pl_PL")
//       //         .then((placemarks) {
//       //       var position = placemarks.first.position;
//       //       markers.add(new Marker(
//       //           width: 20.0,
//       //           height: 20.0,
//       //           point: new LatLng(position.latitude, position.longitude),
//       //           builder: (ctx) => new Container(
//       //               key: new Key("blue"), child: new Icon(Icons.location_on))));
//       //     });
//       //   });
//       // });
//       _counter++;
//     });
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   // This method is rerun every time setState is called, for instance as done
//   //   // by the _incrementCounter method above.
//   //   //
//   //   // The Flutter framework has been optimized to make rerunning build methods
//   //   // fast, so that you can just rebuild anything that needs updating rather
//   //   // than having to individually change instances of widgets.
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       // Here we take the value from the MyHomePage object that was created by
//   //       // the App.build method, and use it to set our appbar title.
//   //       title: Text(widget.title),
//   //     ),
//   //     body: Center(
//   //       // Center is a layout widget. It takes a single child and positions it
//   //       // in the middle of the parent.
//   //       child: Column(
//   //         // Column is also layout widget. It takes a list of children and
//   //         // arranges them vertically. By default, it sizes itself to fit its
//   //         // children horizontally, and tries to be as tall as its parent.
//   //         //
//   //         // Invoke "debug painting" (press "p" in the console, choose the
//   //         // "Toggle Debug Paint" action from the Flutter Inspector in Android
//   //         // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//   //         // to see the wireframe for each widget.
//   //         //
//   //         // Column has various properties to control how it sizes itself and
//   //         // how it positions its children. Here we use mainAxisAlignment to
//   //         // center the children vertically; the main axis here is the vertical
//   //         // axis because Columns are vertical (the cross axis would be
//   //         // horizontal).
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: <Widget>[
//   //           Text(
//   //             'You have pushed the button this many times:',
//   //           ),
//   //           Text(
//   //             '$_counter',
//   //             style: Theme.of(context).textTheme.display1,
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     floatingActionButton: FloatingActionButton(
//   //       onPressed: _incrementCounter,
//   //       tooltip: 'Increment',
//   //       child: Icon(Icons.add),
//   //     ), // This trailing comma makes auto-formatting nicer for build methods.
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: new Padding(
//         padding: new EdgeInsets.all(8.0),
//         child: new Column(
//           children: [
//             new Padding(
//               padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
//               child: new Text("This is a map that is showing (51.5, -0.9)."),
//             ),
//             new Flexible(
//               child: new FlutterMap(
//                 options: new MapOptions(
//                   center: new LatLng(51.5, 19.11),
//                   zoom: 8.0,
//                 ),
//                 layers: [
//                   new TileLayerOptions(
//                       urlTemplate:
//                           "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                       subdomains: ['a', 'b', 'c']),
//                   new MarkerLayerOptions(markers: markers)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
