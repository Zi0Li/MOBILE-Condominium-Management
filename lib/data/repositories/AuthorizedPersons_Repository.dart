import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/config.dart';

abstract class IAuthorizedPersonsRepository {
  Future<List<AuthorizedPersons>> getAuthorizedPersonsByResident(int id);
  Future<Resident> getAuthorizedPersonsSearch(String search);
  Future<dynamic> deleteAuthorizedPersons(int id);
  Future<AuthorizedPersons> postAuthorizedPersons(
      Map<String, dynamic> authorizedPersons);
  Future<AuthorizedPersons> putAuthorizedPersons(
      Map<String, dynamic> authorizedPersons);
}

class AuthorizedPersonsRepository implements IAuthorizedPersonsRepository {
  final IHttpClient client;

  AuthorizedPersonsRepository({required this.client});

  @override
  Future<List<AuthorizedPersons>> getAuthorizedPersonsByResident(int id) async {
    final response = await client.get(
        address: "/authorizedPersons/resident=$id", withToken: true);
    // print('Depois da requisição');
    // print('STATUS CODE: ${response.statusCode}');
    // print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<AuthorizedPersons> authorizedPersonsList = [];
      body.map((item) {
        final AuthorizedPersons authorizedPerson =
            AuthorizedPersons.fromMap(item);
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

  @override
  Future<dynamic> deleteAuthorizedPersons(int id) async {
    final response = await client.delete(address: "/authorizedPersons/$id");
    // print('Depois da requisição');
    // print('STATUS CODE: ${response.statusCode}');
    // print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
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
  Future<AuthorizedPersons> postAuthorizedPersons(
      Map<String, dynamic> authorizedPersons) async {
    final response = await client.post(
      address: "/authorizedPersons",
      object: authorizedPersons,
      withToken: true,
    );
    // print('Depois da requisição');
    // print('STATUS CODE: ${response.statusCode}');
    // print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AuthorizedPersons.fromMap(body);
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
  Future<AuthorizedPersons> putAuthorizedPersons(
      Map<String, dynamic> authorizedPersons) async {
    final response = await client.put(
        address: "/authorizedPersons", object: authorizedPersons);
    print('Depois da requisição');
    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AuthorizedPersons.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Resident> getAuthorizedPersonsSearch(String search) async {
    final response = await client.get(
        address: "/authorizedPersons/search/$search", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Resident resident = Resident.fromMap(body['resident']);
      resident.authorizedPersons!.add(AuthorizedPersons.fromMap(body['authorizedPersonsList'].first));
      return resident;
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
