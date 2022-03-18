import '../classes/time_ago.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/pages/posts/post_comments/post_comment_ui_model.dart';
import '../constant/routes.dart';
import '../constant/styles.dart';

class PostCommentItem extends StatelessWidget {
  const PostCommentItem({Key? key, required this.model}) : super(key: key);
  final PostCommentUiModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                child: Column(
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
                    Text(
                      model.comment,
                      style: commentSubTitleStyle(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
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
            ),
          ],
        ),
      ),
    );
  }
}
