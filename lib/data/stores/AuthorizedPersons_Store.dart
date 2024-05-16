import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';

class AuthorizedPersonsStore {
  final IAuthorizedPersonsRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<AuthorizedPersons>> state =
      ValueNotifier<List<AuthorizedPersons>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  AuthorizedPersonsStore({required this.repository});

  Future getAuthorizedPersonsByResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getAuthorizedPersonsByResident(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postAuthorizedPersons(Map<String, dynamic> authorizedPersons) async {
    isLoading.value = true;
    try {
      final result = await repository.postAuthorizedPersons(authorizedPersons);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future deleteAuthorizedPersons(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.deleteAuthorizedPersons(id);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future putAuthorizedPersons(Map<String, dynamic> authorizedPersons) async {
    isLoading.value = true;
    try {
      final result = await repository.putAuthorizedPersons(authorizedPersons);
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
