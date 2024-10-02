import 'package:tcc/data/models/Condominium.dart';

class Employee {
  int? id;
  String? name;
  String? cpf;
  String? rg;
  String? phone;
  String? position;
  String? workload;
  String? email;
  List<Condominium>? condominiums = [];
  String? role;

  Employee({
    required this.id,
    required this.name,
    required this.cpf,
    required this.rg,
    required this.phone,
    required this.position,
    required this.workload,
    required this.email,
  });

  factory Employee.fromMap(Map map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      cpf: map['cpf'],
      rg: map['rg'],
      phone: map['phone'],
      position: map['position'],
      workload: map['workload'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'cpf': cpf,
      'rg': rg,
      'phone': phone,
      'position': position,
      'workload': workload,
      'email': email,
    };
    return map;
  }

  @override
  String toString() {
    return "EMPLOYEE(id: $id | name: $name | cpf: $cpf | rg: $rg | phone: $phone | position: $position | workload: $workload | email: $email | condominium: $condominiums)";
  }
}
