import '../../../../../../core/models/post_like_model.dart';
import 'post_like_ui_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../posts_ui_model.dart';
import 'post_like_service.dart';

class PostLikeViewModel extends ChangeNotifier {
  late PostUiModel uiModel;

  Future like() async {
    PostLikeModel model = PostLikeModel(userID: uiModel.authorID, likedAt: Timestamp.now());
    await likeAddToDatabase(uiModel.postID, model);
  }

  Future<PostLikeUiModel> getUserInfos(PostLikeModel model) async {
    Future<DocumentSnapshot<Object?>> authorInfo = getAuthorInfo();

    String authorNameSurname = await authorInfo.then((value) => value.get('fullName'));
    String authorimageURL = await authorInfo.then((value) => value.get('imageURL'));

    return PostLikeUiModel(
      nameSurname: authorNameSurname,
      imageURL: authorimageURL,
      likedAt: model.likedAt,
    );
  }
}
