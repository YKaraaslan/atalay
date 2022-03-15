import 'package:cloud_firestore/cloud_firestore.dart';

class UserOnHoldModel {
  String id;
  String name;
  String surname;
  String phone;
  Timestamp birthday;
  String mail;
  String password;
  String imageURL;
  Timestamp signUpTime;

  UserOnHoldModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.birthday,
    required this.mail,
    required this.password,
    required this.imageURL,
    required this.signUpTime,
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
    };
  }
}
