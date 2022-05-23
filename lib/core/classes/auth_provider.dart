import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  int index = 0;
  String name = '';
  bool postsCreate = false;
  bool announcementsCreate = false;
  bool projectsCreate = false;
  bool groupsCreate = false;
  bool referencesCreate = false;
  bool financesCreate = false;
  bool meetingsCreate = false;
  bool tabPosts = false;
  bool tabDashboard = false;
  bool tabProjects = false;
  bool tabUsers = false;
  bool tabGroups = false;
  bool tabReferences = false;
  bool tabFinances = false;
  bool tabMeetings = false;
  bool tabUsersOnHold = false;

  void notify() {
    notifyListeners();
  }
}

/*Future addAuth() async {
    await ServicePath.authorizationCollectionReference.add(
      AuthorizationModel(
          name: 'User',
          index: 2,
          postsCreate: false,
          announcementsCreate: false,
          projectsCreate: false,
          groupsCreate: false,
          referencesCreate: false,
          financesCreate: false,
          meetingsCreate: false,
          tabPosts: true,
          tabDashboard: true,
          tabProjects: true,
          tabUsers: true,
          tabGroups: true,
          tabReferences: true,
          tabFinances: false,
          tabMeetings: true,
          tabUsersOnHold: false).toMap(),
    );
  }*/