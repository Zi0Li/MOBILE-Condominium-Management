import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';

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
    if (response.statusCode == 200) {
      
      final body = jsonDecode(response.body);
      Condominium condo = Condominium.fromMap(body);
      print("Condo: $condo");
      return Condominium.fromMap(body);

    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw Exception("não foi possivel carregar os Funcionarios");
    }
  }
}
