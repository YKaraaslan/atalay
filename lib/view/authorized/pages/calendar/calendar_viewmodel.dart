import 'package:atalay/core/models/event_model.dart';
import 'package:atalay/core/service/service_path.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'calendar_service.dart';

class CalendarViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController dialogTextController;

  Future<void> showDialogForCalendar(BuildContext context, DateTime dateTime) async {
    dialogTextController.text = "";
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKeyForDialog,
          child: AlertDialog(
            title: Text(DateFormat('dd MMMM, hh:mm').format(dateTime)),
            content: TextFormField(
              autofocus: true,
              maxLength: 50,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "cannot_be_blank".tr();
                }
                return null;
              },
              controller: dialogTextController,
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
                    EventModel model = EventModel(
                      event: dialogTextController.text.trim(),
                      createdAt: Timestamp.now(),
                      eventTime: Timestamp.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch),
                    );

                    if (await addEvent(model)) {
                      showSnackbar(context, "event_created_successfully".tr());
                    } else {
                      showSnackbar(context, "event_create_failed".tr());
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

  Future<void> getEvents(BuildContext context) async {
    await ServicePath.calendarCollectionReference(ServicePath.auth.currentUser!.uid).get().then((value) {
      for (var doc in value.docs) {
        final event = CalendarEventData(
          date: DateTime.fromMillisecondsSinceEpoch((doc.get('eventTime') as Timestamp).millisecondsSinceEpoch),
          endDate: DateTime.fromMillisecondsSinceEpoch((doc.get('eventTime') as Timestamp).millisecondsSinceEpoch),
          event: doc.get('event'),
          title: "Title",
        );

        CalendarControllerProvider.of(context).controller.add(event);
        notifyListeners();
      }
    });
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
