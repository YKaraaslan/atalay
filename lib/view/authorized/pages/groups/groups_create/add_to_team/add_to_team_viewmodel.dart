import 'package:flutter/widgets.dart';

import '../../../../../../core/models/user_model.dart';
import '../../../../../../core/service/service_path.dart';

class AddToTeamViewModel extends ChangeNotifier {
  late List<UserModel> userModels;
  late List<UserModel> selectedUsers;

  Future getUsers() async {
    await ServicePath.usersCollectionReference.get().then((value) {
      for (var item in value.docs) {
        UserModel userModel = UserModel(
            id: item.get('id'),
            name: item.get('name'),
            surname: item.get('imageURL'),
            fullName: item.get('fullName'),
            phone: item.get('phone'),
            birthday: item.get('birthday'),
            mail: item.get('mail'),
            password: item.get('password'),
            imageURL: item.get('imageURL'),
            signUpTime: item.get('signUpTime'),
            token: item.get('token'),
            signUpAcceptedTime: item.get('signUpAcceptedTime'),
            signUpAcceptedBy: item.get('signUpAcceptedBy'),
            authorization: item.get('authorization'),
            position: item.get('position'),
            online: item.get('online'),
            onlineTime: item.get('onlineTime'));
        userModels.add(userModel);
      }
      userModels.sort((a, b) => a.fullName.toString().compareTo(b.fullName.toString()));
      notifyListeners();
    });
  }

  void selectUser(int index) {
    selectedUsers.any((element) => element.id == userModels[index].id)
        ? selectedUsers.removeWhere(
            (element) => element.id == userModels[index].id,
          )
        : selectedUsers.add(userModels[index]);
    notifyListeners();
  }
}
