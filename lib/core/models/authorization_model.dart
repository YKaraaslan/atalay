import 'dart:convert';

class AuthorizationModel {
  int index;
  String name;
  bool postsCreate;
  bool announcementsCreate;
  bool projectsCreate;
  bool groupsCreate;
  bool referencesCreate;
  bool financesCreate;
  bool meetingsCreate;
  bool tabPosts;
  bool tabDashboard;
  bool tabProjects;
  bool tabUsers;
  bool tabGroups;
  bool tabReferences;
  bool tabFinances;
  bool tabMeetings;
  bool tabUsersOnHold;

  AuthorizationModel({
    required this.index,
    required this.name,
    required this.postsCreate,
    required this.announcementsCreate,
    required this.projectsCreate,
    required this.groupsCreate,
    required this.referencesCreate,
    required this.financesCreate,
    required this.meetingsCreate,
    required this.tabPosts,
    required this.tabDashboard,
    required this.tabProjects,
    required this.tabUsers,
    required this.tabGroups,
    required this.tabReferences,
    required this.tabFinances,
    required this.tabMeetings,
    required this.tabUsersOnHold,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'name': name,
      'postsCreate': postsCreate,
      'announcementsCreate': announcementsCreate,
      'projectsCreate': projectsCreate,
      'groupsCreate': groupsCreate,
      'referencesCreate': referencesCreate,
      'financesCreate': financesCreate,
      'meetingsCreate': meetingsCreate,
      'tabPosts': tabPosts,
      'tabDashboard': tabDashboard,
      'tabProjects': tabProjects,
      'tabUsers': tabUsers,
      'tabGroups': tabGroups,
      'tabReferences': tabReferences,
      'tabFinances': tabFinances,
      'tabMeetings': tabMeetings,
      'tabUsersOnHold': tabUsersOnHold,
    };
  }

  factory AuthorizationModel.fromMap(Map<String, dynamic> map) {
    return AuthorizationModel(
      index: map['index']?.toInt() ?? 0,
      name: map['name'] ?? '',
      postsCreate: map['postsCreate'] ?? false,
      announcementsCreate: map['announcementsCreate'] ?? false,
      projectsCreate: map['projectsCreate'] ?? false,
      groupsCreate: map['groupsCreate'] ?? false,
      referencesCreate: map['referencesCreate'] ?? false,
      financesCreate: map['financesCreate'] ?? false,
      meetingsCreate: map['meetingsCreate'] ?? false,
      tabPosts: map['tabPosts'] ?? false,
      tabDashboard: map['tabDashboard'] ?? false,
      tabProjects: map['tabProjects'] ?? false,
      tabUsers: map['tabUsers'] ?? false,
      tabGroups: map['tabGroups'] ?? false,
      tabReferences: map['tabReferences'] ?? false,
      tabFinances: map['tabFinances'] ?? false,
      tabMeetings: map['tabMeetings'] ?? false,
      tabUsersOnHold: map['tabUsersOnHold'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorizationModel.fromJson(String source) => AuthorizationModel.fromMap(json.decode(source));
}
