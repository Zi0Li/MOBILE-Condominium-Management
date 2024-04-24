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
      print("RESULT: $result");
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