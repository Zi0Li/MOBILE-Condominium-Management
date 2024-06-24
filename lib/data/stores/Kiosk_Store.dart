import 'package:flutter/material.dart';
import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Kiosk.dart';
import 'package:tcc/data/repositories/Kiosk_repository.dart';

class KioskStore {
  final IKioskRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Kiosk>> state = ValueNotifier<List<Kiosk>>([]);
  final ValueNotifier<List<ReservationAndKioskDTO>> stateDTO =
      ValueNotifier<List<ReservationAndKioskDTO>>([]);
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
      stateDTO.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return stateDTO.value;
  }

  Future getAllKioskByCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getAllKioskByCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postKiosk(Map<String, dynamic> kiosk) async {
    isLoading.value = true;
    try {
      final result = await repository.postKiosk(kiosk);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future putKiosk(Map<String, dynamic> kiosk) async {
    isLoading.value = true;
    try {
      final result = await repository.putKiosk(kiosk);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future deleteKiosk(int id) async {
    isLoading.value = true;
    try {
      await repository.deleteKiosk(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }
}
