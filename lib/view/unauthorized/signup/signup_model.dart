import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel {
  String id;
  String name;
  String surname;
  String phone;
  Timestamp birthday;
  String mail;
  String password;
  File image;
  Timestamp signUpDateTime;
  String authorization;
  String position;
  bool online;
  Timestamp onlineTime;

  SignUpModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.birthday,
    required this.mail,
    required this.password,
    required this.image,
    required this.signUpDateTime,
    required this.onlineTime,
    this.authorization = 'user',
    this.position = 'member',
    this.online = false,
  });
}
