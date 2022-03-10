import '../../view/authorized/pages/posts/post_comments.dart/post_comments_view.dart';
import '../../view/authorized/pages/posts/post_likes.dart/post_like_view.dart';
import '../../view/authorized/pages/profile/profile_view.dart';

import '../../view/authorized/pages/posts/post_details.dart/post_details_view.dart';

import '../../view/authorized/pages/notifications/notifications_view.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/home/home_view.dart';
import '../../view/authorized/pages/groups/extras/details/groups_details_view.dart';
import '../../view/authorized/pages/projects/extras/details/project_details_view.dart';
import '../../view/authorized/pages/projects/extras/team/project_team_view.dart';
import '../../view/unauthorized/forgot_password/forgot_password_view.dart';
import '../../view/unauthorized/login/login_view.dart';
import '../../view/unauthorized/signup/signup_view.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot_password';
  static const String home = '/home';
  static const String projectDetails = '/project_details';
  static const String projectTeam = '/project_team';
  static const String notifications = '/notifications';
  static const String groupsDetails = '/groups_details';
  static const String postDetails = '/post_details';
  static const String postComments = '/post_comments';
  static const String postLikes = '/post_likes';
  static const String profile = '/profile';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      login: (context) => LoginView(),
      signup: (context) => SignupView(),
      forgotPassword: (context) => ForgotPasswordView(),
      home: (context) => const HomeView(),
      projectDetails: (context) => const ProjectDetailsView(),
      projectTeam: (context) => const ProjectTeamView(),
      notifications: (context) => const NotificationsView(),
      groupsDetails: (context) => const GroupsDetailsView(),
      postDetails: (context) => const PostDetailsView(),
      postComments: (context) => const PostCommentsView(),
      postLikes: (context) => const PostLikeView(),
      profile: (context) => const ProfileView(),
    };
  }
}
