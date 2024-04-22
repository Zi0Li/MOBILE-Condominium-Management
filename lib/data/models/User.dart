class User {
  int? id;
  int? user_id;
  String? login;
  String? password;
  String? role;

  User({
    required this.id,
    required this.user_id,
    required this.login,
    required this.password,
    required this.role,
  });

  factory User.fromMap(Map map) {
    return User(
      id: map['id'],
      user_id: map['user_id'],
      login: map['login'],
      password: map['password'],
      role: map['role'],
    );
  }

   Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'user_id': user_id,
      'login': login,
      'password': password,
      'role': role,
    };
    return map;
  }


  @override
  String toString() {
    return "USER(id: $id | user_id: $user_id | login: $login | password: $password | role: $role)";
  }
}
