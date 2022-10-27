import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/company_model.dart';
import 'references_company_update_service.dart';

class ReferencesCompanyUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late TextEditingController locationTextController;
  late File? image;
  BaseDialog baseDialog = BaseDialog();
  late CompanyModel model;

  Future<void> openGallery(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future<void> updateCompany(BuildContext context) async {
    baseDialog.text = 'Sirket guncelleniyor';
    baseDialog.showLoadingDialog(context);

    CompanyModel modelToUpdate = CompanyModel(
      companyName: nameTextController.text.trim(),
      description: descriptionTextController.text.trim(),
      mail: mailTextController.text.trim(),
      phone: phoneTextController.text.trim(),
      location: locationTextController.text.trim(),
      createdBy: model.createdBy,
      createdAt: model.createdAt,
      id: model.id,
      imageURL: model.imageURL,
    );

    if (await updateCompanyService(modelToUpdate, image)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Sirket Basariyla Guncellendi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Sirket guncellemesi basarisiz oldu');
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

  void dismissDialog(BuildContext context, String text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }

  void setAll(CompanyModel model) {
    nameTextController.text = model.companyName;
    descriptionTextController.text = model.description;
    mailTextController.text = model.mail;
    phoneTextController.text = model.phone;
    locationTextController.text = model.location;
  }
}
