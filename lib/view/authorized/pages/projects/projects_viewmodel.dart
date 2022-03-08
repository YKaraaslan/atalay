import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'projects_active/projects_active_view.dart';
import 'projects_all/projects_all_view.dart';
import 'projects_finished/projects_finished_view.dart';

class ProjectsViewModel extends ChangeNotifier {
  int _segmentedControlGroupValue = 0;
  int get segmentedControlGroupValue => _segmentedControlGroupValue;

  final Map<int, Widget> tabs = <int, Widget>{
    0: Text("active_projects".tr()),
    1: Text("finished_projects".tr()),
    2: Text("all_projects".tr())
  };

  final children = const [ProjectsActiveView(), ProjectsFinishedView(), ProjectsAllView()];

  late Widget _child = children[0];
  Widget get child => _child;

  void setSegmentedValue(int value) {
    _segmentedControlGroupValue = value;
    _child = children[value];
    notifyListeners();
  }
}
