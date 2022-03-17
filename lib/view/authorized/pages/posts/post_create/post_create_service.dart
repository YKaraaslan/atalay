import 'dart:io';

import 'package:atalay/core/service/service_path.dart';

import '../../../../../core/models/post_model.dart';

Future<bool> savePostToDatabase(PostModel model, List<File> images) async {
  List<String> imageURLs = [];
  try {
    await ServicePath.postsCollectionReference.add(model.toMap()).then((value) async {
      ServicePath.postsCollectionReference.doc(value.id).update({'id': value.id});
      for (var image in images) {
        await ServicePath.postsPhotoReference.child(value.id).child(image.path.split('/').last).putFile(image);
        imageURLs.add(await ServicePath.postsPhotoReference.child(value.id).child(image.path.split('/').last).getDownloadURL());
      }
      ServicePath.postsCollectionReference.doc(value.id).update({'images': imageURLs});
    });
    return true;
  } on Exception {
    return false;
  }
}
