import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/widgets/config.dart';

abstract class IAuthenticationRepository {
  Future<dynamic> setLogin();
}

class AuthenticationRepository implements IAuthenticationRepository {
  final IHttpClient client;

  AuthenticationRepository({required this.client});

  @override
  Future<dynamic> setLogin() async {
    print('TESTE 2');

    Map<String, dynamic> object = {
      "login": "sindico@gmail.com",
      "password": "123123"
    };

    final response = await client.post(address: "/auth/login", object: object);
    print('Depois da requisição');
    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');
    if (response.statusCode == 200) {
      
      final body = jsonDecode(response.body);
      token = body['token'];
      
      if (body['role'] == Config.sindico) {
        return Syndicate.fromMap(body['entity']);
      } else if (body['role'] == Config.morador){
        return Resident.fromMap(body['entity']);
      }else if (body['role'] == Config.funcionario){
        return Employee.fromMap(body['entity']);
      }

    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw Exception("não foi possivel carregar os Funcionarios");
    }
  }
}
