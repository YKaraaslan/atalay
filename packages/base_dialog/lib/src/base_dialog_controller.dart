import 'package:base_dialog/src/base_dialog_view.dart';
import 'package:flutter/material.dart';

class BaseDialog {
  late String _text;
  late BuildContext dialogContext;

  set text(String text) {
    _text = text;
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return BaseDialogView(text: _text);
        });
  }

  void dismissDialog() {
    Navigator.of(dialogContext).pop();
  }
}
