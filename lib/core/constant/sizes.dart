import 'package:flutter/material.dart';

class Sizes {
  Sizes._privateConstructor();
  static final Sizes _instance = Sizes._privateConstructor();
  factory Sizes() {
    return _instance;
  }

  static double height_100percent(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double height_35percent(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.35;
  }

  static double height_30percent(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.3;
  }

  static double height_15percent(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.15;
  }

  static double width_100percent(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double width_90percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.9;
  }

  static double width_83percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.83;
  }

  static double width_65percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.65;
  }

  static double width_60percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.6;
  }

  static double width_40percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.4;
  }

  static double width_30percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.3;
  }

  static double width_20percent(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.2;
  }
}
