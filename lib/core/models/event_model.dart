import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String title;
  String description;
  Timestamp dateStart;
  Timestamp dateEnd;
  Timestamp createdAt;

  EventModel({
    required this.title,
    required this.description,
    required this.dateStart,
    required this.dateEnd,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'createdAt': createdAt,
    };
  }
}
