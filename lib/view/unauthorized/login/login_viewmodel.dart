import 'login_model.dart';

import 'login_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/base_loading_dialog.dart';

class LoginViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController mailController;
  late TextEditingController passwordController;
  late bool checked = true;

  Future login(BuildContext context) async {
    showLoadingDialog(context);
    String signInResult = await loginService(LoginModel(userName: mailController.text.trim(), password: passwordController.text.trim()));
    if (signInResult == "true") {
      return dismissDialog(context, 'welcome'.tr());
    }
    else if (signInResult == "user-not-found") {
      return dismissDialog(context, 'login_user_not_found'.tr());
    } else if (signInResult == "wrong-password") {
      return dismissDialog(context, 'login_wrong_password'.tr());
    } 
    else{
      return dismissDialog(context, 'login_failed'.tr());
    }
  }

  void checkClicked(bool value) {
    checked = value;
    notifyListeners();
  }

  void checkClickedReverse() {
    checked = !checked;
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

  Future<void> instagram() async {
    const nativeUrl = "instagram://user?username=atalayroket";
    const webUrl = "https://www.instagram.com/atalayroket/";
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    }
  }

  Future<void> linkedin() async {
    const webUrl = "https://www.linkedin.com/company/atalay-roket-takimi/";
    if (await canLaunch(webUrl)) {
      await launch(webUrl);
    }
  }

  Future<void> twitter() async {
    const webUrl = "https://twitter.com/atalayroket";
    if (await canLaunch(webUrl)) {
      await launch(webUrl);
    }
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            LoadingDialog(text: "logging_in".tr()));
  }

  void dismissDialog(BuildContext context, text) {
    Navigator.of(context, rootNavigator: true).pop();
    return showSnackbar(context, text);
  }
}
