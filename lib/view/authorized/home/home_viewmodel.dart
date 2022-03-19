import 'package:atalay/view/authorized/pages/social/social_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class HomeViewModel extends ChangeNotifier {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  late final String version = '1.0.0';
  late Widget selectedWiget = SocialView(zoomDrawerController: zoomDrawerController);

  void setPage(Widget child) {
    selectedWiget = child;
    notifyListeners();
  }

  Future<bool> onWillPop() async {
    if (zoomDrawerController.isOpen!()) {
      zoomDrawerController.close!();
    } else if (!zoomDrawerController.isOpen!()) {
      zoomDrawerController.open!();
    }
    return false;
  }

  void Function()? menuTap() {
    if (zoomDrawerController.isOpen!()) {
      zoomDrawerController.toggle!();
    }
    return null;
  }
}
