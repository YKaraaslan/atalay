import '../../../../../../core/models/groups_model.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../core/service/service_path.dart';

class AddGroupViewModel extends ChangeNotifier {
  late List<GroupsModel> userModels;
  late List<GroupsModel> selectedUsers;

  Future getUsers() async {
    await ServicePath.groupsCollectionReference.get().then((value) {
      for (var item in value.docs) {
        GroupsModel userModel = GroupsModel(
          groupID: item.get('groupID'),
          title: item.get('title'),
          createdAt: item.get('createdAt'),
          createdBy: item.get('createdBy'),
          explanation: item.get('explanation'),
          imageURL: item.get('imageURL'),
          people: item.get('people'),
          userInCharge: item.get('userInCharge'),
        );
        userModels.add(userModel);
      }
      userModels.sort((a, b) => a.title.toString().compareTo(b.title.toString()));
      notifyListeners();
    });
  }

  void selectUser(int index) {
    selectedUsers.any((element) => element.groupID == userModels[index].groupID)
        ? selectedUsers.removeWhere(
            (element) => element.groupID == userModels[index].groupID,
          )
        : selectedUsers.add(userModels[index]);
    notifyListeners();
  }
}
