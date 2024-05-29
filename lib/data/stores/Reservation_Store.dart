import 'package:flutter/material.dart';
import 'package:tcc/data/dtos/ReservationAndKioskDTO.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Reservation.dart';
import 'package:tcc/data/repositories/Reservation_Repository.dart';

class ReservationStore {
  final IReservationRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Reservation>> state =
      ValueNotifier<List<Reservation>>([]);
  final ValueNotifier<List<ReservationAndKioskDTO>> stateDTO =
      ValueNotifier<List<ReservationAndKioskDTO>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  ReservationStore({required this.repository});

  Future getReservationByResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getReservationByResident(id);
      stateDTO.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return stateDTO.value;
  }

  Future postReservation(Map<String, dynamic> reservation) async {
    isLoading.value = true;
    try {
      final result = await repository.postReservation(reservation);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future deleteReservation(int id) async {
    isLoading.value = true;
    try {
      await repository.deleteReservation(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
