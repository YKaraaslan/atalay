import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String text;
  String createdBy;
  Timestamp createdAt;

  AnnouncementModel({
    required this.text,
    required this.createdBy,
    required this.createdAt,
  });

  AnnouncementModel.fromJson(Map<String, Object?> json)
      : this(
          text: json['text']! as String,
          createdBy: json['createdBy']! as String,
          createdAt: json['createdAt']! as Timestamp,
        );

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
