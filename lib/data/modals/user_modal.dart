import 'package:flutter/material.dart';
class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String?address;

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    address =json['address'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'address':address
    };
  }
}