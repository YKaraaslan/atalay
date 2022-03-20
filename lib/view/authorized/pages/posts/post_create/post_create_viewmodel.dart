import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/models/post_model.dart';
import '../../../../unauthorized/signup/widgets/signup_bottom_sheet_with_photo.dart';
import 'post_create_service.dart';

class PostCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController labelTextController;
  late TextEditingController postController;
  late List<String> labels;
  late List<File> images;
  final int maxAllowedImage = 6;
  late BuildContext buildContext;
  BaseDialog baseDialog = BaseDialog();

  Future createPost(BuildContext context) async {
    if (postController.text.trim().isEmpty && images.isEmpty) {
      return showSnackbar(context, 'post_create_validator'.tr());
    }
    baseDialog.text = "creating_post".tr();
    baseDialog.showLoadingDialog(context);

    PostModel model = PostModel(
      postID: "",
      authorID: FirebaseAuth.instance.currentUser!.uid,
      labels: labels,
      text: postController.text.trim(),
      publishedAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      images: [],
      isUpdated: false,
      isVisible: true,
    );

    if (await savePostToDatabase(model, images)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, "post_create_successfull".tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, "post_create_failed".tr());
    }
  }

  Future<void> addLabel(BuildContext context) async {
    labelTextController.text = "";
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKeyForDialog,
          child: AlertDialog(
            title: Text('add_label'.tr()),
            content: TextFormField(
              autofocus: true,
              maxLength: 30,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "cannot_be_blank".tr();
                }
                return null;
              },
              controller: labelTextController,
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
                onPressed: () {
                  if (formKeyForDialog.currentState!.validate()) {
                    if (labels.length >= 5) {
                      showSnackbar(context, "labels_max_amount_reached".tr());
                    } else {
                      labels.add(labelTextController.text.trim());
                      notifyListeners();
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

  void getSelection(BuildContext context) {
    buildContext = context;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SignUpBottomSheet(
          cameraCallBack: getFromCamera,
          galleryCallBack: getFromGallery,
        );
      },
    );
  }

  Future getFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: ImageSource.camera);
    if (imagePicked == null) return;
    if (images.length >= maxAllowedImage) {
      return showSnackbar(buildContext, "images_max_amount_reached".tr());
    }
    images.add(File(imagePicked.path));
    notifyListeners();
  }

  Future getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? imagesPicked = await _picker.pickMultiImage();
    if (imagesPicked == null) return;

    for (var image in imagesPicked) {
      if (images.length >= maxAllowedImage) {
        return showSnackbar(buildContext, "images_max_amount_reached".tr());
      }
      images.add(File(image.path));
      notifyListeners();
    }
  }

  void deleteImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void onDeletedMethod(int index) {
    labels.removeAt(index);
    notifyListeners();
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
