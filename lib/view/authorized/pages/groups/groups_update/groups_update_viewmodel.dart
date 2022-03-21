import 'dart:io';

import '../../../../../core/service/service_path.dart';
import 'package:base_dialog/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/groups_model.dart';
import '../../../../../core/models/user_model.dart';
import '../groups_create/add_to_team/add_to_team_view.dart';
import 'groups_update_service.dart';

class GroupsUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController explanationController;
  late List<UserModel> usersSelectedForTeam;
  BaseDialog baseDialog = BaseDialog();
  File? image;
  UserModel? personInCharge;

  Future getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
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

  void navigateAndDisplaySelectionForPersonInCharge(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToTeam(
          userReceivedList: usersSelectedForTeam,
          multiSelection: false,
        ),
      ),
    ).then((value) {
      if (value != null) {
        personInCharge = (value as List<UserModel>).first;
      }
      notifyListeners();
    });
  }

  Future updateGroup(BuildContext context, GroupsModel modelReceived) async {
    if (personInCharge == null) {
      return showSnackbar(context, "person_incharge_cannot_be_blank".tr());
    }
    baseDialog.text = "updating_group".tr();
    baseDialog.showLoadingDialog(context);

    GroupsModel model = GroupsModel(
        groupID: modelReceived.groupID,
        title: nameController.text.trim(),
        explanation: explanationController.text.trim(),
        userInCharge: personInCharge!.id,
        people: List.generate(usersSelectedForTeam.length, (index) => usersSelectedForTeam[index].id),
        imageURL: modelReceived.imageURL,
        createdAt: modelReceived.createdAt,
        createdBy: modelReceived.createdBy);

    bool result = await updateGroupsOnDatabase(model, image);
    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, "group_updated_successfully".tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, "group_update_failed".tr());
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

  void getData(GroupsModel model) async {
    nameController.text = model.title;
    explanationController.text = model.explanation;
    usersSelectedForTeam = [];
    await getInChargeInfo(model.userInCharge);
    await getTeamInfo(model.people);
    notifyListeners();
  }

  Future getInChargeInfo(String uid) async {
    await ServicePath.usersCollectionReference.doc(uid).get().then((value) {
      personInCharge = UserModel(
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
      );
    });
  }

  Future getTeamInfo(List<dynamic> people) async {
    for (var item in people) {
      await ServicePath.usersCollectionReference.doc(item).get().then((value) {
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
        );
        usersSelectedForTeam.add(newModel);
      });
    }
  }
}
