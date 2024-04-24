class Condominium {
  int? id;
  int? code;
  String? cnpj;
  String? name;
  int? cep;
  String? street;
  String? district;
  int? number_address;
  String? uf;
  List<dynamic>? block;
  List<dynamic>? number_apt;
  String? city;
  String? reference;

  Condominium({
    required this.id,
    required this.code,
    required this.cnpj,
    required this.name,
    required this.cep,
    required this.street,
    required this.district,
    required this.number_address,
    required this.uf,
    required this.block,
    required this.number_apt,
    required this.city,
    required this.reference,
  });

  factory Condominium.fromMap(Map map) {
    // print("${map['id']} | ${map['id'].runtimeType}");
    // print("${map['code']} | ${map['code'].runtimeType}");
    // print("${map['cnpj']} | ${map['cnpj'].runtimeType}");
    // print("${map['name']} | ${map['name'].runtimeType}");
    // print("${map['cep']} | ${map['cep'].runtimeType}");
    // print("${map['street']} | ${map['street'].runtimeType}");
    // print("${map['district']} | ${map['district'].runtimeType}");
    // print("${map['number_address']} | ${map['number_address'].runtimeType}");
    // print("${map['uf']} | ${map['uf'].runtimeType}");
    // print("${map['block']} | ${map['block'].runtimeType}");
    // print("${map['number_apt']} | ${map['number_apt'].runtimeType}");
    // print("${map['city']} | ${map['city'].runtimeType}");
    // print("${map['reference']} | ${map['reference'].runtimeType}");

    return Condominium(
      id: map['id'],
      code: map['code'],
      cnpj: map['cnpj'],
      name: map['name'],
      cep: map['cep'],
      street: map['street'],
      district: map['district'],
      number_address: map['number_address'],
      uf: map['uf'],
      block: map['block'],
      number_apt: map['number_apt'],
      city: map['city'],
      reference: map['reference'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'code': code,
      'cnpj': cnpj,
      'name': name,
      'cep': cep,
      'street': street,
      'district': district,
      'number_address': number_address,
      'uf': uf,
      'block': block,
      'number_apt': number_apt,
      'city': city,
      'reference': reference,
    };
    return map;
  }
}
