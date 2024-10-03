import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/widgets/config.dart';

abstract class ISyndicateRepository {
  Future<Syndicate> getSyndicateById(int id);
  Future<Syndicate> postSyndicate(dynamic syndicate, dynamic register);
}

class SyndicateRepository implements ISyndicateRepository {
  final IHttpClient client;

  SyndicateRepository({required this.client});

  @override
  Future<Syndicate> getSyndicateById(int id) async {
    final response =
        await client.get(address: "/syndicate/$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Syndicate.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Syndicate> postSyndicate(dynamic syndicate, dynamic register) async {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository(client: client);

    final response =
        await client.post(address: "/syndicate", object: syndicate);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Syndicate entity = Syndicate.fromMap(body);
      register['user_id'] = entity.id;
      authenticationRepository.postRegister(register);
      return entity;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("E-mail já cadastrado!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
