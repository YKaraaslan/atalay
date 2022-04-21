import '../../../../../../core/service/service_path.dart';
import '../../../../../core/models/project_model.dart';
import '../../../../../core/models/project_todo_model.dart';

Future<bool> createProjectService(ProjectModel model, List<ProjectToDoModel> toDos) async {
  try {
    await ServicePath.projectsCollectionReference.add(model.toMap()).then(
      (value) async {
        await ServicePath.projectsCollectionReference.doc(value.id).update({'projectID': value.id});
        if (toDos.isNotEmpty) {
          for (var item in toDos) {
            await ServicePath.projectsToDoCollectionReference(value.id).add(item.toMap()).then(
              (docValue) async {
                await ServicePath.projectsToDoCollectionReference(value.id).doc(docValue.id).update({'toDoID': docValue.id});
              },
            );
          }
        }
      },
    );
    return true;
  } on Exception {
    return false;
  }
}
