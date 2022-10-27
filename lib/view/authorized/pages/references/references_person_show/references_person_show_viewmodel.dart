import 'package:base_dialog/main.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/reference_model.dart';
import 'references_person_show_service.dart';

class ReferencesPersonShowViewModel extends ChangeNotifier {
  late TextEditingController nameTextController;
  late TextEditingController surnameTimeTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late ReferenceModel model;
  BaseDialog baseDialog = BaseDialog();

  void setAll(ReferenceModel model) {
    nameTextController.text = model.name;
    surnameTimeTextController.text = model.surname;
    descriptionTextController.text = model.description;
    mailTextController.text = model.mail;
    phoneTextController.text = model.phone;
    model = model;
  }

  Future<void> delete(BuildContext context, ReferenceModel model) async {
    baseDialog.text = 'Referans Siliniyor';
    baseDialog.showLoadingDialog(context);

    if (await deleteReferencePersonService(model)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Referans Basariyla Silindi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Referans silme islemi basarisiz oldu');
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
