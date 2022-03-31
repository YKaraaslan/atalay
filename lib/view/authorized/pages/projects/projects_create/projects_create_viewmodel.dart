import 'package:base_dialog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/groups_model.dart';
import '../../../../../core/models/project_model.dart';
import '../../../../../core/models/project_todo_model.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../groups/groups_create/add_to_team/add_to_team_view.dart';
import 'add_group/add_group_view.dart';
import 'projects_create_service.dart';

class ProjectsCreateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController titleController;
  late TextEditingController explanationController;
  late TextEditingController toDoTextController;
  late TextEditingController deadlineController;
  late List<UserModel> usersSelectedForTeam;
  late List<GroupsModel> groupsSelectedForTeam;
  BaseDialog baseDialog = BaseDialog();

  late List<String> toDo;

  void onDeletedMethod(int index) {
    toDo.removeAt(index);
    notifyListeners();
  }

  Future<void> addLabel(BuildContext context) async {
    toDoTextController.text = "";
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKeyForDialog,
          child: AlertDialog(
            title: Text('add_todo'.tr()),
            content: TextFormField(
              autofocus: true,
              maxLength: 100,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "cannot_be_blank".tr();
                }
                return null;
              },
              controller: toDoTextController,
            ),
            actions: [
              TextButton(
                child: Text('cancel'.tr().toUpperCase()),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('add'.tr().toUpperCase()),
                onPressed: () {
                  if (formKeyForDialog.currentState!.validate()) {
                    toDo.add(toDoTextController.text.trim());
                    notifyListeners();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateAndDisplaySelectionForTeam(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToTeam(userReceivedList: usersSelectedForTeam),
      ),
    ).then((value) {
      if (value != null) {
        usersSelectedForTeam = value;
      }
    });
    notifyListeners();
  }

  void navigateAndDisplaySelectionForGroups(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGroupView(groupsSelectedForTeam: groupsSelectedForTeam),
      ),
    ).then((value) {
      if (value != null) {
        groupsSelectedForTeam = value;
      }
    });
    notifyListeners();
  }

  Future createProject(BuildContext context) async {
    baseDialog.text = "creating_project".tr();
    baseDialog.showLoadingDialog(context);

    ProjectModel model = ProjectModel(
      projectID: "",
      groupIDs: List.generate(groupsSelectedForTeam.length, (index) => groupsSelectedForTeam[index].groupID),
      createdBy: ServicePath.auth.currentUser!.uid,
      createdAt: Timestamp.now(),
      status: 'active',
      team: List.generate(usersSelectedForTeam.length, (index) => usersSelectedForTeam[index].id),
      title: titleController.text.trim(),
      explanation: explanationController.text.trim(),
      deadline: Timestamp.fromDate(DateFormat('dd MMMM yyyy').parse(deadlineController.text.trim())),
    );

    List<ProjectToDoModel> projectToDoModels = [];

    for (int i = 0; i < projectToDoModels.length; i++) {
      projectToDoModels.add(
        ProjectToDoModel(
            toDoID: "",
            text: toDo[i],
            createdBy: ServicePath.auth.currentUser!.uid,
            createdAt: Timestamp.now(),
            status: "active",
            urgency: 0,
            index: i),
      );
    }
    
    bool result = await createProjectService(model, projectToDoModels);
    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, "project_created_successfully".tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, "project_create_failed".tr());
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }

  Future showDateTimePicker(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now() ,
      lastDate: DateTime(DateTime.now().year + 5),
    );

    deadlineController.text = DateFormat('dd MMMM yyyy').format(newDate!);
  }

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }
}
