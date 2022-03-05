import 'package:atalay/core/base/view/base_view.dart';
import 'package:atalay/core/widgets/base_appbar.dart';
import 'package:flutter/material.dart';

class ProjectTeamView extends StatelessWidget {
  const ProjectTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Gorevliler',
      ),
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
          ),
        ),
      ),
    );
  }
}
