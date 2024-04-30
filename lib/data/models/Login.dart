class Login {
  int? id;
  String? email;
  String? password;
  int? remember; 

  Login({
    required this.id,
    required this.email,
    required this.password,
    required this.remember,
  });

  factory Login.fromMap(Map map) {
    return Login(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      remember: map['remember'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'email': email,
      'password': password,
      'remember': remember,
    };
    return map;
  }

  @override
  String toString() {
    return "LOGIN(id: $id | email: $email | password: $password | remember: $remember)";
  }
}
