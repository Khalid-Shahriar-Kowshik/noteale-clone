class UserModel {
  final String id;
  final String name;
  final String email;
  String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  void setPassword(String newPassword) => password = newPassword;

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
