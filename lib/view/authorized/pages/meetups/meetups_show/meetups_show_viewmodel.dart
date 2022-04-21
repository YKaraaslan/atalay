import 'package:base_dialog/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../profile/profile_view.dart';
import 'meetups_show_service.dart';

class MeetupsShowViewModel extends ChangeNotifier {
  late TextEditingController titleTextController;
  late TextEditingController startTimeTextController;
  late TextEditingController endTimeTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController locationTextController;
  BaseDialog baseDialog = BaseDialog();
  late MeetingModel model;
  late String id;
  late List<ListTile> listTiles = [];

  Future<void> setFields() async {
    titleTextController.text = model.title;
    startTimeTextController.text = DateFormat('dd MMM yyyy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(model.startsAt.millisecondsSinceEpoch));
    endTimeTextController.text = DateFormat('dd MMM yyyy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(model.endsAt.millisecondsSinceEpoch));
    descriptionTextController.text = model.description;
    locationTextController.text = model.location;
  }

  Future<void> getParticipants(BuildContext context) async {
    for (String userID in model.participants) {
      await ServicePath.usersCollectionReference.doc(userID).get().then(
        (value) {
          listTiles.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileView(userID: userID),
                  ),
                );
              },
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(value.get('imageURL')),
              ),
              title: Text(value.get('fullName')),
              subtitle: Text(value.get('position')),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      );
    }
    notifyListeners();
  }

  Future<void> delete(BuildContext context) async {
    deleteMeeting(id);
    Navigator.pop(context);
    showSnackbar(context, 'Toplanti silindi');
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
