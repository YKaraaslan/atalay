import 'package:base_dialog/main.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/company_model.dart';
import 'references_company_show_service.dart';

class ReferencesCompanyShowViewModel extends ChangeNotifier {
  late TextEditingController nameTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController mailTextController;
  late TextEditingController phoneTextController;
  late TextEditingController locationTextController;
  BaseDialog baseDialog = BaseDialog();

  void setAll(CompanyModel model) {
    nameTextController.text = model.companyName;
    descriptionTextController.text = model.description;
    mailTextController.text = model.mail;
    phoneTextController.text = model.phone;
    locationTextController.text = model.location;
  }

  Future<void> delete(BuildContext context, CompanyModel model) async {
    baseDialog.text = 'Sirket Siliniyor';
    baseDialog.showLoadingDialog(context);

    if (await deleteReferenceCompanyService(model)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, "Sirket Basariyla Silindi");
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, "Sirket silme islemi basarisiz oldu");
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
