import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/repositories/Employee_Respository.dart';

class EmployeeStore {
  final IEmployeeRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Employee>> state = ValueNotifier<List<Employee>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  EmployeeStore({required this.repository});

  Future getEmployeeByCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getEmployeeByCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future postEmployee(
    Map<String, dynamic> employee,
    Map<String, dynamic> register,
  ) async {
    isLoading.value = true;
    try {
      final result = await repository.postEmployee(employee, register);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future putEmployee(Map<String, dynamic> employee) async {
    isLoading.value = true;
    try {
      final result = await repository.putEmployee(employee);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future deleteEmployee(int id) async {
    isLoading.value = true;
    try {
      await repository.deleteEmployee(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return true;
  }
}
