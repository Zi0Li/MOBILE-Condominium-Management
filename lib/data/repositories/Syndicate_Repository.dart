
import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Syndicate.dart';

abstract class ISyndicateRepository {
  Future<Syndicate> getSyndicate();
}

class SyndicateRepository implements ISyndicateRepository {
  final IHttpClient client;

 SyndicateRepository({required this.client});

  @override
  Future<Syndicate> getSyndicate() async {
    print('TESTE 2');

    final response = await client.get(address: "/auth/login");
    print('RESPONSE: ${response.statusCode}');
    if (response.statusCode == 200) {
      
      final body = jsonDecode(response.body);
      return Syndicate.fromMap(body['entity']);

    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw Exception("não foi possivel carregar os Funcionarios");
    }
  }
}