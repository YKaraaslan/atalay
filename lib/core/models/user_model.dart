import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String surname;
  String phone;
  Timestamp birthday;
  String mail;
  String password;
  String imageURL;
  Timestamp signUpTime;
  Timestamp signUpAcceptedTime;
  String signUpAcceptedBy;
  String authorization;
  String position;
  bool online;
  Timestamp onlineTime;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.birthday,
    required this.mail,
    required this.password,
    required this.imageURL,
    required this.signUpTime,
    required this.signUpAcceptedTime,
    required this.signUpAcceptedBy,
    required this.authorization,
    required this.position,
    required this.online,
    required this.onlineTime,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'phone': phone,
      'birthday': birthday,
      'mail': mail,
      'password': password,
      'imageURL': imageURL,
      'signUpTime': signUpTime,
      'signUpAcceptedTime': signUpAcceptedTime,
      'signUpAcceptedBy': signUpAcceptedBy,
      'authorization': authorization,
      'position': position,
      'online': online,
      'onlineTime': onlineTime,
    };
  }
}
