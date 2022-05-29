import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/service/service_path.dart';
import '../../../../main.dart';

part 'settings_service.dart';
part 'widgets/language_dialog.dart';

class SettingsViewModel extends ChangeNotifier {
  bool isDarkMode = false;
  bool isNotificationAllowed = false;

  Future signOut(BuildContext context) async {
    await setOfflineService();
    await ServicePath.auth.signOut();
  }

  void languageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LanguageAlertDialog();
      },
    );
  }

  void setNotificationStatus(bool value) {
    isNotificationAllowed = value;
    notifyListeners();
  }
}
