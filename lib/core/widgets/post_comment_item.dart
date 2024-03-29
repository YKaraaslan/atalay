import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/pages/posts/post_comments/post_comment_ui_model.dart';
import '../../view/authorized/pages/profile/profile_view.dart';
import '../classes/time_ago.dart';
import '../constant/sizes.dart';
import '../constant/styles.dart';

class PostCommentItem extends StatelessWidget {
  const PostCommentItem({Key? key, required this.model}) : super(key: key);
  final PostCommentUiModel model;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (model.userID == FirebaseAuth.instance.currentUser!.uid) {
          return _MyComments(model: model);
        } else {
          return _TheirComments(model: model);
        }
      },
    );
  }
}

class _MyComments extends StatelessWidget {
  const _MyComments({Key? key, required this.model}) : super(key: key);
  final PostCommentUiModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 150, maxWidth: Sizes.width_83percent(context)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.comment,
                        style: Styles.commentSubTitleStyle(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      model.isUpdated ? "${"updated".tr()} • ${TimeAgo.timeAgoSinceDate(model.commentedAt)}" : TimeAgo.timeAgoSinceDate(model.commentedAt),
                      style: Styles.commentTimeStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileView(userID: model.userID),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage(model.authorImageURL),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TheirComments extends StatelessWidget {
  const _TheirComments({Key? key, required this.model}) : super(key: key);
  final PostCommentUiModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileView(userID: model.userID),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage(model.authorImageURL),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              constraints: BoxConstraints(minWidth: 150, maxWidth: Sizes.width_83percent(context)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileView(userID: model.userID),
                            ),
                          );
                        },
                        child: Text(
                          model.authorNameSurname,
                          style: Styles.commentTitleStyle(),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        model.comment,
                        style: Styles.commentSubTitleStyle(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      model.isUpdated ? "${"updated".tr()} • ${TimeAgo.timeAgoSinceDate(model.commentedAt)}" : TimeAgo.timeAgoSinceDate(model.commentedAt),
                      style: Styles.commentTimeStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
