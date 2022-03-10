import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/widgets/base_appbar.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'users'.tr(),
        zoomDrawerController: zoomDrawerController,
      ),
      onPageBuilder: (context, value) => ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.profile);
          },
          onLongPress: () {},
          child: const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34814190?v=4'),
            ),
            title: Text('Yunus Karaaslan'),
            subtitle: Text('Atalay Roket Takimi Mobil Yazilimci'),
            trailing: Icon(
              Icons.circle,
              size: 15,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
