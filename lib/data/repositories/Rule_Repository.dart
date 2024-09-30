import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Rules.dart';

abstract class IRuleRepository {
  Future<List<Rules>> findByIdCondominium(int id);
  Future<void> delete(int id);
  Future<Rules> create(Map<String, dynamic> rule);
  Future<Rules> update(Map<String, dynamic> rule);
}

class RuleRepository implements IRuleRepository {
  final IHttpClient client;

  RuleRepository({required this.client});

  @override
  Future<List<Rules>> findByIdCondominium(int id) async {
    final response =
        await client.get(address: "/rule/condominium=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Rules> rulesList = [];
      body.map((item) {
        rulesList.add(Rules.fromMap(item));
      }).toList();

      return rulesList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }

  @override
  Future<Rules> create(Map<String, dynamic> rule) async {
    final response = await client.post(
      address: "/rule",
      object: rule,
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Rules.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }

  @override
  Future<Rules> update(Map<String, dynamic> rule) async {
    final response = await client.put(
      address: "/rule",
      object: rule,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Rules.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }

  @override
  Future<void> delete(int id) async {
    final response = await client.delete(
      address: "/rule/$id",
    );
    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }
}
