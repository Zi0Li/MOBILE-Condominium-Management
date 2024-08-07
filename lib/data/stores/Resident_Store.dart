import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';

class ResidentStore {
  final IResidentRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Resident>> state = ValueNotifier<List<Resident>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  ResidentStore({required this.repository});

  Future getResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getResident(id);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postResident(dynamic resident, dynamic register) async {
    isLoading.value = true;
    try {
      final result = await repository.postResident(resident, register);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future putResident(Resident resident) async {
    isLoading.value = true;
    try {
      final result = await repository.putResident(resident);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future getAllNeighbors(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getAllNeighbors(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future getResidentsByCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getResidentsByCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

    Future getResidentSearch(String search) async {
    isLoading.value = true;
    Resident? result;
    try {
      result = await repository.getResidentSearch(search);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return result;
  }
}
