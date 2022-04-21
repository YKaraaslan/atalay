import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/service/service_path.dart';

Future<bool> saveMeetingToDatabase(MeetingModel model) async {
  try {
    await ServicePath.meetingsCollectionReference.add(model.toMap());
    return true;
  } catch(e) {
    return false;
  }
}
