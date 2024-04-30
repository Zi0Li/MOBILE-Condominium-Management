import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/config.dart';

abstract class IResidentRepository {
  Future<Resident> getResident(int id);
}

class ResidentRepository implements IResidentRepository {
  final IHttpClient client;

  ResidentRepository({required this.client});

  @override
  Future<Resident> getResident(int id) async {
    final response = await client.get(address: "/resident/$id", withToken: true);
    // print('Depois da requisição');
    // print('STATUS CODE: ${response.statusCode}');
    // print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Resident.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException(Config.textToUtf8(body['message']));
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
