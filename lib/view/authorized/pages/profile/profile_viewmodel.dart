import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../unauthorized/signup/widgets/signup_bottom_sheet_with_photo.dart';
import 'profile_service.dart';

class ProfileViewModel extends ChangeNotifier {
  File? image;
  late BuildContext context;
  BaseDialog baseDialog = BaseDialog();

  void getSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SignUpBottomSheet(
          cameraCallBack: getFromCamera,
          galleryCallBack: getFromGallery,
          imagePath: image,
        );
      },
    );
  }

  Future getFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: ImageSource.camera);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    showSheetToAccept();
    notifyListeners();
  }

  Future getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    showSheetToAccept();
    notifyListeners();
  }

  void showSheetToAccept() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('photo'.tr()),
          content: Image.file(image!),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Iptal Et',
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await changeProfilePhoto();
                },
                child: const Text('Degistir')),
          ],
        );
      },
    );
  }

  Future changeProfilePhoto() async {
    baseDialog.text = 'Fotografiniz Degistiriliyor';
    baseDialog.showLoadingDialog(context);

    if (await changePhoto(image!)) {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Fotografiniz Degistirildi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Fotografiniz Degistirilemedi');
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
