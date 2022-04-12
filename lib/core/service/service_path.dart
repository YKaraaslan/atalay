import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServicePath {
  ServicePath._();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference applicationCollectionReference = FirebaseFirestore.instance.collection('Application');
  static final CollectionReference usersCollectionReference = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference usersOnHoldCollectionReference = FirebaseFirestore.instance.collection('UsersOnHold');
  static final CollectionReference announcementCollectionReference = FirebaseFirestore.instance.collection('Announcements');
  static final CollectionReference authorizationCollectionReference = FirebaseFirestore.instance.collection('Authorization');
  static final CollectionReference postsCollectionReference = FirebaseFirestore.instance.collection('Posts');
  static final CollectionReference groupsCollectionReference = FirebaseFirestore.instance.collection('Groups');
  static final CollectionReference projectsCollectionReference = FirebaseFirestore.instance.collection('Projects');
  static final CollectionReference financesCollectionReference = FirebaseFirestore.instance.collection('Finances');

  static CollectionReference userSavedPostsCollectionReference(String userID) {
    return usersCollectionReference.doc(userID).collection('SavedPosts');
  }

  static CollectionReference postsLikesCollectionReference(String postID) {
    return postsCollectionReference.doc(postID).collection('Likes');
  }

  static CollectionReference postsCommentsCollectionReference(String postID) {
    return postsCollectionReference.doc(postID).collection('Comments');
  }

  static CollectionReference projectsToDoCollectionReference(String projectID) {
    return projectsCollectionReference.doc(projectID).collection('ToDo');
  }
  
  static final DocumentReference applicationFinancesCollectionReference = FirebaseFirestore.instance.collection('Application').doc('Finances');


  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final profilePhotoReference = storage.ref('ProfilePhotos/');
  static final postsPhotoReference = storage.ref('Posts/');
  static final groupsPhotoReference = storage.ref('Groups/');
}
