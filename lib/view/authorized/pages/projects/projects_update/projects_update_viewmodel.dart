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
import '../projects_create/add_group/add_group_view.dart';
import 'projects_update_service.dart';

class ProjectsUpdateViewModel extends ChangeNotifier {
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
  late List<String> toDoId;

  void onDeletedMethod(int index) {
    toDo.removeAt(index);
    toDoId.removeAt(index);
    notifyListeners();
  }

  Future<void> addLabel(BuildContext context) async {
    toDoTextController.text = '';
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
                  return 'cannot_be_blank'.tr();
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

  Future updateProject(BuildContext context, ProjectModel model) async {
    baseDialog.text = 'updating_project'.tr();
    baseDialog.showLoadingDialog(context);

    Map<String, dynamic> newModel = {
      'groupIDs': List.generate(groupsSelectedForTeam.length, (index) => groupsSelectedForTeam[index].groupID),
      'team': List.generate(usersSelectedForTeam.length, (index) => usersSelectedForTeam[index].id),
      'title': titleController.text.trim(),
      'explanation': explanationController.text.trim(),
      'deadline': Timestamp.fromDate(DateFormat('dd MMMM yyyy').parse(deadlineController.text.trim())),
    };

    List<ProjectToDoModel> projectToDoModels = [];

    for (int i = 0; i < projectToDoModels.length; i++) {
      projectToDoModels.add(
        ProjectToDoModel(
            toDoID: '',
            text: toDo[i],
            createdBy: ServicePath.auth.currentUser!.uid,
            createdAt: Timestamp.now(),
            status: 'active',
            urgency: 0,
            index: i),
      );
    }

    bool result = await updateProjectService(newModel, model.projectID);
    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'project_update_successfully'.tr());
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'project_update_failed'.tr());
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
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate != null) {
      deadlineController.text = DateFormat('dd MMMM yyyy').format(newDate);
    }
  }

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }

  Future setPage(ProjectModel model) async {
    titleController.text = model.title;
    explanationController.text = model.explanation;
    deadlineController.text =
        DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(model.deadline.millisecondsSinceEpoch)).toString();
    await getTeamInfo(model.team);
    await getGroupInfo(model.groupIDs);
    /*await getToDos(model.projectID);*/
    notifyListeners();
  }

  Future getTeamInfo(List<dynamic> people) async {
    for (var item in people) {
      await ServicePath.usersCollectionReference.doc(item).get().then(
        (value) {
          UserModel newModel = UserModel(
            id: value.get('id'),
            name: value.get('name'),
            surname: value.get('imageURL'),
            fullName: value.get('fullName'),
            phone: value.get('phone'),
            birthday: value.get('birthday'),
            mail: value.get('mail'),
            password: value.get('password'),
            imageURL: value.get('imageURL'),
            signUpTime: value.get('signUpTime'),
            token: value.get('token'),
            signUpAcceptedTime: value.get('signUpAcceptedTime'),
            signUpAcceptedBy: value.get('signUpAcceptedBy'),
            authorization: value.get('authorization'),
            position: value.get('position'),
            online: value.get('online'),
            onlineTime: value.get('onlineTime'),
            aboutMe: value.get('aboutMe'),
            interests: value.get('interests'),
          );
          usersSelectedForTeam.add(newModel);
        },
      );
    }
  }

  Future getGroupInfo(List<dynamic> groups) async {
    for (var item in groups) {
      await ServicePath.groupsCollectionReference.doc(item).get().then(
        (value) {
          GroupsModel newModel = GroupsModel(
            groupID: value.get('groupID'),
            title: value.get('title'),
            explanation: value.get('explanation'),
            userInCharge: value.get('userInCharge'),
            people: value.get('people'),
            imageURL: value.get('imageURL'),
            createdAt: value.get('createdAt'),
            createdBy: value.get('createdBy'),
          );
          groupsSelectedForTeam.add(newModel);
        },
      );
    }
  }

  /*Future getToDos(String projectID) async {
    print(projectID);
    await ServicePath.projectsToDoCollectionReference(projectID).orderBy('index').get().then(
      (value) {
        print(value.size);
        for (var item in value.docs) {
          ProjectToDoModel newModel = ProjectToDoModel(
            toDoID: item.get('toDoID'),
            text: item.get('text'),
            createdBy: item.get('createdBy'),
            createdAt: item.get('createdAt'),
            status: item.get('status'),
            urgency: item.get('urgency'),
            index: item.get('index'),
          );
          toDo.add(newModel.text);
          toDoId.add(newModel.toDoID);
        }
        notifyListeners();
      },
    );
  }*/
}
