import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/company_model.dart';
import '../../../../../core/service/service_path.dart';
import 'references_company_create_service.dart';

class ReferencesCompanyCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late TextEditingController locationTextController;
  late File? image;
  BaseDialog baseDialog = BaseDialog();

  Future<void> openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future<void> createCompany(BuildContext context) async {
    baseDialog.text = 'Sirket olusturuluyor';
    baseDialog.showLoadingDialog(context);

    CompanyModel model = CompanyModel(
      companyName: nameTextController.text.trim(),
      description: descriptionTextController.text.trim(),
      mail: mailTextController.text.trim(),
      phone: phoneTextController.text.trim(),
      location: locationTextController.text.trim(),
      createdBy: ServicePath.auth.currentUser!.uid,
      createdAt: Timestamp.now(),
      id: '',
      imageURL: '',
    );

    if (await createCompanyService(model, image)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Sirket Basariyla Olusturuldu');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Sirket olusturma basarisiz oldu');
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
