import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';

class KioskStore {
  final IKioskRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Kiosk>> state =
      ValueNotifier<List<Kiosk>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  KioskStore({required this.repository});

  Future getAllKioskByResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getAllKioskByResident(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future getAllDetails(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getAllDetails(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }
}
