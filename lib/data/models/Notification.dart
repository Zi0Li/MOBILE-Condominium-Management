import 'package:tcc/widgets/config.dart';

class NotificationMessage {
  int? id;
  String? description;
  String? category;
  String? type;

  NotificationMessage({
    required this.id,
    required this.description,
    required this.category,
    required this.type,
  });

  factory NotificationMessage.fromMap(Map map) {
    return NotificationMessage(
      id: map['id'],
      description: Config.textToUtf8(map['description']),
      category: Config.textToUtf8(map['category']),
      type: Config.textToUtf8(map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'description': description,
      'category': category,
      'type': type,
    };
    return map;
  }

  @override
  String toString() {
    return "NOTIFICATION(id: $id | description: $description | category: $category | type: $type)";
  }
}
