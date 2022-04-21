import '../../../../../core/service/service_path.dart';

Future<void> deleteMeeting(String id) async {
  await ServicePath.meetingsCollectionReference.doc(id).delete();
}
