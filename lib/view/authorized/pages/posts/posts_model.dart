import 'package:cloud_firestore/cloud_firestore.dart';

class PostUiModel {
  String authorID;
  String authorNameSurname;
  String authorImageURL;
  String authorPosition;
  String text;
  String postID;
  List<dynamic> images;
  List<dynamic> labels;
  Timestamp publishedAt;
  bool isUpdated;
  Timestamp updatedAt;
  int likes;
  int comments;
  bool isLikedByMe;

  PostUiModel({
    required this.authorID,
    required this.authorNameSurname,
    required this.authorImageURL,
    required this.authorPosition,
    required this.text,
    required this.postID,
    required this.images,
    required this.labels,
    required this.publishedAt,
    required this.isUpdated,
    required this.updatedAt,
    required this.likes,
    required this.comments,
    required this.isLikedByMe,
  });
}
