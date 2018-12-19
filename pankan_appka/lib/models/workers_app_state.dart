import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

class WorkerDayTask {
  final DateTime date;
  final Iterable<Firm> firms;

  WorkerDayTask({this.date, this.firms});
}

class Firm {
  final int id;
  final String logoUrl;
  final String name;
  final bool isActiveTask;
  final Placemark position;
  final List<Reservation> reservations;

  Firm({
    @required this.id,
    @required this.name, 
    @required this.isActiveTask, 
    @required this.position,
    @required this.reservations,
    this.logoUrl});

  @override
    int get hashCode => 
      name.hashCode ^ isActiveTask.hashCode ^ position.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Firm &&
        runtimeType == other.runtimeType &&
        name == other.name &&
        isActiveTask == other.isActiveTask &&
        position == other.position;
}

class Worker {
  final int id;
  final String name;
  final String surname;
  final int cateringFirmId;

  const Worker({this.id, this.name, this.surname, this.cateringFirmId});

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ surname.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Worker &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          surname == other.surname;
}


class ReservationItem {
  final String name;
  final int quantity;
  final double priceTotal;
  final String itemImageUrl;

  ReservationItem({
    this.name,
    this.quantity,
    this.priceTotal,
    this.itemImageUrl
  });
}

class Reservation {
  final int reservationId;
  final int clientFirmId;
  final bool isActiveReservation;
  final List<ReservationItem> reservationItems;

  Reservation({this.reservationId, this.clientFirmId, this.isActiveReservation, this.reservationItems});
}
