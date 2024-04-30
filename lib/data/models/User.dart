class User {
  String? role;
  Object? entity;

  User({
    required this.role,
    required this.entity,
  });

  factory User.fromMap(Map map) {
    return User(role: map['role'], entity: map['entity']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'role': role,
      'entity': entity,
    };
    return map;
  }

  @override
  String toString() {
    return "USER(role: $role | entity: $entity)";
  }
}
