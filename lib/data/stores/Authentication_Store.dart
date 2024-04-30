import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/User.dart';
import 'package:tcc/data/repositories/Authentication_Repository.dart';

class AuthenticationStore {
  final IAuthenticationRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<User>> state =
      ValueNotifier<List<User>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  AuthenticationStore({required this.repository});

  Future getLogin(String login, String password) async {
    isLoading.value = true;
    try {
      final result = await repository.getLogin(login, password);
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
