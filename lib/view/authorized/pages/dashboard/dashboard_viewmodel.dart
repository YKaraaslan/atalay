import 'package:atalay/core/models/announcement_model.dart';
import 'package:atalay/core/service/service_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'dashboard_service.dart';

class DashboardViewModel extends ChangeNotifier {
  late TextEditingController announcementController;
  late GlobalKey<FormState> formKeyForDialog;

  Future addAnnouncement(BuildContext context) async {
    announcementController.text = "";
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKeyForDialog,
          child: AlertDialog(
            title: Text('add_announcement'.tr()),
            content: TextFormField(
              autofocus: true,
              maxLength: 150,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "cannot_be_blank".tr();
                }
                return null;
              },
              controller: announcementController,
            ),
            actions: [
              TextButton(
                child: Text('cancel'.tr().toUpperCase()),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('add'.tr().toUpperCase()),
                onPressed: () async {
                  if (formKeyForDialog.currentState!.validate()) {
                    AnnouncementModel model = AnnouncementModel(
                        text: announcementController.text.trim(), createdBy: ServicePath.auth.currentUser!.uid, createdAt: Timestamp.now());

                    if (await addAnnouncementService(model)) {
                      showSnackbar(context, "announcement_created_successfully".tr());
                    } else {
                      showSnackbar(context, "announcement_create_failed".tr());
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
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
}
