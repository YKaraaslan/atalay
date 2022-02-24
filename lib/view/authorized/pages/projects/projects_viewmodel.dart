import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class ProjectsViewModel extends ChangeNotifier {
  int _segmentedControlGroupValue = 0;
  int get segmentedControlGroupValue => _segmentedControlGroupValue;

  final Map<int, Widget> tabs = <int, Widget>{
    0: Text("active_projects".tr()),
    1: Text("finished_projects".tr()),
    2: Text("all_projects".tr())
  };

  void setSegmentedValue(int value) {
    _segmentedControlGroupValue = value;
    notifyListeners();
  }
}
