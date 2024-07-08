import 'dart:convert';

import 'package:tcc/data/http/exceptions.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Report.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/config.dart';

abstract class IReportRepository {
  Future<List<Report>> getReportByCondominium(int id);
  Future<Report> update(Map<String, dynamic> report);
}

class ReportRepository implements IReportRepository {
  final IHttpClient client;

  ReportRepository({required this.client});

  @override
  Future<List<Report>> getReportByCondominium(int id) async {
    final response = await client.get(
      address: "/report/condominium=$id",
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<Report> reportList = [];
      body.map((item) {
        final Report report = Report.fromMap(item['report']);
        report.resident = (item['resident'] != null)
            ? Resident.fromMap(item['resident'])
            : null;
        reportList.add(report);
      }).toList();
      return reportList;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("Usuário ou senha inválido!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }

  @override
  Future<Report> update(Map<String, dynamic> report) async {
    final response = await client.post(
      address: "/report",
      object: report,
      withToken: true,
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Report.fromMap(body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não e valida!");
    } else if (response.statusCode == 405) {
      throw NotFoundException("Sem autorização");
    } else if (response.statusCode == 500) {
      throw NotFoundException("Usuário ou senha inválido!");
    } else {
      throw NotFoundException(Config.textToUtf8(body['message']));
    }
  }
}
