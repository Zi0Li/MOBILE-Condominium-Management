import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Syndicate.dart';
import 'package:tcc/data/repositories/Syndicate_Repository.dart';

class SyndicateStore {
  final ISyndicateRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Syndicate>> state =
      ValueNotifier<List<Syndicate>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  SyndicateStore({required this.repository});

  Future getSyndicateById(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getSyndicateById(id);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postSyndicateById(dynamic syndicate, dynamic register) async {
    isLoading.value = true;
    try {
      final result = await repository.postSyndicate(syndicate, register);
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
