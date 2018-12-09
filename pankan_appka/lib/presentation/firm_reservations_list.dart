import 'package:flutter/material.dart';
import 'package:pankan_appka/models/models.dart';

class FirmReservationsList extends StatelessWidget {
  final Firm _firm;

  FirmReservationsList(this._firm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rezerwacje ${_firm.name}"),
        ),
        body: ListView.builder(
            itemCount: _firm.reservations.length,
            itemBuilder: (context, i) => Card(
                color: Theme.of(context).cardColor,
                child: FirmReservationItem(_firm.reservations[i]))));
  }
}

class FirmReservationItem extends StatelessWidget {
  final Reservation _reservation;

  FirmReservationItem(this._reservation);

  List<Widget> buildList(BuildContext context) {
    List<Widget> l = [];
    l.add(Text("#${_reservation.reservationId}",
        style: Theme.of(context).textTheme.title.apply(
            fontSizeFactor: 1.2,
            fontWeightDelta: 3,
            color: Theme.of(context).accentColor)));

    l.addAll(_reservation.reservationItems
        .map((ri) => ListTile(
            leading: Container(
                width: 60.0,
                height: 60.0,
                alignment: Alignment.center,
                child: Image.network("${ri.itemImageUrl}")),
            title: Text(ri.name,
                style: Theme.of(context).textTheme.subhead.apply(
                    fontSizeDelta: 2,
                    fontWeightDelta: 3,
                    color: Colors.amber[900])),
            trailing: Column(children: <Widget>[
              Text("${ri.quantity} sz",
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .apply(fontSizeDelta: 2.5)),
              Text("${ri.priceTotal} zl.",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .apply(fontSizeDelta: 4, fontWeightDelta: 10)),
            ])))
        .toList());
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildList(context));
  }
}
