import 'package:atalay/core/models/finance_transaction_model.dart';
import 'package:atalay/core/service/service_path.dart';

Future<bool> setTransaction(FinanceTransactionModel model) async {
  try {
    await ServicePath.financesCollectionReference.add(model.toMap());
    await ServicePath.applicationFinancesCollectionReference.update({'balance': model.balanceFinal});
    return true;
  } catch (e) {
    return false;
  }
}
