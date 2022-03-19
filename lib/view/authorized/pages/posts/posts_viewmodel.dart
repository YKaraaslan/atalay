import '../../../../core/models/post_model.dart';
import 'posts_ui_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/post_like_model.dart';
import 'posts_service.dart';

class PostsViewModel extends ChangeNotifier {
  Future<PostUiModel> getUserInfos(PostModel post) async {
    Future<DocumentSnapshot<Object?>> authorInfo = getAuthorInfo(post.authorID);

    String authorNameSurname = await authorInfo.then((value) => value.get('fullName'));
    String authorPosition = await authorInfo.then((value) => value.get('position'));
    String authorImageURL = await authorInfo.then((value) => value.get('imageURL'));

    return PostUiModel(
      authorID: post.authorID,
      authorNameSurname: authorNameSurname,
      authorPosition: authorPosition,
      authorImageURL: authorImageURL,
      text: post.text,
      images: post.images,
      labels: post.labels,
      publishedAt: post.publishedAt,
      isUpdated: post.isUpdated,
      updatedAt: post.updatedAt,
      postID: post.postID,
    );
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

  Future like(PostUiModel uiModel) async {
    PostLikeModel model = PostLikeModel(userID: uiModel.authorID, likedAt: Timestamp.now());
    await likeAddToDatabase(model, uiModel.postID);
  }

  Future save(PostUiModel uiModel) async {
    await saveAddToDatabase(uiModel.postID);
  }

  Future delete(BuildContext context, PostUiModel uiModel) async {
    await deleteFromDatabase(uiModel.postID);
  }
}
