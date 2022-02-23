import 'package:flutter/material.dart';

import '../../view/authorized/home/home_view.dart';
import '../../view/unauthorized/forgot_password/forgot_password_view.dart';
import '../../view/unauthorized/login/login_view.dart';
import '../../view/unauthorized/signup/signup_view.dart';

class Routes {

  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot_password';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    login: (context) => LoginView(),
    signup: (context) => SignupView(),
    forgotPassword: (context) => ForgotPasswordView(),
    home: (context) => const HomeView(),
    };
  }
}