import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GuestModel {
  final String id;
  final String nameAndSur;
  final String phone;
  final String carId;
  final String province;
  final String objective;
  final String urlImage1;
  final String urlImage2;
  final String urlImage3;
  final String checkIn;
  final String checkOut;


  GuestModel({
    required this.id,
    required this.nameAndSur,
    required this.phone,
    required this.carId,
    required this.province,
    required this.objective,
    required this.urlImage1,
    required this.urlImage2,
    required this.urlImage3,
    required this.checkIn,
    required this.checkOut,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameAndSur': nameAndSur,
      'phone': phone,
      'carId': carId,
      'province': province,
      'objective': objective,
      'urlImage1': urlImage1,
      'urlImage2': urlImage2,
      'urlImage3': urlImage3,
      'checkIn': checkIn,
      'checkOut': checkOut,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      id: (map['id'] ?? '') as String,
      nameAndSur: (map['nameAndSur'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      carId: (map['carId'] ?? '') as String,
      province: (map['province'] ?? '') as String,
      objective: (map['objective'] ?? '') as String,
      urlImage1: (map['urlImage1'] ?? '') as String,
      urlImage2: (map['urlImage2'] ?? '') as String,
      urlImage3: (map['urlImage3'] ?? '') as String,
      checkIn: (map['checkIn'] ?? '') as String,
      checkOut: (map['checkOut'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestModel.fromJson(String source) => GuestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
