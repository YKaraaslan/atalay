part of 'settings_viewmodel.dart';

Future setOfflineService() async {
  await ServicePath.usersCollectionReference.doc(ServicePath.auth.currentUser!.uid).update({'online': false, 'onlineTime': Timestamp.now()});
}
