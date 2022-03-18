import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentModel {
  String userID;
  String comment;
  Timestamp commentedAt;
  bool isUpdated;

  PostCommentModel({
    required this.userID,
    required this.comment,
    required this.commentedAt,
    required this.isUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'comment': comment,
      'commentedAt': commentedAt,
      'isUpdated': isUpdated,
    };
  }

  PostCommentModel.fromJson(Map<String, Object?> json)
      : this(
          userID: json['userID']! as String,
          comment: json['comment']! as String,
          commentedAt: json['commentedAt']! as Timestamp,
          isUpdated: json['isUpdated']! as bool,
        );
}
