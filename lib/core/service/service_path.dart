import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServicePath {
  ServicePath._();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference usersCollectionReference = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference usersOnHoldCollectionReference = FirebaseFirestore.instance.collection('UsersOnHold');
  static final CollectionReference appCollectionReference = FirebaseFirestore.instance.collection('App');
  static final CollectionReference authorizationCollectionReference = FirebaseFirestore.instance.collection('Authorization');

  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final profilePhotoReference = storage.ref('ProfilePhotos/');
}
