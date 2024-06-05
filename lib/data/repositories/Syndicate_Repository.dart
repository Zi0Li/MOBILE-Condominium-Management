import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Syndicate.dart';

abstract class ISyndicateRepository {
  Future<Syndicate> getSyndicateById(int id);
}

class SyndicateRepository implements ISyndicateRepository {
  final IHttpClient client;

  SyndicateRepository({required this.client});

  @override
  Future<Syndicate> getSyndicateById(int id) async {
    final response = await client.get(address: "/syndicate/$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Syndicate.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw Exception("não foi possivel carregar os Funcionarios");
    }
  }
}
