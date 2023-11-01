// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceModel {
  final String id;
  final String name_th;
  final String name_en;
  ProvinceModel({
    required this.id,
    required this.name_th,
    required this.name_en,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name_th': name_th,
      'name_en': name_en,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: (map['id'] ?? '') as String,
      name_th: (map['name_th'] ?? '') as String,
      name_en: (map['name_en'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) => ProvinceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
