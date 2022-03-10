import 'package:flutter/material.dart';

import '../../../../../../core/base/view/base_view.dart';

class GroupsTeamView extends StatelessWidget {
  const GroupsTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          onLongPress: () {},
          child: const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34814190?v=4'),
            ),
            title: Text('Yunus Karaaslan'),
            subtitle: Text('Yazilim Muhendisi'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
