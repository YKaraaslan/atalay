import '../../../../core/models/announcement_model.dart';
import '../../../../core/service/service_path.dart';

Future<bool> addAnnouncementService(AnnouncementModel model) async {
  try {
    await ServicePath.announcementCollectionReference.add(model.toMap());
    return true;
  } on Exception {
    return false;
  }
}
