import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/widgets/config.dart';

abstract class IEmployeeRepository {
  Future<List<Employee>> getEmployeeByCondominium(int code);
  Future<dynamic> deleteEmployee(int id);
  Future<Employee> postEmployee(
      Map<String, dynamic> employee, Map<String, dynamic> register);
  Future<Employee> putEmployee(Map<String, dynamic> employee);
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
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Employee> postEmployee(
      Map<String, dynamic> employee, Map<String, dynamic> register) async {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository(client: client);
    final response = await client.post(
      address: "/employee",
      withToken: true,
      object: employee,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Employee entity = Employee.fromMap(body);
      register['user_id'] = entity.id;
      authenticationRepository.postRegister(register);
      return entity;
    } else if (response.statusCode == 404) {
      throw NotFoundException("Código do condomínio inválido!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("E-mail já cadastrado!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Employee> putEmployee(Map<String, dynamic> employee) async {
    final response = await client.put(
      address: "/employee",
      object: employee,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Employee.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("Código do condomínio inválido!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("E-mail já cadastrado!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<dynamic> deleteEmployee(int id) async {
    final response = await client.delete(
      address: "/employee/$id",
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 404) {
      throw NotFoundException("Código do condomínio inválido!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
