import 'package:flutter/material.dart';

import '../../../../../../core/constant/assets.dart';
import '../../../projects/projects_all/projects_all_view.dart';
import '../comments/groups_comments_view.dart';
import '../team/groups_team_view.dart';

class GroupDetailsViewModel extends ChangeNotifier {
  final List<Tab> tabs = [
    Tab(text: 'Projeler', icon: Image.asset(Assets.groupsProjects, width: 30, height: 30)),
    Tab(text: 'Takim', icon: Image.asset(Assets.groupsTeam, width: 30, height: 30)),
    Tab(text: 'Gonderiler', icon: Image.asset(Assets.groupsComments, width: 30, height: 30)),
  ];

  final List<Widget> pages = const [
    ProjectsAllView(),
    GroupsTeamView(),
    GroupsCommentsView(),
  ];
}
