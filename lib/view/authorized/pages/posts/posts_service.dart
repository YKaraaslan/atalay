import 'package:atalay/core/service/service_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'post_likes/post_like_model.dart';

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

Future<bool> getLikedOrNot(String postID) async {
  bool liked = false;
  try {
    await ServicePath.postsLikesCollectionReference(postID).where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        liked = true;
      }
    });
  } catch (e) {
    liked = false;
  }
  return liked;
}

Future likeAddToDatabase(PostLikeModel model, String postID) async {
  if (await ServicePath.postsLikesCollectionReference(postID)
      .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => value.docs.isEmpty)) {
    await ServicePath.postsLikesCollectionReference(postID).add(model.toMap());
  } else {
    await ServicePath.postsLikesCollectionReference(postID).where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      for (var item in value.docs) {
        ServicePath.postsLikesCollectionReference(postID).doc(item.id).delete();
      }
    });
  }
}
