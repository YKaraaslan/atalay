import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String author;
  Timestamp publishedAt;
  List<Timestamp> updatedAt;
  String text;
  List<String> labels;
  List<String> images;

  PostModel({
    required this.author,
    required this.publishedAt,
    required this.updatedAt,
    required this.text,
    required this.labels,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'publishedAt': publishedAt,
      'updatedAt': updatedAt,
      'text': text,
      'labels': labels,
      'images': images,
    };
  }
}
