import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';
import 'package:tcc/widgets/config.dart';

abstract class IResidentRepository {
  Future<Resident> getResident(int id);
  Future<Resident> getResidentSearch(String search);
  Future<List<Resident>> getAllNeighbors(int id);
  Future<List<Resident>> getResidentsByCondominium(int id);
  Future<Resident> postResident(dynamic resident, dynamic register);
  Future<Resident> putResident(Resident resident);
}

class ResidentRepository implements IResidentRepository {
  final IHttpClient client;

  ResidentRepository({required this.client});

  @override
  Future<Resident> getResident(int id) async {
    final response =
        await client.get(address: "/resident/$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Resident resident = Resident.fromMap(body['resident']);
      resident.condominium = Condominium.fromMap(body['condominium']);
      return resident;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Resident> postResident(dynamic resident, dynamic register) async {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository(client: client);

    final response = await client.post(address: "/resident", object: resident);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Resident entity = Resident.fromMap(body);
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

  @override
  Future<Resident> putResident(Resident resident) async {
    final response =
        await client.put(address: "/resident", object: resident.toMap());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Resident.fromMap(body);
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

  @override
  Future<List<Resident>> getAllNeighbors(int id) async {
    final response = await client.get(
      address: "/resident/$id/neighbors",
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Resident> residents = [];
      body.map((item) {
        final Resident resident = Resident.fromMap(item);
        residents.add(resident);
      }).toList();
      for (var i = 0; i < residents.length; i++) {
        if (residents[i].id == Config.user.id) {
          residents.removeAt(i);
        }
      }
      return residents;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<List<Resident>> getResidentsByCondominium(int id) async {
    final response =
        await client.get(address: "/resident/condominium=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<Resident> residentsList = [];

      body.map((item) {
        List<Vehicle> vehicleList = [];
        List<AuthorizedPersons> authorizedPersonsList = [];

        item['authorizedPersonsList'].map((value) {
          final AuthorizedPersons authorizedPersons =
              AuthorizedPersons.fromMap(value);
          authorizedPersonsList.add(authorizedPersons);
        }).toList();

        item['vehicleList'].map((value) {
          final Vehicle vehicle = Vehicle.fromMap(value);
          vehicleList.add(vehicle);
        }).toList();

        final Resident resident = Resident.fromMap(item['resident']);
        resident.authorizedPersons = authorizedPersonsList;
        resident.vehicle = vehicleList;
        residentsList.add(resident);
      }).toList();
      return residentsList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Resident> getResidentSearch(String search) async {
    final response =
        await client.get(address: "/resident/search/$search", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Resident.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
