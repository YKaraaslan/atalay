import 'package:atalay/core/models/post_model.dart';
import 'package:atalay/view/authorized/pages/posts/posts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'posts_service.dart';

class PostsViewModel extends ChangeNotifier {
  Future<PostUiModel> getUserInfos(PostModel post) async {

    Future<DocumentSnapshot<Object?>> authorInfo = getAuthorInfo(post.authorID);
    int likes = await getLikes(post.postID);
    int comments = await getComments(post.postID);

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
      likes: likes,
      comments: comments,
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
}
