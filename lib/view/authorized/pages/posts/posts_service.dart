import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models/post_like_model.dart';
import '../../../../core/models/post_saved_model.dart';
import '../../../../core/service/service_path.dart';

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

Future saveAddToDatabase(String postID) async {
  PostSavedModel model = PostSavedModel(postID: postID, savedAt: Timestamp.now());
  CollectionReference ref = ServicePath.userSavedPostsCollectionReference(FirebaseAuth.instance.currentUser!.uid);
  if (await ref.where("postID", isEqualTo: postID).get().then((value) => value.docs.isEmpty)) {
    await ref.add(model.toMap());
  } else {
    await ref.where("postID", isEqualTo: postID).get().then((value) {
      for (var item in value.docs) {
        ref.doc(item.id).delete();
      }
    });
  }
}
