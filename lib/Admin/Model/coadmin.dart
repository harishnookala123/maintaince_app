import 'package:flutter/cupertino.dart';

class CoAdmin {
  final String first_name;
  final String last_name;
  final String email;
  final String apartment_code;
  final String phone;
  final String user_type;

  CoAdmin({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.apartment_code,
    required this.phone,
    required this.user_type,
  });

  factory CoAdmin.fromJson(Map<String, dynamic> json) {
    return CoAdmin(
      first_name: json['first_name'],
      last_name: json['last_name'],
        email:json['email'],
      apartment_code:json['apartment_code'],
      phone: json['phone'],
      user_type: json['user_type'],
    );
  }
}
