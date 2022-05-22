import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../constant/assets.dart';
import '../constant/routes.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({Key? key, this.zoomDrawerController, required this.title, this.bottom, required this.actions}) : super(key: key);

  final ZoomDrawerController? zoomDrawerController;
  final String title;
  final PreferredSizeWidget? bottom;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).iconTheme.color),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      leading: zoomDrawerController == null
          ? BackButton(color: Theme.of(context).iconTheme.color,)
          : IconButton(
              icon: SvgPicture.asset(Assets.menu, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                if (zoomDrawerController != null) {
                  zoomDrawerController!.toggle!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      actions: actions.isEmpty
          ? [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.notifications),
                icon: SvgPicture.asset(Assets.notification, color: Theme.of(context).iconTheme.color,),
              )
            ]
          : actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
