import 'package:tcc/widgets/config.dart';

class Kiosk {
  int? id;
  String? type;
  String? description;

  Kiosk({
    required this.id,
    required this.type,
    required this.description,
  });

  factory Kiosk.fromMap(Map map) {
    return Kiosk(
      id: map['id'],
      type: Config.textToUtf8(map['type']),
      description: Config.textToUtf8(map['description']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'type': type,
      'description': description,
    };
    return map;
  }

  @override
  String toString() {
    return "KIOSK(id: $id | type: $type | description: $description)";
  }
}
