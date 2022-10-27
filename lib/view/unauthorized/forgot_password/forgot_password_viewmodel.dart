import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/service/service_path.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController mailController;

  Future resetPassword(BuildContext context) async {
    bool? emailStatus = await checkIfEmailInUse(mailController.text.trim());
    if (emailStatus == null) {
      showSnackbar(context, 'password_reset_mail_unable_to_sent'.tr());
      return;
    } else if (!emailStatus) {
      showSnackbar(context, 'password_reset_mail_not_found'.tr());
      return;
    }
    await ServicePath.auth
        .sendPasswordResetEmail(email: mailController.text.trim());
    showSnackbar(context, 'password_reset_mail_sent'.tr());
    Navigator.pop(context);
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

  Future<bool?> checkIfEmailInUse(String emailAddress) async {
    try {
      List<String> list =
          await ServicePath.auth.fetchSignInMethodsForEmail(emailAddress);

      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return null;
    }
  }
}
