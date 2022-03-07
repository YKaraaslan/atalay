import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class ReferencesView extends StatelessWidget {
  const ReferencesView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'references'.tr(),
        zoomDrawerController: zoomDrawerController,
      ),
      onPageBuilder: (context, value) => ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          onLongPress: () {},
          child: const ListTile(
            leading:  CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34814190?v=4'),
            ),
            title:  Text('Yunus Karaaslan'),
            subtitle: Text('Atalay Roket Takimi Mobil Yazilimci'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
