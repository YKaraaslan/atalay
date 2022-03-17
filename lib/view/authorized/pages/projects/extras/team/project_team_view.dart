import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/widgets/base_appbar.dart';

class ProjectTeamView extends StatelessWidget {
  const ProjectTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'team'.tr(),
        actions: const [],
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
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
