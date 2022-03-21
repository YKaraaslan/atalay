import 'package:cloud_firestore/cloud_firestore.dart';

class GroupsModel {
  String groupID;
  String title;
  String explanation;
  String userInCharge;
  List<dynamic> people;
  String imageURL;
  Timestamp createdAt;
  String createdBy;

  GroupsModel({
    required this.groupID,
    required this.title,
    required this.explanation,
    required this.userInCharge,
    required this.people,
    required this.imageURL,
    required this.createdAt,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupID': groupID,
      'title': title,
      'explanation': explanation,
      'userInCharge': userInCharge,
      'people': people,
      'imageURL': imageURL,
      'createdAt': createdAt,
      'createdBy': createdBy,
    };
  }

  GroupsModel.fromJson(Map<String, Object?> json)
      : this(
          groupID: json['groupID']! as String,
          title: json['title']! as String,
          explanation: json['explanation']! as String,
          userInCharge: json['userInCharge']! as String,
          people: json['people']! as List<dynamic>,
          imageURL: json['imageURL']! as String,
          createdAt: json['createdAt']! as Timestamp,
          createdBy: json['createdBy']! as String,
        );
}
