import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String id;
  String companyName;
  String description;
  String createdBy;
  Timestamp createdAt;
  String imageURL;
  String location;
  String phone;
  String mail;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.imageURL,
    required this.location,
    required this.phone,
    required this.mail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': companyName,
      'description': description,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'imageURL': imageURL,
      'location': location,
      'phone': phone,
      'mail': mail,
    };
  }

  CompanyModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          companyName: json['companyName']! as String,
          description: json['description']! as String,
          createdBy: json['createdBy']! as String,
          createdAt: json['createdAt']! as Timestamp,
          imageURL: json['imageURL']! as String,
          location: json['location']! as String,
          phone: json['phone']! as String,
          mail: json['mail']! as String,
        );
}
