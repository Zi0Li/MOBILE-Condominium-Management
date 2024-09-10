class Correspondence {
  int? id;
  String? sender;
  String? date;
  String? hours;

  Correspondence({
    required this.id,
    required this.sender,
    required this.date,
    required this.hours,
  });

  factory Correspondence.fromMap(Map map) {
    return Correspondence(
      id: map['id'],
      sender: map['sender'],
      date: map['date'],
      hours: map['hours'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'sender': sender,
      'date': date,
      'hours': hours,
    };

    return map;
  }

  @override
  String toString() {
    return "CORRESPONDENCE(id: $id | sender: $sender | date: $date | hours: $hours)";
  }
}
