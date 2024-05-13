import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/widgets/config.dart';

abstract class IAuthorizedPersonsRepository {
  Future<List<AuthorizedPersons>> getAuthorizedPersonsByResident(int id);
}

class AuthorizedPersonsRepository implements IAuthorizedPersonsRepository {
  final IHttpClient client;

  AuthorizedPersonsRepository({required this.client});

  @override
  Future<List<AuthorizedPersons>> getAuthorizedPersonsByResident(int id) async {

    final response = await client.get(address: "/authorizedPersons/resident=$id", withToken: true);
    // print('Depois da requisição');
    // print('STATUS CODE: ${response.statusCode}');
    // print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
    final List<AuthorizedPersons> authorizedPersonsList = [];
      body.map((item) {
        final AuthorizedPersons authorizedPerson = AuthorizedPersons.fromMap(item);
        authorizedPersonsList.add(authorizedPerson);
      }).toList();
      return authorizedPersonsList;
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
