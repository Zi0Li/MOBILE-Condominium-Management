import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Correspondence.dart';
import 'package:tcc/data/repositories/Correspondence_Repository.dart';

class CorrespondenceStore {
  final ICorrespondenceRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Correspondence>> state =
      ValueNotifier<List<Correspondence>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  CorrespondenceStore({required this.repository});

  Future create(Map<String, dynamic> map) async {
    isLoading.value = true;
    try {
      final result = await repository.create(map);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future findByIdCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.findByIdCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future findByIdResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.findByIdResident(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future delete(int id) async {
    isLoading.value = true;
    try {
      await repository.delete(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }
}
