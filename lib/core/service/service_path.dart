import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServicePath {
  ServicePath._();

  static final CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('Users');
  static final CollectionReference appCollectionReference =
      FirebaseFirestore.instance.collection('App');

  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final profilePhotoReference = storage.ref('ProfilePhotos/');
}
