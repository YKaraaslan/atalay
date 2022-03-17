import '../../view/authorized/pages/posts/post_create/post_create_view.dart';
import '../widgets/base_photo_viewer.dart';
import '../../view/authorized/pages/users_onhold/userDetails/user_details_view.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/home/home_view.dart';
import '../../view/authorized/pages/groups/extras/details/groups_details_view.dart';
import '../../view/authorized/pages/notifications/notifications_view.dart';
import '../../view/authorized/pages/posts/post_comments/post_comments_view.dart';
import '../../view/authorized/pages/profile/profile_view.dart';
import '../../view/authorized/pages/projects/extras/details/project_details_view.dart';
import '../../view/authorized/pages/projects/extras/team/project_team_view.dart';
import '../../view/unauthorized/forgot_password/forgot_password_view.dart';
import '../../view/unauthorized/login/login_view.dart';
import '../../view/unauthorized/signup/signup_view.dart';
import '../../view/unauthorized/signup/widgets/show_photo.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String signupShowPhoto = '/signup_show_photo';
  static const String forgotPassword = '/forgot_password';
  static const String home = '/home';
  static const String projectDetails = '/project_details';
  static const String projectTeam = '/project_team';
  static const String notifications = '/notifications';
  static const String groupsDetails = '/groups_details';
  static const String postComments = '/post_comments';
  static const String profile = '/profile';
  static const String userDetails = '/user_details';
  static const String basePhotoViewer = '/base_photo_viewer';
  static const String postCreate = '/post_create';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      login: (context) => const LoginView(),
      signup: (context) => const SignupView(),
      signupShowPhoto: (context) => const SignUpShowPhoto(),
      forgotPassword: (context) => const ForgotPasswordView(),
      home: (context) => const HomeView(),
      projectDetails: (context) => const ProjectDetailsView(),
      projectTeam: (context) => const ProjectTeamView(),
      notifications: (context) => const NotificationsView(),
      groupsDetails: (context) => const GroupsDetailsView(),
      postComments: (context) => const PostCommentsView(),
      profile: (context) => const ProfileView(),
      userDetails: (context) => const UserDetailsView(),
      basePhotoViewer: (context) => const BasePhotoViewer(),
      postCreate: (context) => const PostCreateView(),
    };
  }
}
