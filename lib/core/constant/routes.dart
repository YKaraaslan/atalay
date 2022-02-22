import 'package:flutter/material.dart';

import '../../view/src/unauthorized/login/login_view.dart';
import '../../view/src/unauthorized/signup/signup_view.dart';

class Routes {

  static const String home = '/home'; // use '' if there are multiple views.
  static const String login = '/login'; // use '' if there are multiple views.
  static const String signup = '/signup'; // use '' if there are multiple views.

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    login: (context) => LoginView(),
    signup: (context) => const SignupView(),
    };
  }
}