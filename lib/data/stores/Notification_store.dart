import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Notification.dart';
import 'package:tcc/data/repositories/Notification_Repository.dart';

class NotificationStore {
  final INotificationRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<NotificationMessage>> state =
      ValueNotifier<List<NotificationMessage>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  NotificationStore({required this.repository});

  Future findAllByIdCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.findAllByIdCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future create(Map<String, dynamic> notification) async {
    isLoading.value = true;
    try {
      final result = await repository.create(notification);
      state.value.add(result);
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
