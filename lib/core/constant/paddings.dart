import 'package:flutter/material.dart';

class AppPaddings {
  AppPaddings._privateConstructor();
  static final AppPaddings _instance = AppPaddings._privateConstructor();
  factory AppPaddings() {
    return _instance;
  }
  
  static EdgeInsets appPadding = const EdgeInsets.all(10);
  static EdgeInsets contentPadding = const EdgeInsets.all(25);
  static EdgeInsets cardContentPadding = const EdgeInsets.all(5);
}
