import 'dart:io';

import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/reference_model.dart';

Future<bool> updateReferenceService(ReferenceModel model, File? image) async {
  try {
    await ServicePath.referencesCollectionReference.doc(model.id).update(model.toMap()).then((value) async {
      if (image != null) {
        await ServicePath.referencesPhotoReference.child(model.id).putFile(image);
        String imageURL = await ServicePath.referencesPhotoReference.child(model.id).getDownloadURL();
        await ServicePath.referencesCollectionReference.doc(model.id).update({'imageURL': imageURL});
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}
