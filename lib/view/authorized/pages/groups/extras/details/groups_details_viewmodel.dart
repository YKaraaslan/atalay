import 'package:flutter/material.dart';

import '../../../../../../core/constant/assets.dart';
import '../../../../../../core/models/groups_model.dart';
import '../../../projects/projects_all/projects_all_view.dart';
import '../team/groups_team_view.dart';

class GroupDetailsViewModel extends ChangeNotifier {
  late TabController controller;
  late List<Widget> pages = List.filled(2, Container());
  late final List<Tab> tabs = [
    Tab(text: 'Projeler', icon: Image.asset(Assets.groupsProjects, width: 30, height: 30)),
    Tab(text: 'Takim', icon: Image.asset(Assets.groupsTeam, width: 30, height: 30)),
  ];

  void setTabs(GroupsModel model) {
    pages = [
      const ProjectsAllView(),
      GroupsTeamView(groupsModel: model),
    ];

    notifyListeners();
  }
}
