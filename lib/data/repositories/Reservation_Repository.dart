import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Reservation.dart';
import 'package:tcc/widgets/config.dart';

abstract class IReservationRepository {
  Future<List<Reservation>> getReservationByResident(int id);
}

class ReservationRepository implements IReservationRepository {
  final IHttpClient client;

  ReservationRepository({required this.client});

  @override
  Future<List<Reservation>> getReservationByResident(int id) async {
    final response = await client.get(address: "/reservation/resident=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<Reservation> reservationList = [];
      body.map((item) {
        final Reservation reservation = Reservation.fromMap(item);
        reservationList.add(reservation);
      }).toList();
      return reservationList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("Usuário ou senha inválido!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
