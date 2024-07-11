import 'package:flutter/material.dart';
import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/repositories/Report_Repository.dart';

class ReportStore {
  final IReportRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Report>> state = ValueNotifier<List<Report>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>("");

  ReportStore({required this.repository});

  Future getReportByCondominium(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getReportByCondominium(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future getReportByResident(int id) async {
    isLoading.value = true;
    try {
      final result = await repository.getReportByResident(id);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future update(Map<String, dynamic> report) async {
    isLoading.value = true;
    try {
      final result = await repository.update(report);
      state.value.add(result);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value;
  }

  Future create(Map<String, dynamic> report) async {
    isLoading.value = true;
    try {
      final result = await repository.create(report);
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
    try {
      await repository.delete(id);
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
