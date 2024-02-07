class Rules {
  Rules({
    required this.id,
    required this.title,
    required this.content,
    this.isExpanded = false,
  });

  int id;
  String title;
  List<String> content;
  bool isExpanded;
}

List<Rules> gerarRegras(int qty) {
  List<Rules> rules = [];

  for (var i = 0; i < qty; i++) {
    rules.add(
      Rules(id: i + 1, title: 'Regra de numero: ${i + 1}', content: [
        'Não fazer nada',
        'Não fazer nada',
        'Não fazer nada',
        'Não fazer nada',
      ]),
    );
  }
  return rules;
}
