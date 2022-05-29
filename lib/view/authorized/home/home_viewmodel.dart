import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../../core/service/service_path.dart';
import '../pages/posts/posts_view.dart';

part 'home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  late final String version = '1.0.0';
  late Widget selectedWiget = PostsView(zoomDrawerController: zoomDrawerController);

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

  Future<void> setOnline() async {
    await setOnlineService();
  }

  Future<void> setOffline() async {
    await setOfflineService();
  }
}
