import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
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
    required this.fullName,
    required this.phone,
    required this.birthday,
    required this.mail,
    required this.password,
    required this.imageURL,
    required this.signUpTime,
    required this.token,
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
      'fullName': fullName,
      'phone': phone,
      'birthday': birthday,
      'mail': mail,
      'password': password,
      'imageURL': imageURL,
      'signUpTime': signUpTime,
      'token': token,
      'signUpAcceptedTime': signUpAcceptedTime,
      'signUpAcceptedBy': signUpAcceptedBy,
      'authorization': authorization,
      'position': position,
      'online': online,
      'onlineTime': onlineTime,
    };
  }
  

  UserModel.fromJson(Map<String, Object?> json)
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
          signUpAcceptedTime: json['signUpAcceptedTime']! as Timestamp,
          signUpAcceptedBy: json['signUpAcceptedBy']! as String,
          authorization: json['authorization']! as String,
          position: json['position']! as String,
          online: json['online']! as bool,
          onlineTime: json['onlineTime']! as Timestamp,
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
      'signUpAcceptedTime': signUpAcceptedTime,
      'signUpAcceptedBy': signUpAcceptedBy,
      'authorization': authorization,
      'position': position,
      'online': online,
      'onlineTime': onlineTime,
    };
  }
}