class Syndicate {
  int? id;
  String? name;
  String? rg;
  String? cpf;
  String? phone;

  Syndicate({
    required this.id,
    required this.name,
    required this.rg,
    required this.cpf,
    required this.phone,
  });

  factory Syndicate.fromMap(Map map) {
    return Syndicate(
      id: map['id'],
      name: map['name'],
      rg: map['rg'],
      cpf: map['cpf'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'phone': phone,
    };
    return map;
  }

  @override
  String toString() {
    return "SYNDICATE(id: $id | name: $name | rg: $rg | cpf: $cpf | phone: $phone)";
  }
}
