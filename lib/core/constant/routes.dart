import 'package:flutter/material.dart';

import '../../view/authorized/home/home_view.dart';
import '../../view/authorized/pages/finance/finance_transaction/finance_transaction_view.dart';
import '../../view/authorized/pages/groups/groups_create/groups_create_view.dart';
import '../../view/authorized/pages/notifications/notifications_view.dart';
import '../../view/authorized/pages/posts/post_create/post_create_view.dart';
import '../../view/authorized/pages/projects/projects_create/projects_create_view.dart';
import '../../view/authorized/pages/users_onhold/userDetails/user_details_view.dart';
import '../../view/unauthorized/forgot_password/forgot_password_view.dart';
import '../../view/unauthorized/login/login_view.dart';
import '../../view/unauthorized/signup/signup_view.dart';
import '../../view/unauthorized/signup/widgets/show_photo.dart';
import '../widgets/base_photo_viewer.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String signupShowPhoto = '/signup_show_photo';
  static const String forgotPassword = '/forgot_password';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String userDetails = '/user_details';
  static const String basePhotoViewer = '/base_photo_viewer';
  static const String postCreate = '/post_create';
  static const String projectsCreate = '/projects_create';
  static const String groupsCreate = '/groups_create';
  static const String financeCreate = '/finance_create';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      login: (context) => const LoginView(),
      signup: (context) => const SignupView(),
      signupShowPhoto: (context) => const SignUpShowPhoto(),
      forgotPassword: (context) => const ForgotPasswordView(),
      home: (context) => const HomeView(),
      notifications: (context) => const NotificationsView(),
      userDetails: (context) => const UserDetailsView(),
      basePhotoViewer: (context) => const BasePhotoViewer(),
      postCreate: (context) => const PostCreateView(),
      projectsCreate: (context) => const ProjectsCreateView(),
      groupsCreate: (context) => const GroupsCreateView(),
      financeCreate: (context) => const FinanceTransactionView(),
    };
  }
}
