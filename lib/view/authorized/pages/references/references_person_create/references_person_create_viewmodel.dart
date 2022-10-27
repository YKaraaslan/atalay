import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/company_model.dart';
import '../../../../../core/models/reference_model.dart';
import '../../../../../core/service/service_path.dart';
import '../references_add_to_companies/references_add_to_companies_view.dart';
import 'references_person_create_service.dart';

class ReferencesPersonCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextController;
  late TextEditingController surnameTimeTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late CompanyModel? companySelected;
  BaseDialog baseDialog = BaseDialog();
  late File? image;

  Future<void> navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReferencesAddToCompaniesView(
          referenceCompanyModel: companySelected,
        ),
      ),
    ).then((value) {
      if (value != null) {
        companySelected = value as CompanyModel;
      }
      notifyListeners();
    });
  }

  Future<void> openGallery(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future<void> createReference(BuildContext context) async {
    baseDialog.text = 'Referans olusturuluyor';
    baseDialog.showLoadingDialog(context);

    String companyID = '';

    if (companySelected != null) {
      companyID = companySelected!.id;
    }

    ReferenceModel model = ReferenceModel(
      id: '',
      companyID: companyID,
      name: nameTextController.text.trim(),
      surname: surnameTimeTextController.text.trim(),
      fullName:
          '${nameTextController.text.trim()} ${surnameTimeTextController.text.trim()}',
      createdAt: Timestamp.now(),
      createdBy: ServicePath.auth.currentUser!.uid,
      imageURL: '',
      phone: phoneTextController.text.trim(),
      mail: mailTextController.text.trim(),
      description: descriptionTextController.text.trim(),
    );

    if (await createReferenceService(model, image)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Referans Basariyla Olusturuldu');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Referans olusturma basarisiz oldu');
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
}
