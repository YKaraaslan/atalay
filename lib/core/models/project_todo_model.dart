import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectToDoModel {
  String toDoID;
  String text;
  String createdBy;
  Timestamp createdAt;
  String status;
  int urgency;
  int index;
  
  ProjectToDoModel({
    required this.toDoID,
    required this.text,
    required this.createdBy,
    required this.createdAt,
    required this.status,
    required this.urgency,
    required this.index,
  });

  Map<String, dynamic> toMap() {
    return {
      'toDoID': toDoID,
      'text': text,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'status': status,
      'urgency': urgency,
      'index': index,
    };
  }

  factory ProjectToDoModel.fromMap(Map<String, dynamic> map) {
    return ProjectToDoModel(
      toDoID: map['toDoID'] ?? '',
      text: map['text'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdAt: map['createdAt'] ?? '',
      status: map['status'] ?? '',
      urgency: map['urgency']?.toInt() ?? 0,
      index: map['index']?.toInt() ?? 0,
    );
  }
  

  ProjectToDoModel.fromJson(Map<String, Object?> json)
      : this(
          toDoID: json['toDoID']! as String,
          text: json['text']! as String,
          createdBy: json['createdBy']! as String,
          createdAt: json['createdAt']! as Timestamp,
          status: json['status']! as String,
          urgency: json['urgency']! as int,
          index: json['index']! as int,
        );
}
