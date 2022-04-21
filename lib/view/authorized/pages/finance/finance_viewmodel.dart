import 'package:flutter/widgets.dart';

import '../../../../core/models/finance_transaction_model.dart';
import '../../../../core/service/service_path.dart';

class FinanceViewModel extends ChangeNotifier {
  late double balance;

  Future delete(String id, FinanceTransactionModel model) async {
    await ServicePath.financesCollectionReference.doc(id).delete();
    if (model.type == "addition") {
      double moneyLast = balance - model.money;
      if (moneyLast < 0) {
        moneyLast = 0;
      }
      await ServicePath.applicationFinancesCollectionReference.update({'balance': balance - model.money});
    } else if (model.type == "subtraction") {
      await ServicePath.applicationFinancesCollectionReference.update({'balance': balance + model.money});
    }
  }
}
