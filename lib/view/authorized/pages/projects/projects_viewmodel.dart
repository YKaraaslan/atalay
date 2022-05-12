import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/service/service_path.dart';

class ProjectsViewModel extends ChangeNotifier {
  int segmentedControlGroupValue = 0;

  final Map<int, Widget> tabs = <int, Widget>{
    0: Text('active_projects'.tr()),
    1: Text('finished_projects'.tr()),
    2: Text('all_projects'.tr())
  };

  void setSegmentedValue(int value) {
    segmentedControlGroupValue = value;
    notifyListeners();
  }
  
  Future<Map<String, dynamic>> getPercentage(String id) async {
    int percentage = 0;
    int total = 0;
    int counter = 0;

    await ServicePath.projectsToDoCollectionReference(id).get().then(
      (value) {
        total = value.docs.length;

        for (var item in value.docs) {
          if (item.get('status') == 'finished') {
            counter++;
          }
        }
      },
    );

    if (total != 0) {
      percentage = 100 * counter ~/ total;
    }
    
    return {'total': total, 'percentage': percentage};
  }
}
