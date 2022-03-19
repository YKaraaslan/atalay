import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postID;
  String authorID;
  Timestamp publishedAt;
  bool isUpdated;
  bool isVisible;
  Timestamp updatedAt;
  String text;
  List<dynamic> labels;
  List<dynamic> images;

  PostModel({
    required this.postID,
    required this.authorID,
    required this.publishedAt,
    required this.isUpdated,
    required this.isVisible,
    required this.updatedAt,
    required this.text,
    required this.labels,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'authorID': authorID,
      'publishedAt': publishedAt,
      'isUpdated': isUpdated,
      'isVisible': isVisible,
      'updatedAt': updatedAt,
      'text': text,
      'labels': labels,
      'images': images,
    };
  }

  PostModel.fromJson(Map<String, Object?> json)
      : this(
          postID: json['postID']! as String,
          authorID: json['authorID']! as String,
          publishedAt: json['publishedAt']! as Timestamp,
          isUpdated: json['isUpdated']! as bool,
          isVisible: json['isVisible']! as bool,
          updatedAt: json['updatedAt']! as Timestamp,
          text: json['text']! as String,
          labels: json['labels']! as List<dynamic>,
          images: json['images']! as List<dynamic>,
        );
}
