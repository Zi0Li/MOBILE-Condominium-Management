import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';

class AuthenticationStore {
  final IAuthenticationRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Syndicate>> state =
      ValueNotifier<List<Syndicate>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  AuthenticationStore({required this.repository});

  Future getSyndicate() async {
    isLoading.value = true;
    try {
      final result = await repository.setLogin();
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