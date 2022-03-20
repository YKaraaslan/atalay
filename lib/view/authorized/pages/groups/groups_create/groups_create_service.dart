import 'dart:io';

import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/groups_model.dart';

Future<bool> saveGroupsToDatabase(GroupsModel model, File image) async {
  String imageURL = "";
  try {
    await ServicePath.groupsCollectionReference.add(model.toMap()).then((value) async {
      await ServicePath.groupsPhotoReference.child(value.id).child(image.path.split('/').last).putFile(image);
      imageURL = await ServicePath.groupsPhotoReference.child(value.id).child(image.path.split('/').last).getDownloadURL();
      ServicePath.groupsCollectionReference.doc(value.id).update({'imageURL': imageURL});
    });
    return true;
  } on Exception {
    return false;
  }
}
