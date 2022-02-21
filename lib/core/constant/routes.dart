import 'package:atalay/view/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {

  static const String splash = ''; // use '' if there are multiple views.

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {

  return {
    splash: (context) => const SplashView(),
    };
  }
}