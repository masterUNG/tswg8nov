import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ObjectiveModel {
  final String id;
  final String objective;
  ObjectiveModel({
    required this.id,
    required this.objective,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'objective': objective,
    };
  }

  factory ObjectiveModel.fromMap(Map<String, dynamic> map) {
    return ObjectiveModel(
      id: (map['id'] ?? '') as String,
      objective: (map['objective'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ObjectiveModel.fromJson(String source) => ObjectiveModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
