// ignore_for_file: unnecessary_final

import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/groups_model.dart';
import '../../../../../core/models/user_model.dart';
import 'add_to_team/add_to_team_view.dart';
import 'groups_create_service.dart';

class GroupsCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController explanationController;
  late List<UserModel> usersSelectedForTeam;
  BaseDialog baseDialog = BaseDialog();
  File? image;
  UserModel? personInCharge;

  Future getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future<void> navigateAndDisplaySelection(BuildContext context) async {
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

  Future<void> navigateAndDisplaySelectionForPersonInCharge(
      BuildContext context) async {
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

  Future createGroup(BuildContext context) async {
    if (image == null) {
      return showSnackbar(context, 'image_cannot_be_blank'.tr());
    }
    if (personInCharge == null) {
      return showSnackbar(context, 'person_incharge_cannot_be_blank'.tr());
    }
    baseDialog.text = 'creating_group'.tr();
    baseDialog.showLoadingDialog(context);

    GroupsModel model = GroupsModel(
        groupID: '',
        title: nameController.text.trim(),
        explanation: explanationController.text.trim(),
        userInCharge: personInCharge!.id,
        people: List.generate(usersSelectedForTeam.length,
            (index) => usersSelectedForTeam[index].id),
        imageURL: '',
        createdAt: Timestamp.now(),
        createdBy: FirebaseAuth.instance.currentUser!.uid);

    bool result = await saveGroupsToDatabase(model, image!);
    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'group_added_successfully'.tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'group_add_failed'.tr());
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
}
