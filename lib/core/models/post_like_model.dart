import 'package:cloud_firestore/cloud_firestore.dart';

class PostLikeModel {
  String userID;
  Timestamp likedAt;

  PostLikeModel({
    required this.userID,
    required this.likedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'likedAt': likedAt,
    };
  }

  PostLikeModel.fromJson(Map<String, Object?> json)
      : this(
          userID: json['userID']! as String,
          likedAt: json['likedAt']! as Timestamp,
        );
}
