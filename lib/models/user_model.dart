import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String user;
  final String password;
  final String api;
  UserModel({
    required this.id,
    required this.name,
    required this.user,
    required this.password,
    required this.api,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'user': user,
      'password': password,
      'api': api,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      user: (map['user'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      api: (map['api'] ?? '0') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
