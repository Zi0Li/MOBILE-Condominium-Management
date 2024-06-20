import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Condominium_Repository.dart';

class CondominiumStore {
  final ICondominiumRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Condominium>> state =
      ValueNotifier<List<Condominium>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  CondominiumStore({required this.repository});

  Future getCondominiumByCode(int code) async {
    isLoading.value = true;
    try {
      final result = await repository.getCondominiumByCode(code);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postCondomium(Map<String, dynamic> condominio) async {
    isLoading.value = true;
    try {
      final result = await repository.postCondomium(condominio);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future putCondomium(Map<String, dynamic> condominio) async {
    isLoading.value = true;
    try {
      final result = await repository.putCondomium(condominio);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future deleteCondomium(int id) async {
    isLoading.value = true;
    try {
      await repository.deleteCondominium(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
