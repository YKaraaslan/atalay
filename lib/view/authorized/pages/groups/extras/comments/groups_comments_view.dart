import 'package:flutter/material.dart';

class GroupsCommentsView extends StatelessWidget {
  const GroupsCommentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            //BasePost(index: index),
          ],
        );
      },
    );
  }
}
