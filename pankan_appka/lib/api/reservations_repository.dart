import 'dart:convert';

import 'package:pankan_appka/api/http_requester.dart';
import 'package:pankan_appka/api/models/models.dart';

class ReservationsRepository {

  final HttpRequester requester;

  ReservationsRepository(this.requester);

  Future<List<Reservation>> getWorkerReservations(ReservationsFilter filter) async {
    String response = await requester.post("api/reservations", filter.toJson());

    final responseJson = json.decode(response) as List<dynamic>;
    return responseJson.map<Reservation>((i) => Reservation.fromJson(i)).toList();
  }
}