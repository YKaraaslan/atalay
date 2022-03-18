import '../../../../../core/models/post_comment_model.dart';
import 'post_comment_service.dart';
import 'post_comment_ui_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCommentsViewModel extends ChangeNotifier {
  late TextEditingController commentController;

  Future comment(BuildContext context, String postID) async {
    if (commentController.text.length > 200) {
      return showSnackbar(context, "comment_length_exceeded".tr() + commentController.text.length.toString());
    }
    String comment = commentController.text.trim();
    commentController.text = "";
    PostCommentModel model =
        PostCommentModel(userID: FirebaseAuth.instance.currentUser!.uid, comment: comment, commentedAt: Timestamp.now(), isUpdated: false);

    if (!await saveCommentToDatabase(model, postID)) {
      showSnackbar(context, "comment_unsuccessful".tr());
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }

  Future<PostCommentUiModel> getUserInfos(PostCommentModel comment) async {
    Future<DocumentSnapshot<Object?>> authorInfo = getAuthorInfo(comment.userID);

    String authorNameSurname = await authorInfo.then((value) => value.get('fullName'));
    String authorImageURL = await authorInfo.then((value) => value.get('imageURL'));

    return PostCommentUiModel(
      userID: comment.userID,
      authorNameSurname: authorNameSurname,
      authorImageURL: authorImageURL,
      comment: comment.comment,
      commentedAt: comment.commentedAt,
      isUpdated: comment.isUpdated,
    );
  }
}
