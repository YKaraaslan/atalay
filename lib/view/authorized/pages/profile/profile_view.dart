import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController? zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'profile'.tr(),
      ),
      onPageBuilder: (context, value) => Container(),
    );
  }
}