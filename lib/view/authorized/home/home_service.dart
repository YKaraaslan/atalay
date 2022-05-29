part of 'home_viewmodel.dart';

Future setOnlineService() async {
  await ServicePath.usersCollectionReference.doc(ServicePath.auth.currentUser!.uid).update({'online': true});
}

Future setOfflineService() async {
  await ServicePath.usersCollectionReference.doc(ServicePath.auth.currentUser!.uid).update({'online': false, 'onlineTime': Timestamp.now()});
}
