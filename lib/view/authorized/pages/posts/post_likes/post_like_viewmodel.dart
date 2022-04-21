import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../core/models/post_like_model.dart';
import '../../../../../core/service/service_path.dart';
import '../posts_ui_model.dart';
import 'post_like_service.dart';
import 'post_like_ui_model.dart';

class PostLikeViewModel extends ChangeNotifier {
  late PostUiModel uiModel;

  Future like() async {
    PostLikeModel model = PostLikeModel(userID: ServicePath.auth.currentUser!.uid, likedAt: Timestamp.now());
    await likeAddToDatabase(uiModel.postID, model);
  }

  Future<PostLikeUiModel> getUserInfos(PostLikeModel model) async {
    Future<DocumentSnapshot<Object?>> authorInfo = getAuthorInfo(model.userID);

    String authorNameSurname = await authorInfo.then((value) => value.get('fullName'));
    String authorimageURL = await authorInfo.then((value) => value.get('imageURL'));

    return PostLikeUiModel(
      nameSurname: authorNameSurname,
      imageURL: authorimageURL,
      likedAt: model.likedAt,
    );
  }
}
