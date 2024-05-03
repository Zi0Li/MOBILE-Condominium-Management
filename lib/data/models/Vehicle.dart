class Vehicle {
  int? id;
  String? plate; //placa
  String? type; //Carro/Moto e etc
  String? brand; //Marca
  String? color;
  String? model;
  String? year;

  Vehicle({
    required this.id,
    required this.plate,
    required this.type,
    required this.brand,
    required this.color,
    required this.model,
    required this.year,
  });

  factory Vehicle.fromMap(Map map) {
    return Vehicle(
        id: map['id'],
        plate: map['plate'],
        type: map['type'],
        brand: map['brand'],
        color: map['color'],
        model: map['model'],
        year: map['year']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'plate': plate,
      'type': type,
      'brand': brand,
      'color': color,
      'model': model,
      'year': year,
    };
    return map;
  }

  @override
  String toString() {
   return "VEHICLE(id: $id | plate: $plate | type: $type | brand: $brand | color: $color | model: $model | year: $year)";
  }
}
