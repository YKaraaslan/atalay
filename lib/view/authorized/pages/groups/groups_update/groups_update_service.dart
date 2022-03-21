import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/groups_model.dart';

Future<bool> updateGroupsOnDatabase(GroupsModel model, File? image) async {
  if (image == null) {
    try {
      await ServicePath.groupsCollectionReference.doc(model.groupID).update(model.toMap());
      return true;
    } on Exception {
      return false;
    }
  } else {
    String imageURL = "";
    try {
      await ServicePath.groupsCollectionReference.doc(model.groupID).update(model.toMap()).then((value) async {
        await FirebaseStorage.instance.refFromURL(model.imageURL).delete();
        await ServicePath.groupsPhotoReference.child(model.groupID).child(image.path.split('/').last).putFile(image);
        imageURL = await ServicePath.groupsPhotoReference.child(model.groupID).child(image.path.split('/').last).getDownloadURL();
        ServicePath.groupsCollectionReference.doc(model.groupID).update({'imageURL': imageURL});
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
