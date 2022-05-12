import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../unauthorized/signup/widgets/signup_bottom_sheet_with_photo.dart';
import '../posts_ui_model.dart';
import 'post_update_service.dart';

class PostUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController labelTextController;
  late TextEditingController postController;
  late List<String> labels;
  late List<File> images;
  late List<String> imagesLink;
  final int maxAllowedImage = 6;
  late BuildContext buildContext;
  BaseDialog baseDialog = BaseDialog();
  late PostUiModel model;

  Future updatePost(BuildContext context) async {
    baseDialog.text = 'updating_post'.tr();
    baseDialog.showLoadingDialog(context);

    Map<String, dynamic> map = {
      'labels': labels,
      'text': postController.text.trim(),
      'updatedAt': Timestamp.now(),
      'isUpdated': true,
      };

    if (await updatePostService(map, images, imagesLink, model.postID)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'post_update_successfull'.tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'post_update_failed'.tr());
    }
  }

  Future<void> addLabel(BuildContext context) async {
    labelTextController.text = '';
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
                  return 'cannot_be_blank'.tr();
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
                      showSnackbar(context, 'labels_max_amount_reached'.tr());
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
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera);
    if (imagePicked == null) return;
    if (images.length + imagesLink.length >= maxAllowedImage) {
      return showSnackbar(buildContext, 'images_max_amount_reached'.tr());
    }
    images.add(File(imagePicked.path));
    notifyListeners();
  }

  Future getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? imagesPicked = await picker.pickMultiImage();
    if (imagesPicked == null) return;

    for (var image in imagesPicked) {
      if (images.length + imagesLink.length >= maxAllowedImage) {
        return showSnackbar(buildContext, 'images_max_amount_reached'.tr());
      }
      images.add(File(image.path));
      notifyListeners();
    }
  }

  void deleteImage(int index) {
    if (index >= imagesLink.length) {
      images.removeAt(index - imagesLink.length);
    } else {
      imagesLink.removeAt(index);
    }
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

  void setData() {
    postController.text = model.text;
    labels = List<String>.from(model.labels);
    imagesLink = List<String>.from(model.images);
    notifyListeners();
  }
}
