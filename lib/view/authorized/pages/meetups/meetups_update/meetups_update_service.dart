import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/service/service_path.dart';

Future<bool> updateMeetings(MeetingModel model, String id) async {
  try {
    await ServicePath.meetingsCollectionReference.doc(id).update(model.toMap());
    return true;
  } catch (e) {
    return false;
  }
}
