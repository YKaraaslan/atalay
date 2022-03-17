import 'package:cloud_firestore/cloud_firestore.dart';

class PostLikeUiModel {
  String nameSurname;
  String imageURL;
  Timestamp likedAt;
  
  PostLikeUiModel({
    required this.nameSurname,
    required this.imageURL,
    required this.likedAt,
  });
}
