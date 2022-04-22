import 'dart:io';

import '../../../../../../core/models/company_model.dart';
import '../../../../../../core/service/service_path.dart';

Future<bool> createCompanyService(CompanyModel model, File? image) async {
  String imageURL = '';
  try {
    await ServicePath.companiesCollectionReference.add(model.toMap()).then((value) async {
      if (image != null) {
        await ServicePath.companiesPhotoReference.child(value.id).putFile(image);
        imageURL = await ServicePath.companiesPhotoReference.child(value.id).getDownloadURL();
      }
      await ServicePath.companiesCollectionReference.doc(value.id).update({'id': value.id, 'imageURL': imageURL});
    });
    return true;
  } catch (e) {
    return false;
  }
}
