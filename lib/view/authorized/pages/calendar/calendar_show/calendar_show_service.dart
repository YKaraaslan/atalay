import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/service/service_path.dart';

Future<bool> deleteEvent(Timestamp time) async {
  try {
    await ServicePath.calendarCollectionReference(ServicePath.auth.currentUser!.uid).where('dateStart', isEqualTo: time).get().then((value) async {
      await ServicePath.calendarCollectionReference(ServicePath.auth.currentUser!.uid).doc(value.docs.first.id).delete();
    });
    return true;
  } catch(e) {
    return false;
  }
}
