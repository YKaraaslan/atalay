import 'package:flutter/material.dart';

import '../constant/routes.dart';
import '../constant/styles.dart';

class PostCommentItem extends StatelessWidget {
  const PostCommentItem({Key? key}) : super(key: key);

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
              child: const CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/34814190?v=4'),
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
                padding: const EdgeInsets.only(
                    top: 5, left: 10, right: 5, bottom: 5),
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
                        'Yunus Karaaslan',
                        style: commentTitleStyle(),
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
                      style: commentSubTitleStyle(),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '23 dk.',
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
