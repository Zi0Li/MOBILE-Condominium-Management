import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/widgets/config.dart';

class Syndicate {
  int? id;
  String? name;
  String? rg;
  String? cpf;
  String? phone;
  String? email;
  List<Condominium>? condominiums;

  Syndicate(
      {required this.id,
      required this.name,
      required this.rg,
      required this.cpf,
      required this.phone,
      required this.email,
      required this.condominiums});

  factory Syndicate.fromMap(Map map) {
    // print("${map['id']} | ${map['id'].runtimeType}");
    // print("${map['rg']} | ${map['rg'].runtimeType}");
    // print("${map['cpf']} | ${map['cpf'].runtimeType}");
    // print("${map['name']} | ${map['name'].runtimeType}");
    // print("${map['phone']} | ${map['phone'].runtimeType}");
    // print("${map['condominiums']} | ${map['condominiums'].runtimeType}");
    
    final List<Condominium> condominiumList = [];
    map['condominiums'].map((item) {
      final Condominium condominium = Condominium.fromMap(item);
      condominiumList.add(condominium);
    }).toList();

    return Syndicate(
      id: map['id'],
      name: Config.textToUtf8(map['name']),
      rg: map['rg'],
      cpf: map['cpf'],
      phone: map['phone'],
      email: map['email'],
      condominiums: condominiumList,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'phone': phone,
      'email': email,
      'condominiums': condominiums,
    };
    return map;
  }

  @override
  String toString() {
    return "SYNDICATE(id: $id | name: $name | rg: $rg | cpf: $cpf | phone: $phone | email: $email | condominiums: $condominiums)";
  }
}
