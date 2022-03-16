import 'package:cloud_firestore/cloud_firestore.dart';

class UsersOnHoldModel {
  String id;
  String name;
  String surname;
  String fullName;
  String phone;
  Timestamp birthday;
  String mail;
  String password;
  String imageURL;
  Timestamp signUpTime;
  String token;

  UsersOnHoldModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.fullName,
    required this.phone,
    required this.birthday,
    required this.mail,
    required this.password,
    required this.imageURL,
    required this.signUpTime,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'fullName': fullName,
      'phone': phone,
      'birthday': birthday,
      'mail': mail,
      'password': password,
      'imageURL': imageURL,
      'signUpTime': signUpTime,
      'token': token,
    };
  }

  UsersOnHoldModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          surname: json['surname']! as String,
          fullName: json['fullName']! as String,
          phone: json['phone']! as String,
          birthday: json['birthday']! as Timestamp,
          mail: json['mail']! as String,
          password: json['password']! as String,
          imageURL: json['imageURL']! as String,
          signUpTime: json['signUpTime']! as Timestamp,
          token: json['token']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'fullName': fullName,
      'phone': phone,
      'birthday': birthday,
      'mail': mail,
      'password': password,
      'imageURL': imageURL,
      'signUpTime': signUpTime,
      'token': token,
    };
  }
}
