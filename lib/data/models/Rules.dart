import 'package:tcc/widgets/config.dart';

class Rules {
  int id;
  String title;
  List<String> content;
  bool isExpanded;

  Rules({
    required this.id,
    required this.title,
    required this.content,
    this.isExpanded = false,
  });

  factory Rules.fromMap(Map map) {
    List<String> contents = [];
    map['content'].map((item) {
      contents.add(Config.textToUtf8(item));
    }).toList();

    return Rules(
      id: map['id'],
      title: Config.textToUtf8(map['title']),
      content: contents,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title,
      'content': content,
    };
    return map;
  }

  @override
  String toString() {
    return "RULES(id: $id | title: $title | content: $content)";
  }
}

List<Rules> gerarRegras(int qty) {
  List<Rules> rules = [];

  for (var i = 0; i < qty; i++) {
    rules.add(
      Rules(id: i + 1, title: 'Regra de numero: ${i + 1}', content: [
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu commodo quam, vitae vestibulum mauris. Nulla rutrum eu diam et accumsan.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu commodo quam, vitae vestibulum mauris. Nulla rutrum eu diam et accumsan.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu commodo quam, vitae vestibulum mauris. Nulla rutrum eu diam et accumsan.',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu commodo quam, vitae vestibulum mauris. Nulla rutrum eu diam et accumsan.',
      ]),
    );
  }
  return rules;
}
