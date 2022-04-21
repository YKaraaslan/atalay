import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/models/users_onhold_model.dart';
import '../../../../../core/service/service_path.dart';
import 'user_details_service.dart';

class UserDetailsViewModel extends ChangeNotifier {
  BaseDialog baseDialog = BaseDialog();
  late UsersOnHoldModel model;
  String? auth;
  late GlobalKey<FormState> formKey;
  late TextEditingController roleController;

  late List<DropdownMenuItem<String>>? dropDownItems = [];

  Future acceptUser(BuildContext context) async {
    baseDialog.text = "accepting_user".tr();
    baseDialog.showLoadingDialog(context);

    auth ??= dropDownItems!.first.value;

    UserModel newModel = UserModel(
      id: model.id,
      name: model.name,
      surname: model.surname,
      fullName: model.fullName,
      phone: model.phone,
      birthday: model.birthday,
      mail: model.mail,
      password: model.password,
      imageURL: model.imageURL,
      signUpTime: model.signUpTime,
      token: model.token,
      signUpAcceptedTime: Timestamp.fromDate(DateTime.now()),
      signUpAcceptedBy: ServicePath.auth.currentUser!.uid,
      authorization: auth!,
      position: roleController.text.trim(),
      online: false,
      onlineTime: Timestamp.fromDate(DateTime.now()),
      aboutMe: '',
      interests: [],
    );

    await acceptUserService(newModel);
    closePage(context);
  }

  Future declineUser(BuildContext context) async {
    baseDialog.text = "declining_user".tr();
    baseDialog.showLoadingDialog(context);
    await declineUserService(model);
    closePage(context);
  }

  void closePage(BuildContext context) {
    baseDialog.dismissDialog();
    Navigator.pop(context);
    showSnackbar(context, "process_finished_successfully".tr());
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
