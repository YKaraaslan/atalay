import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/company_model.dart';

Future<bool> deleteReferenceCompanyService(CompanyModel model) async {
  try {
    await ServicePath.companiesCollectionReference.doc(model.id).delete();
    await ServicePath.referencesCollectionReference.where('companyID', isEqualTo: model.id).get().then((value) async {
      for (var doc in value.docs) {
        await ServicePath.referencesCollectionReference.doc(doc.id).update({'companyID': ''});
      }
    });
    await ServicePath.companiesPhotoReference.child(model.id).delete();
    return true;
  } catch (e) {
    return false;
  }
}
