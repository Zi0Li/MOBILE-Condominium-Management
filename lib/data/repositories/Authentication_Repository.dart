import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/models/User.dart';
import 'package:tcc/widgets/config.dart';

abstract class IAuthenticationRepository {
  Future<User> getLogin(String login, String password);
}

class AuthenticationRepository implements IAuthenticationRepository {
  final IHttpClient client;

  AuthenticationRepository({required this.client});

  @override
  Future<User> getLogin(String login, String password) async {
    Map<String, dynamic> object = {"login": login, "password": password};

    final response = await client.post(address: "/auth/login", object: object);
    print('Depois da requisição');
    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      token = body['token'];
      Object? entity;
      if (body['role'] == Config.sindico) {
        entity = Syndicate.fromMap(body['entity']);
      } else if (body['role'] == Config.morador) {
        entity = Resident.fromMap(body['entity']);
      } else if (body['role'] == Config.funcionario) {
        entity = Employee.fromMap(body['entity']);
      }

      return User(role: body['role'], entity: entity);

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
