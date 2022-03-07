import 'package:atalay/view/authorized/pages/notifications/notifications_view.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/home/home_view.dart';
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

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    login: (context) => LoginView(),
    signup: (context) => SignupView(),
    forgotPassword: (context) => ForgotPasswordView(),
    home: (context) => const HomeView(),
    projectDetails: (context) => const ProjectDetailsView(),
    projectTeam: (context) => const ProjectTeamView(),
    notifications: (context) => const NotificationsView(),
    };
  }
}