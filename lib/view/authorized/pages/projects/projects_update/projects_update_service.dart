import '../../../../../../core/service/service_path.dart';

Future<bool> updateProjectService(Map<String, dynamic> newModel, String id) async {
  try {
    await ServicePath.projectsCollectionReference.doc(id).update(newModel);
    return true;
  } on Exception {
    return false;
  }
}
