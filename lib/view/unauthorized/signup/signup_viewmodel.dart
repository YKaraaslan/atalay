import 'dart:io';

import 'package:base_dialog/main.dart';
import 'widgets/signup_bottom_sheet_with_photo.dart';
import 'sign_up_service_copy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'signup_model.dart';

class SignUpViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController mailController;
  late TextEditingController passwordController;
  File? image;
  BaseDialog baseDialog = BaseDialog();

  Future signUp(BuildContext context) async {
    baseDialog.text = "signing_up".tr();
    baseDialog.showLoadingDialog(context);

    String? userID = await signUpService(
        mailController.text.trim(), passwordController.text);
    if (userID == null) {
      return dismissDialog(context, "signing_up_failed".tr());
    } else if (userID == 'weak-password') {
      return dismissDialog(context, "weak_password".tr());
    } else if (userID == 'email-already-in-use'.tr()) {
      return dismissDialog(context, "email_already_in_use".tr());
    }

    bool photoResult = await signUpPhotoService(image!, userID);
    if (!photoResult) {
      return dismissDialog(context, "signing_up_photo_failed".tr());
    }

    String photoURL = await signUpPhotoURL(userID);

    SignUpModel model = SignUpModel(
      id: userID,
      name: nameController.text.trim(),
      surname: surnameController.text.trim(),
      phone: phoneController.text.trim(),
      birthday: Timestamp.fromDate(
          DateFormat('dd MMMM yyyy').parse(birthdayController.text.trim())),
      mail: mailController.text.trim(),
      password: passwordController.text.trim(),
      imageURL: photoURL,
      signUpTime: Timestamp.fromDate(DateTime.now()),
    );

    bool signUp = await signUpRegisterService(model);
    if (!signUp) {
      return dismissDialog(context, "signing_up_failed".tr());
    }
    dismissDialog(context, "signing_up_succesful".tr());
    return Navigator.pop(context);
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

  void getSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SignUpBottomSheet(
          cameraCallBack: getFromCamera,
          galleryCallBack: getFromGallery,
          isShowPhoto: image != null,
          imagePath: image,
        );
      },
    );
  }

  Future getFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future showDateTimePicker(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    birthdayController.text = DateFormat('dd MMMM yyyy').format(newDate!);
  }

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }
}
