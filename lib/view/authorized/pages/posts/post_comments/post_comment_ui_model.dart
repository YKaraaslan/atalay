import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentUiModel {
  String userID;
  String authorNameSurname;
  String authorImageURL;
  String comment;
  Timestamp commentedAt;
  bool isUpdated;

  PostCommentUiModel({
    required this.userID,
    required this.authorNameSurname,
    required this.authorImageURL,
    required this.comment,
    required this.commentedAt,
    required this.isUpdated,
  });
}
