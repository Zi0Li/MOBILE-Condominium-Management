import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/widgets/config.dart';

abstract class ICondominiumRepository {
  Future<Condominium> getCondominiumByCode(int code);
  Future<void> deleteCondominium(int id);
  Future<Condominium> postCondomium(Map<String, dynamic> condominium);
  Future<Condominium> putCondomium(Map<String, dynamic> condominium);
}

class CondominiumRepository implements ICondominiumRepository {
  final IHttpClient client;

  CondominiumRepository({required this.client});

  @override
  Future<Condominium> getCondominiumByCode(int code) async {
    final response = await client.get(address: "/condominium/code=$code");
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Condominium.fromMap(body);
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

  @override
  Future<Condominium> postCondomium(Map<String, dynamic> condominium) async {
    final response = await client.post(
      address: "/condominium",
      object: condominium,
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Condominium.fromMap(body);
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

  @override
  Future<Condominium> putCondomium(Map<String, dynamic> condominium) async {
    final response = await client.put(
      address: "/condominium",
      object: condominium,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Condominium.fromMap(body);
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

  @override
  Future<void> deleteCondominium(int id) async {
    final response = await client.delete(
      address: "/condominium/$id",
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
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
