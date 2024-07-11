import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/config.dart';

class Report {
  int? id;
  String? date; //data realizada o report
  String? type; //anonimo ou não
  String? title; //titulo do reporte
  String? status; //resolvido ou em andamento
  String? description; //descrição do reporte
  Resident? resident; //pessoa que fez o report
  bool? view; //se foi visualizado ou não

  Report({
    required this.id,
    required this.date,
    required this.type,
    required this.title,
    required this.status,
    required this.description,
    required this.resident,
    required this.view,
  });

  factory Report.fromMap(Map map) {
    return Report(
      id: map['id'],
      date: map['date'],
      type: Config.textToUtf8(map['type']),
      title: Config.textToUtf8(map['title']),
      status: Config.textToUtf8(map['status']),
      description: Config.textToUtf8(map['description']),
      resident: null,
      view: map['view'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'date': date,
      'type': type,
      'title': title,
      'status': status,
      'description': description,
      'resident': resident,
      'view': view,
    };
    return map;
  }

  @override
  String toString() {
    return "REPORT(id: $id | date: $date | type: $type | title: $title | status: $status | description: $description | view: $view | resident: $resident)";
  }
}
