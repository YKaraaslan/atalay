import 'package:cloud_firestore/cloud_firestore.dart';

class PostSavedModel {
  String postID;
  Timestamp savedAt;
  
  PostSavedModel({
    required this.postID,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'savedAt': savedAt,
    };
  }
}
