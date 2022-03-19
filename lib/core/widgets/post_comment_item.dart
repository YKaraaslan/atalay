import 'package:atalay/core/constant/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../view/authorized/pages/social/posts/post_comments/post_comment_ui_model.dart';
import '../classes/time_ago.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/routes.dart';
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
                        style: commentSubTitleStyle(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Text(
                      model.isUpdated
                          ? "updated".tr() + " • " + TimeAgo.timeAgoSinceDate(model.commentedAt)
                          : TimeAgo.timeAgoSinceDate(model.commentedAt),
                      style: commentTimeStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.profile,
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
                Navigator.of(context).pushNamed(
                  Routes.profile,
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
                          Navigator.of(context).pushNamed(
                            Routes.profile,
                          );
                        },
                        child: Text(
                          model.authorNameSurname,
                          style: commentTitleStyle(),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        model.comment,
                        style: commentSubTitleStyle(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      model.isUpdated
                          ? "updated".tr() + " • " + TimeAgo.timeAgoSinceDate(model.commentedAt)
                          : TimeAgo.timeAgoSinceDate(model.commentedAt),
                      style: commentTimeStyle(),
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
