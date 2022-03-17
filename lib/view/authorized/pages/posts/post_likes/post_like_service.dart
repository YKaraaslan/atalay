import 'package:atalay/core/service/service_path.dart';
import 'package:atalay/view/authorized/pages/posts/post_likes/post_like_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future likeAddToDatabase(String postID, PostLikeModel model) async {
  if (await ServicePath.postsLikesCollectionReference(postID)
      .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => value.docs.isEmpty)) {
    await ServicePath.postsLikesCollectionReference(postID).add(model.toMap());
  }
}

Future<DocumentSnapshot<Object?>> getAuthorInfo() async {
  return ServicePath.usersCollectionReference.doc(FirebaseAuth.instance.currentUser!.uid).get();
}