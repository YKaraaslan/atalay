import 'package:cloud_firestore/cloud_firestore.dart';

class ReferenceModel {
  String id;
  String companyID;
  String name;
  String surname;
  String fullName;
  Timestamp createdAt;
  String createdBy;
  String imageURL;
  String phone;
  String mail;
  String description;

  ReferenceModel({
    required this.id,
    required this.companyID,
    required this.name,
    required this.surname,
    required this.fullName,
    required this.createdAt,
    required this.createdBy,
    required this.imageURL,
    required this.phone,
    required this.mail,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyID': companyID,
      'name': name,
      'surname': surname,
      'fullName': fullName,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'imageURL': imageURL,
      'phone': phone,
      'mail': mail,
      'description': description,
    };
  }

  ReferenceModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          companyID: json['companyID']! as String,
          name: json['name']! as String,
          surname: json['surname']! as String,
          fullName: json['fullName']! as String,
          createdAt: json['createdAt']! as Timestamp,
          createdBy: json['createdBy']! as String,
          imageURL: json['imageURL']! as String,
          phone: json['phone']! as String,
          mail: json['mail']! as String,
          description: json['description']! as String,
        );
}
