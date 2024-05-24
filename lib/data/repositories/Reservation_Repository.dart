import 'dart:convert';

import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/widgets/config.dart';

abstract class IReservationRepository {
  Future<List<ReservationAndKioskDTO>> getReservationByResident(int id);
}

class ReservationRepository implements IReservationRepository {
  final IHttpClient client;

  ReservationRepository({required this.client});

  @override
  Future<List<ReservationAndKioskDTO>> getReservationByResident(int id) async {
    final response = await client.get(address: "/reservation/resident=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<ReservationAndKioskDTO> reservationList = [];
      body.map((item) {
        reservationList.add(ReservationAndKioskDTO.fromMap(item));
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
