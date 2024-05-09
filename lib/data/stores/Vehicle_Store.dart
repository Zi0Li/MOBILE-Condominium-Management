import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/data/repositories/Vehicle_Repository.dart';

class VehicleStore {
  final IVehicleRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Vehicle>> state = ValueNotifier<List<Vehicle>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  VehicleStore({required this.repository});

  Future getVehicleByResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getVehicleByResident(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postVehicle(Map<String, dynamic> vehicle) async {
    isLoading.value = true;
    try {
      final result = await repository.postVehicle(vehicle);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }
}
