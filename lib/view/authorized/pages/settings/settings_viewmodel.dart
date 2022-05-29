import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/service/service_path.dart';

part 'settings_service.dart';

class SettingsViewModel extends ChangeNotifier {
  bool isDarkMode = false;
  Future signOut(BuildContext context) async {
    await setOfflineService();
    await ServicePath.auth.signOut();
  }
}
