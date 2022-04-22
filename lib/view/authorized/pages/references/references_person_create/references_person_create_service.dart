import 'dart:io';

import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/reference_model.dart';

Future<bool> createReferenceService(ReferenceModel model, File? image) async {
  String imageURL = '';
  try {
    await ServicePath.referencesCollectionReference.add(model.toMap()).then((value) async {
      if (image != null) {
        await ServicePath.referencesPhotoReference.child(value.id).putFile(image);
        imageURL = await ServicePath.referencesPhotoReference.child(value.id).getDownloadURL();
      }
      await ServicePath.referencesCollectionReference.doc(value.id).update({'id': value.id, 'imageURL': imageURL});
    });
    return true;
  } catch (e) {
    return false;
  }
}
