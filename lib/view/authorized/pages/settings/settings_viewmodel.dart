import 'package:flutter/widgets.dart';

import '../../../../core/service/service_path.dart';

class SettingsViewModel extends ChangeNotifier {
  Future signOut(BuildContext context) async {
    await ServicePath.auth.signOut();
  }
}
