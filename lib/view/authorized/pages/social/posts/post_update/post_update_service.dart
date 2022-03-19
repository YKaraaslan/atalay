import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../../core/service/service_path.dart';

Future<bool> updatePostService(Map<String, dynamic> model, List<File> images, List<String> imageLinks, String postID) async {
  try {
    ListResult results = await ServicePath.postsPhotoReference.child(postID).listAll();
    for (var item in results.items) {
      String downloadURL = await item.getDownloadURL();
      if (!imageLinks.any((element) => element == downloadURL)) {
        item.delete();
      }
    }

    if (images.isNotEmpty) {
      for (var image in images) {
        await ServicePath.postsPhotoReference.child(postID).child(image.path.split('/').last).putFile(image);
        imageLinks.add(await ServicePath.postsPhotoReference.child(postID).child(image.path.split('/').last).getDownloadURL());
      }
    }

    model["images"] = imageLinks;

    await ServicePath.postsCollectionReference.doc(postID).update(model);
    return true;
  } on Exception {
    return false;
  }
}
