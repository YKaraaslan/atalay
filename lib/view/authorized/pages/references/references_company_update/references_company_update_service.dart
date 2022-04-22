import 'dart:io';

import '../../../../../../core/models/company_model.dart';
import '../../../../../../core/service/service_path.dart';

Future<bool> updateCompanyService(CompanyModel model, File? image) async {
  try {
    await ServicePath.companiesCollectionReference.doc(model.id).update(model.toMap()).then((value) async {
      if (image != null) {
        await ServicePath.companiesPhotoReference.child(model.id).putFile(image);
        String imageURL = await ServicePath.companiesPhotoReference.child(model.id).getDownloadURL();
        await ServicePath.companiesCollectionReference.doc(model.id).update({'imageURL': imageURL});
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}
