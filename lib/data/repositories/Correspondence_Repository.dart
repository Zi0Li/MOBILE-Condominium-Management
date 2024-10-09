import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Correspondence.dart';
import 'package:tcc/data/models/Resident.dart';

abstract class ICorrespondenceRepository {
  Future<Correspondence> create(Map<String, dynamic> correspondence);
  Future<List<Correspondence>> findByIdCondominium(int id);
  Future<List<Correspondence>> findByIdResident(int id);
  Future<void> delete(int id);
}

class CorrespondenceRepository implements ICorrespondenceRepository {
  final IHttpClient client;

  CorrespondenceRepository({required this.client});

  @override
  Future<Correspondence> create(Map<String, dynamic> map) async {
    final response = await client.post(
      address: "/correspondence",
      object: map,
      withToken: true,
    );

    if (response.statusCode == 200) {
      return Correspondence.fromMap(map);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }

  @override
  Future<List<Correspondence>> findByIdCondominium(int id) async {
    final response = await client.get(
      address: '/correspondence/condominium=$id',
      withToken: true,
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Correspondence> correspondenceList = [];
      body.map((item) {
        final Correspondence correspondence =
            Correspondence.fromMap(item['correspondence']);
        correspondence.resident = Resident.fromMap(item['resident']);
        correspondenceList.add(correspondence);
      }).toList();

      return correspondenceList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException("Error");
    }
  }

  @override
  Future<List<Correspondence>> findByIdResident(int id) async {
    final response = await client.get(
      address: '/correspondence/resident=$id',
      withToken: true,
    );

    final body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      List<Correspondence> correspondenceList = [];
      body.map((item) {
        final Correspondence correspondence = Correspondence.fromMap(item);
        correspondenceList.add(correspondence);
      }).toList();

      return correspondenceList;
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
      address: "/correspondence/$id",
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
