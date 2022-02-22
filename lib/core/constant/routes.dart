import 'package:atalay/view/src/unauthorized/forgot_password/forgot_password_view.dart';
import 'package:flutter/material.dart';

import '../../view/src/unauthorized/login/login_view.dart';
import '../../view/src/unauthorized/signup/signup_view.dart';

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
    };
  }
}