import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String projectID;
  String title;
  String explanation;
  String status;
  List<dynamic> groupIDs;
  List<dynamic> team;
  String createdBy;
  Timestamp createdAt;
  Timestamp deadline;
  
  ProjectModel({
    required this.projectID,
    required this.title,
    required this.explanation,
    required this.groupIDs,
    required this.status,
    required this.team,
    required this.createdBy,
    required this.createdAt,
    required this.deadline,
  });

  Map<String, dynamic> toMap() {
    return {
      'projectID': projectID,
      'title': title,
      'explanation': explanation,
      'groupIDs': groupIDs,
      'status': status,
      'team': team,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'deadline': deadline,
    };
  }
  

  ProjectModel.fromJson(Map<String, Object?> json)
      : this(
          projectID: json['projectID']! as String,
          title: json['title']! as String,
          explanation: json['explanation']! as String,
          groupIDs: json['groupIDs']! as List<dynamic>,
          status: json['status']! as String,
          team: json['team']! as List<dynamic>,
          createdBy: json['createdBy']! as String,
          createdAt: json['createdAt']! as Timestamp,
          deadline: json['deadline']! as Timestamp,
        );
}
