import 'dart:convert';

import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/widgets/config.dart';

abstract class IKioskRepository {
  Future<List<Kiosk>> getAllKioskByResident(int id);
  Future<List<ReservationAndKioskDTO>> getAllDetails(int id);
}

class KioskRepository implements IKioskRepository {
  final IHttpClient client;

  KioskRepository({required this.client});

  @override
  Future<List<Kiosk>> getAllKioskByResident(int id) async {
    final response =
        await client.get(address: "/kiosk/resident=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<Kiosk> kioskList = [];
      body.map((item) {
        final Kiosk kiosk = Kiosk.fromMap(item['kiosk']);
        kioskList.add(kiosk);
      }).toList();
      return kioskList;
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

  @override
  Future<List<ReservationAndKioskDTO>> getAllDetails(int id) async {
    final response =
        await client.get(address: "/kiosk/all/$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<ReservationAndKioskDTO> list = [];
      body.map((item) {
        list.add(ReservationAndKioskDTO.fromMap(item));
      }).toList();
      return list;
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
