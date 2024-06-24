import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/models/Vehicle.dart';
import 'package:tcc/widgets/config.dart';

class Resident {
  int? id;
  String? name;
  String? rg;
  String? cpf;
  String? block;
  String? apt;
  String? phone;
  String? email;
  List<AuthorizedPersons>? authorizedPersons;
  List<Vehicle>? vehicle;

  Resident({
    required this.id,
    required this.name,
    required this.rg,
    required this.cpf,
    required this.block,
    required this.apt,
    required this.phone,
    required this.email,
    required this.authorizedPersons,
    this.vehicle,
  });

  factory Resident.fromMap(Map map) {
    List<AuthorizedPersons>? authorizedPersonsList = [];
    if (map['authorizedPersons'] != null) {
      map['authorizedPersons'].map((item) {
        final AuthorizedPersons authorizedPersons = AuthorizedPersons.fromMap(item);
        authorizedPersonsList.add(authorizedPersons);
      }).toList();
    }
    return Resident(
      id: map['id'],
      name: Config.textToUtf8(map['name']),
      rg: map['rg'],
      cpf: map['cpf'],
      block: map['block'],
      apt: map['apt'],
      phone: map['phone'],
      email: map['email'],
      authorizedPersons: authorizedPersonsList,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'block': block,
      'apt': apt,
      'phone': phone,
      'email': email,
    };
    return map;
  }

  @override
  String toString() {
    return "RESIDENT(id: $id | name: $name | rg: $rg | cpf: $cpf | block: $block | apt: $apt | phone: $phone | email: $email | authorizedPersons: $authorizedPersons | vehicle: $vehicle)";
  }
}
