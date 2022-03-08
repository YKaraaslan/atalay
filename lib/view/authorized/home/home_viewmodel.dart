import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../pages/dashboard/dashboard_view.dart';

class HomeViewModel extends ChangeNotifier {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  ZoomDrawerController get zoomDrawerController => _zoomDrawerController;

  late Widget _selectedWiget =
      DashboardView(zoomDrawerController: zoomDrawerController);
  Widget get selectedWidget => _selectedWiget;

  late final String _version = '1.0.0';
  String get version => _version;

  void setPage(Widget child) {
    _selectedWiget = child;
    notifyListeners();
  }
}
