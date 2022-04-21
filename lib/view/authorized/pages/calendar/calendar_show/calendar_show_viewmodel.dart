import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'calendar_show_service.dart';

class CalendarShowViewModel extends ChangeNotifier {
  late TextEditingController titleTextController;
  late TextEditingController startTimeTextController;
  late TextEditingController endTimeTextController;
  late TextEditingController descriptionTextController;
  late Timestamp time;
  BaseDialog baseDialog = BaseDialog();

  Future delete(BuildContext context) async {
    baseDialog.text = "event_deleting".tr();
    baseDialog.showLoadingDialog(context);

    if (await deleteEvent(time)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, "event_deleted_successfully".tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, "event_delete_failed".tr());
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }
}
