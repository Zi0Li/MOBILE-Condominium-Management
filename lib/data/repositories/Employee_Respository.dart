import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/widgets/config.dart';

abstract class IEmployeeRepository {
  Future<List<Employee>> getEmployeeByCondominium(int code);
}

class EmployeeRepository implements IEmployeeRepository {
  final IHttpClient client;

  EmployeeRepository({required this.client});

  @override
  Future<List<Employee>> getEmployeeByCondominium(int code) async {
    final response = await client.get(
        address: "/employee/condominium=$code", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Employee> employees = [];
      body.map((item) {
        employees.add(Employee.fromMap(item));
      }).toList();
      return employees;
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
