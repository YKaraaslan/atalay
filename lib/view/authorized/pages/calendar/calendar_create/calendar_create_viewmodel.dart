import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/models/event_model.dart';
import '../../../../../core/theme/dark_theme_provider.dart';
import 'calendar_create_service.dart';

class CalendarCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController titleTextController;
  late TextEditingController startTimeTextController;
  late TextEditingController endTimeTextController;
  late TextEditingController descriptionTextController;
  late DateTime startTime;
  late DateTime endTime;
  BaseDialog baseDialog = BaseDialog();

  Future<void> createEvent(BuildContext context) async {
    if (endTime.isBefore(startTime)) {
      return showSnackbar(context, 'endtime_cannot_be_before_starttime'.tr());
    }

    baseDialog.text = 'creating_event'.tr();
    baseDialog.showLoadingDialog(context);

    EventModel model = EventModel(
      title: titleTextController.text.trim(),
      description: descriptionTextController.text.trim(),
      dateStart: Timestamp.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch),
      dateEnd: Timestamp.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch),
      createdAt: Timestamp.now(),
    );

    if (await addEvent(model)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'event_created_successfully'.tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'event_create_failed'.tr());
    }
  }

  void showTimePicker(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 250,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            color: context.read<DarkThemeProvider>().darkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  onDateTimeChanged: (value) {
                    if (text == 'start_time'.tr()) {
                      startTime = DateTime(startTime.year, startTime.month, startTime.day, value.hour, value.minute);
                      startTimeTextController.text = DateFormat('hh:mm').format(startTime).toString();
                    } else {
                      endTime = DateTime(endTime.year, endTime.month, endTime.day, value.hour, value.minute);
                      endTimeTextController.text = DateFormat('hh:mm').format(endTime).toString();
                    }
                    notifyListeners();
                  },
                  initialDateTime: text == 'start_time'.tr() ? startTime : endTime,
                ),
              ),
            ),
          ],
        ),
      ),
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

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }
}
