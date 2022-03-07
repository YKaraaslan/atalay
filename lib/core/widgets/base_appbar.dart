import 'package:atalay/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../constant/assets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {Key? key, this.zoomDrawerController, required this.title, this.bottom})
      : super(key: key);

  final ZoomDrawerController? zoomDrawerController;
  final String title;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: zoomDrawerController == null
          ? const BackButton(color: Colors.black)
          : IconButton(
              icon: SvgPicture.asset(Assets.menu),
              onPressed: () {
                if (zoomDrawerController != null) {
                  zoomDrawerController!.toggle!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      actions: [
        zoomDrawerController != null ? IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.notifications),
          icon: SvgPicture.asset(Assets.notification),
        ) : Container(),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
