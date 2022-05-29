import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/models/post_comment_model.dart';
import '../../../../../../core/service/service_path.dart';

Future<bool> saveCommentToDatabase(PostCommentModel model, String postID) async {
  try {
    await ServicePath.postsCommentsCollectionReference(postID).add(model.toMap());
    return true;
  } on Exception {
    return false;
  }
}

Future<DocumentSnapshot<Object?>> getAuthorInfo(String userID) async {
  return ServicePath.usersCollectionReference.doc(userID).get();
}
