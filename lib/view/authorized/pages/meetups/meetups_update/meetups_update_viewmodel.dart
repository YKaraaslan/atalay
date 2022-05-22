import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/theme/dark_theme_provider.dart';
import '../../groups/groups_create/add_to_team/add_to_team_view.dart';
import 'meetups_update_service.dart';

class MeetupsUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController titleTextController;
  late TextEditingController startTimeTextController;
  late TextEditingController endTimeTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController locationTextController;
  late DateTime startTime;
  late DateTime endTime;
  late List<UserModel> usersSelectedForTeam;
  BaseDialog baseDialog = BaseDialog();
  late String id;

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
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (value) {
                    if (text == 'start_time'.tr()) {
                      startTime = DateTime(startTime.year, startTime.month, startTime.day, value.hour, value.minute);
                      startTimeTextController.text = DateFormat('dd MMM yyyy, hh:mm').format(startTime).toString();
                    } else {
                      endTime = DateTime(endTime.year, endTime.month, endTime.day, value.hour, value.minute);
                      endTimeTextController.text = DateFormat('dd MMM yyyy, hh:mm').format(endTime).toString();
                    }
                    notifyListeners();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToTeam(userReceivedList: usersSelectedForTeam),
      ),
    ).then((value) {
      if (value != null) {
        usersSelectedForTeam = value;
      }
      notifyListeners();
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

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }

  Future<void> getData(MeetingModel model) async {
    for (var item in model.participants) {
      await ServicePath.usersCollectionReference.doc(item).get().then(
        (value) {
          UserModel newModel = UserModel(
            id: value.get('id'),
            name: value.get('name'),
            surname: value.get('imageURL'),
            fullName: value.get('fullName'),
            phone: value.get('phone'),
            birthday: value.get('birthday'),
            mail: value.get('mail'),
            password: value.get('password'),
            imageURL: value.get('imageURL'),
            signUpTime: value.get('signUpTime'),
            token: value.get('token'),
            signUpAcceptedTime: value.get('signUpAcceptedTime'),
            signUpAcceptedBy: value.get('signUpAcceptedBy'),
            authorization: value.get('authorization'),
            position: value.get('position'),
            online: value.get('online'),
            onlineTime: value.get('onlineTime'),
            aboutMe: value.get('aboutMe'),
            interests: value.get('interests'),
          );
          usersSelectedForTeam.add(newModel);
        },
      );
    }
    notifyListeners();
  }

  Future updateMeeting(BuildContext context, MeetingModel modelReceived) async {
    if (endTime.isBefore(startTime)) {
      return showSnackbar(context, 'endtime_cannot_be_before_starttime'.tr());
    }

    baseDialog.text = 'Toplanti Guncelleniyor, Lutfen Bekleyiniz';
    baseDialog.showLoadingDialog(context);

    MeetingModel model = MeetingModel(
      createdBy: modelReceived.createdBy,
      createdAt: modelReceived.createdAt,
      title: titleTextController.text.trim(),
      description: descriptionTextController.text.trim(),
      location: locationTextController.text.trim(),
      startsAt: Timestamp.fromMillisecondsSinceEpoch(startTime.millisecondsSinceEpoch),
      endsAt: Timestamp.fromMillisecondsSinceEpoch(endTime.millisecondsSinceEpoch),
      participants: List.generate(usersSelectedForTeam.length, (index) => usersSelectedForTeam[index].id),
      isUpdated: true,
      updatedBy: ServicePath.auth.currentUser!.uid,
      updatedAt: Timestamp.now(),
    );

    bool result = await updateMeetings(model, id);
    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Toplanti guncellendi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Toplanti guncelleme basarisiz');
    }
  }
}
