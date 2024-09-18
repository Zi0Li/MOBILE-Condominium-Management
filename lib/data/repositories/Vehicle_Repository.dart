import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/widgets/config.dart';

abstract class IVehicleRepository {
  Future<List<Vehicle>> getVehicleByResident(int id);
  Future<Vehicle> postVehicle(Map<String, dynamic> vehicle);
  Future<Vehicle> putVehicle(Map<String, dynamic> vehicle);
  Future<dynamic> deleteVehicle(int id);
}

class VehicleRepository implements IVehicleRepository {
  final IHttpClient client;

  VehicleRepository({required this.client});

  @override
  Future<List<Vehicle>> getVehicleByResident(int id) async {
    final response =
        await client.get(address: "/vehicle/resident=$id", withToken: true);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<Vehicle> vehicleList = [];
      body.map((item) {
        final Vehicle vehicles = Vehicle.fromMap(item);
        vehicleList.add(vehicles);
      }).toList();
      return vehicleList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Vehicle> postVehicle(Map<String, dynamic> vehicle) async {
    final response = await client.post(
        address: "/vehicle", object: vehicle, withToken: true);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Vehicle.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<dynamic> deleteVehicle(int id) async {
    final response = await client.delete(address: "/vehicle/$id");

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Vehicle> putVehicle(Map<String, dynamic> vehicle) async {
    final response = await client.put(address: "/vehicle", object: vehicle);

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Vehicle.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
