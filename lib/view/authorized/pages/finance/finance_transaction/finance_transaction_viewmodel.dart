import 'package:flutter/cupertino.dart';

class FinanceTransactionViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController titleTextController;
  late TextEditingController moneyController;

  late bool isAdd;
  late double money;
  late double moneyLast;

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

  Future createFinanceTransaction(BuildContext context)  async {
    
  }
}
