import '../../../../../core/models/event_model.dart';
import '../../../../../core/service/service_path.dart';

Future<bool> addEvent(EventModel model) async {
  try {
    await ServicePath.calendarCollectionReference(ServicePath.auth.currentUser!.uid).add(model.toMap());
    return true;
  } on Exception {
    return false;
  }
}
