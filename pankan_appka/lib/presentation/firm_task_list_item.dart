import 'package:flutter/material.dart';
import 'package:pankan_appka/models/models.dart';
import 'package:pankan_appka/presentation/firm_reservations_list.dart';

class FirmTaskListItem extends StatelessWidget {
  final Firm _firm;

  FirmTaskListItem(this._firm);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardColor,
        elevation: 3.0,
        child: ListTile(
            leading: Container(
                width: 60.0,
                height: 60.0,
                alignment: Alignment.center,
                child: Image.network("${_firm.logoUrl}")
              ),
            onTap: () {
              if (_firm.reservations.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FirmReservationsList(_firm),
                ));
              }
            },
            title: Text(_firm.name,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .apply(fontSizeDelta: 2.5, fontWeightDelta: 2)),
            subtitle: Text(
                "${_firm.position.locality} ${_firm.position.thoroughfare} ${_firm.position.name}",
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .apply(fontWeightDelta: 3)),
            trailing: Column(children: <Widget>[
              Text("${_firm.reservations.length}",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .apply(fontWeightDelta: 3, color: Theme.of(context).accentColor)),
              //Text("${_product.amount} ${_product.unit}", style: Theme.of(context).textTheme.caption.apply(fontSizeDelta: 2.5)),
            ])));
  }
}
