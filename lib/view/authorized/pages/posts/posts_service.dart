import 'package:atalay/core/service/service_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Object?>> getAuthorInfo(String userID) async {
  return ServicePath.usersCollectionReference.doc(userID).get();
}

Future<int> getComments(String postID) async {
  int commentAmount = 0;
  try {
    await ServicePath.postsCommentsCollectionReference(postID).get().then((value) {
      commentAmount = value.size;
    });
  } catch (e) {
    commentAmount = 0;
  }
  return commentAmount;
}

Future<int> getLikes(String postID) async {
  int likesAmounts = 0;
  try {
    await ServicePath.postsLikesCollectionReference(postID).get().then((value) {
      likesAmounts = value.size;
    });
  } catch (e) {
    likesAmounts = 0;
  }
  return likesAmounts;
}
