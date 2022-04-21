import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  String createdBy;
  Timestamp createdAt;
  String updatedBy;
  Timestamp updatedAt;
  bool isUpdated;
  String title;
  String description;
  String location;
  Timestamp startsAt;
  Timestamp endsAt;
  List<dynamic> participants;

  MeetingModel({
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.isUpdated,
    required this.title,
    required this.description,
    required this.location,
    required this.startsAt,
    required this.endsAt,
    required this.participants,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedBy': updatedBy,
      'updatedAt': updatedAt,
      'isUpdated': isUpdated,
      'title': title,
      'description': description,
      'location': location,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'participants': participants,
    };
  }

  MeetingModel.fromJson(Map<String, Object?> json)
      : this(
          createdBy: json['createdBy']! as String,
          createdAt: json['createdAt']! as Timestamp,
          updatedBy: json['updatedBy']! as String,
          updatedAt: json['updatedAt']! as Timestamp,
          isUpdated: json['isUpdated']! as bool,
          title: json['title']! as String,
          description: json['description']! as String,
          location: json['location']! as String,
          startsAt: json['startsAt']! as Timestamp,
          endsAt: json['endsAt']! as Timestamp,
          participants: json['participants']! as List<dynamic>,
        );
}
