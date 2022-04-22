import 'package:flutter/widgets.dart';

import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/company_model.dart';

class ReferencesAddToCompaniesViewModel extends ChangeNotifier {
  late List<CompanyModel> companyModels;
  late CompanyModel? selectedCompany;

  Future getCompanies() async {
    await ServicePath.companiesCollectionReference.get().then((value) {
      for (var item in value.docs) {
        CompanyModel userModel = CompanyModel(
          id: item.get('id'),
          companyName: item.get('companyName'),
          phone: item.get('phone'),
          mail: item.get('mail'),
          imageURL: item.get('imageURL'),
          createdAt: item.get('createdAt'),
          createdBy: item.get('createdBy'),
          description: item.get('description'),
          location: item.get('location'),
        );
        companyModels.add(userModel);
      }
      companyModels.sort((a, b) => a.companyName.toString().compareTo(b.companyName.toString()));
      notifyListeners();
    });
  }

  void selectUser(int index) {
    selectedCompany = companyModels[index];
    notifyListeners();
  }
}
