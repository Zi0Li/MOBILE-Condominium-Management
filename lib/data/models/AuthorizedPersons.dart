import 'package:tcc/widgets/config.dart';

class AuthorizedPersons {
  int? id;
  String? name;
  String? rg;
  String? cpf;
  String? kinship;
  String? phone;

  AuthorizedPersons({
    required this.id,
    required this.name,
    required this.rg,
    required this.cpf,
    required this.kinship,
    required this.phone,
  });

  factory AuthorizedPersons.fromMap(Map map) {
    return AuthorizedPersons(
      id: map['id'],
      name: Config.textToUtf8(map['name']),
      rg: map['rg'],
      cpf: map['cpf'],
      kinship: Config.textToUtf8(map['kinship']),
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'kinship': kinship,
      'phone': phone,
    };
    return map;
  }

  @override
  String toString() {
    return "AUTHORIZED_PERSONS(id: $id | name: $name | rg: $rg | cpf: $cpf | kinship: $kinship | phone: $phone)";
  }
}
