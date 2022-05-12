import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/finance_transaction_model.dart';
import '../../../../../core/service/service_path.dart';
import 'finance_transaction_service.dart';

class FinanceTransactionViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController titleTextController;
  late TextEditingController moneyController;
  late DateTime transactedAt;

  late bool isAdd;
  late double money = 0;
  late double moneyLast;

  BaseDialog baseDialog = BaseDialog();

  void changeIsAdd(bool bool) {
    isAdd = bool;
    double? currentLastMoney = double.tryParse(moneyController.text);
    if (isAdd && currentLastMoney != null) {
      moneyLast = money + currentLastMoney;
    } else if (!isAdd && currentLastMoney != null) {
      moneyLast = money - currentLastMoney;
    }
    notifyListeners();
  }

  void changeMoneyLast(double? double) {
    if (double != null) {
      if (isAdd) {
        moneyLast = money + double;
      } else {
        moneyLast = money - double;
      }
      notifyListeners();
    }
  }

  Future createFinanceTransaction(BuildContext context) async {
    if (!isAdd && money - double.parse(moneyController.text) < 0) {
      return showSnackbar(context, 'finance_create_balance_cannot_be_lower_than_zero'.tr());
    }

    baseDialog.text = 'creating_finance'.tr();
    baseDialog.showLoadingDialog(context);

    FinanceTransactionModel model = FinanceTransactionModel(
      title: titleTextController.text.trim(),
      money: double.tryParse(moneyController.text)!,
      createdAt: Timestamp.now(),
      transactedAt: Timestamp.fromMillisecondsSinceEpoch(transactedAt.millisecondsSinceEpoch),
      type: isAdd ? 'addition' : 'subtraction',
      balance: money,
      balanceFinal: isAdd ? money + double.parse(moneyController.text) : money - double.parse(moneyController.text),
      transactedBy: ServicePath.auth.currentUser!.uid,
    );

    if (await setTransaction(model)) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'finance_created_successfully'.tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'finance_create_failed'.tr());
    }
  }

  void changeTransactedAt(DateTime value) {
    transactedAt = value;
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
}
