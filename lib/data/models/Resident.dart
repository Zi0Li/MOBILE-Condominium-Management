class Resident {
  int? id;
  String? name;
  String? rg;
  String? cpf;
  int? age;
  String? phone;
  String? email;

  Resident({
    required this.id,
    required this.name,
    required this.rg,
    required this.cpf,
    required this.age,
    required this.phone,
    required this.email,
  });

  factory Resident.fromMap(Map map) {
    return Resident(
      id: map['id'],
      name: map['name'],
      rg: map['rg'],
      cpf: map['cpf'],
      age: map['age'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'age': age,
      'phone': phone,
      'email': email,
    };
    return map;
  }
  
  @override
  String toString() {
    return "RESIDENT(id: $id | name: $name | rg: $rg | cpf: $cpf | age: $age | phone: $phone | email: $email)";
  }
}
