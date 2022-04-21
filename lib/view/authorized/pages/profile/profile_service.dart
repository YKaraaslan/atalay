import 'dart:io';

import '../../../../core/service/service_path.dart';

Future<bool> changePhoto(File image) async {
  try {
    await ServicePath.profilePhotoReference.child(ServicePath.auth.currentUser!.uid).putFile(image);
    await ServicePath.usersCollectionReference.doc(ServicePath.auth.currentUser!.uid).update({'imageURL': await getPhotoURL()});
    return true;
  } on Exception {
    return false;
  }
}

Future<String> getPhotoURL() async {
  return await ServicePath.profilePhotoReference.child(ServicePath.auth.currentUser!.uid).getDownloadURL();
}
