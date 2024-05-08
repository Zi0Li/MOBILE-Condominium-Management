class Reservation {
  int? id;
  String? date;
  String? description;

  Reservation({
    required this.id,
    required this.date,
    required this.description,
  });

  factory Reservation.fromMap(Map map) {
    return Reservation(
      id: map['id'],
      date: map['date'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'date': date,
      'description': description,
    };
    return map;
  }

  @override
  String toString() {
    return "RESERVATION(id: $id | date: $date | description: $description)";
  }
}
