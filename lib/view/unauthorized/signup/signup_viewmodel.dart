import 'dart:io';

import 'package:atalay/core/widgets/base_loading_dialog.dart';
import 'package:atalay/view/unauthorized/signup/widgets/signup_bottom_sheet_with_photo.dart';
import 'package:atalay/view/unauthorized/signup/sign_up_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/service/service_path.dart';
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

  Future signUp(BuildContext context) async {
    String text = "Kayit islemi yapiliyor, lutfen bekleyiniz";
    double value = 0;
    showLoadingDialog(context, value, text);
    try {
      text = "Mail kaydi yapiliyor, lutfen bekleyiniz";
      notifyListeners();
      String? userID = await signUpService(mailController, passwordController);
      if (userID == null) {
        Navigator.of(context, rootNavigator: true).pop();
        return showSnackbar(context, "Kayit islemi basarisiz");
      }
      else if (userID == 'weak-password') {
        Navigator.of(context, rootNavigator: true).pop();
        return showSnackbar(context, "Sifreniz kullanima uygun degilir. Lutfen guclu bir sifre kullaniniz.");
      }
      else if (userID == 'email-already-in-use') {
        Navigator.of(context, rootNavigator: true).pop();
        return showSnackbar(context, "Bu mail adresine kayitli bir hesap zaten bulunmaktadir.");
      }
      text = "Kullanici kaydi yapiliyor, lutfen bekleyiniz";
      notifyListeners();
      await signUpRegisterService(
        SignUpModel(
          id: userID,
          name: nameController.text.trim(),
          surname: surnameController.text.trim(),
          phone: phoneController.text.trim(),
          birthday: Timestamp.fromDate(
              DateFormat('dd MMMM yyyy').parse(birthdayController.text.trim())),
          mail: mailController.text.trim(),
          password: passwordController.text.trim(),
          image: image!,
          signUpDateTime: Timestamp.fromDate(DateTime.now()),
          onlineTime: Timestamp.fromDate(DateTime.now()),
        ),
      );
      text = "Profil kaydi yapiliyor, lutfen bekleyiniz";
      notifyListeners();

      await ServicePath.profilePhotoReference
          .child(userID)
          .putFile(image!)
          .then(
        (event) {
          value =
              event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
          notifyListeners();
        },
      );

      Navigator.of(context, rootNavigator: true).pop();
      showSnackbar(context, 'Kayit Basarili');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar(context,
            'Şifreniz zayıf bulunmuştur. Lütfen güvenli bir şifre belirleyiniz.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(context,
            'Bu e-mail adresine kayitli bir hesap zaten bulunmaktadir.');
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }

  void getSelection(BuildContext context) {
    showBottomSheet(
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

  Future<void> showLoadingDialog(
      BuildContext context, double value, String text) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            LoadingDialog(value: value, text: text));
  }
}
