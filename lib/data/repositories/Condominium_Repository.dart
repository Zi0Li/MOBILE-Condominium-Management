import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/widgets/config.dart';

abstract class ICondominiumRepository {
  Future<dynamic> getCondominiumByCode(int code);
}

class CondominiumRepository implements ICondominiumRepository {
  final IHttpClient client;

  CondominiumRepository({required this.client});

  @override
  Future<dynamic> getCondominiumByCode(int code) async {

    final response = await client.get(address: "/condominium/code=$code");
    print('Depois da requisição');
    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {    
      return Condominium.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("Código do condomínio inválido!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException(Config.textToUtf8(body['message']));
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
