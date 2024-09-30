import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Rules.dart';
import 'package:tcc/data/repositories/Rule_Repository.dart';

class RuleStore {
  final IRuleRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Rules>> state = ValueNotifier<List<Rules>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  RuleStore({required this.repository});

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

  Future update(Map<String, dynamic> map) async {
    isLoading.value = true;
    try {
      await repository.update(map);
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
    var deleting = false;
    try {
      await repository.delete(id);
      deleting = true;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return deleting;
  }
}
