import 'package:flutter/material.dart';

class Sizes {
  static double height_100percent (BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double height_35percent (BuildContext context) {
    return MediaQuery.of(context).size.height * 0.35;
  }

  static double width_100percent (BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double width_90percent (BuildContext context) {
    return MediaQuery.of(context).size.width * 0.9;
  }

  static double width_50percent (BuildContext context) {
    return MediaQuery.of(context).size.width * 0.5;
  }
}