import 'dart:io';

import 'package:base_dialog/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/company_model.dart';
import '../../../../../core/models/reference_model.dart';
import '../../../../../core/service/service_path.dart';
import '../references_add_to_companies/references_add_to_companies_view.dart';
import 'references_person_update_service.dart';

class ReferencesPersonUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextController;
  late TextEditingController surnameTimeTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late CompanyModel? companySelected;
  BaseDialog baseDialog = BaseDialog();
  late File? image;
  late ReferenceModel model;

  void navigateAndDisplaySelection(BuildContext context) async {
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
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked == null) return;
    image = File(imagePicked.path);
    notifyListeners();
  }

  Future<void> updateReference(BuildContext context) async {
    baseDialog.text = 'Referans guncelleniyor';
    baseDialog.showLoadingDialog(context);

    ReferenceModel modelToUpdate = ReferenceModel(
      id: model.id,
      companyID: companySelected!.id,
      name: nameTextController.text.trim(),
      surname: surnameTimeTextController.text.trim(),
      fullName: '${nameTextController.text.trim()} ${surnameTimeTextController.text.trim()}',
      createdAt: model.createdAt,
      createdBy: model.createdBy,
      imageURL: model.imageURL,
      phone: phoneTextController.text.trim(),
      mail: mailTextController.text.trim(),
      description: descriptionTextController.text.trim(),
    );

    if (await updateReferenceService(modelToUpdate, image)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Referans Basariyla Guncellendi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Referans duncelleme basarisiz oldu');
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

  void setAll(ReferenceModel model) {
    nameTextController.text = model.name;
    surnameTimeTextController.text = model.surname;
    descriptionTextController.text = model.description;
    mailTextController.text = model.mail;
    phoneTextController.text = model.phone;
  }

  Future getCompanyInfo(String id) async {
    await ServicePath.companiesCollectionReference.doc(id).get().then(
      (value) {
        companySelected = CompanyModel(
          id: value.get('id'),
          companyName: value.get('companyName'),
          phone: value.get('phone'),
          mail: value.get('mail'),
          imageURL: value.get('imageURL'),
          createdAt: value.get('createdAt'),
          createdBy: value.get('createdBy'),
          description: value.get('description'),
          location: value.get('location'),
        );
        notifyListeners();
      },
    );
  }
}
