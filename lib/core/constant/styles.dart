import 'package:flutter/material.dart';

import 'dimens.dart';

class Styles {
  Styles._privateConstructor();
  static final Styles _instance = Styles._privateConstructor();
  factory Styles() {
    return _instance;
  }

  static TextStyle titleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 23,
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle loginTitleStyle() {
    return const TextStyle(
      fontSize: 20,
    );
  }

  static TextStyle buttonTextStyle() {
    return const TextStyle(
      fontSize: 18,
    );
  }

  static TextStyle zoomMenuTextStyle() {
    return const TextStyle(
      fontSize: 17,
      color: Colors.white,
    );
  }

  static TextStyle cardTitleStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle commentTitleStyle() {
    return const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87);
  }

  static TextStyle commentSubTitleStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey.shade800);
  }

  static TextStyle commentTimeStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey.shade500);
  }

  static TextStyle financeTitleStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle defaultMonthTextStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: Dimen.monthTextSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle defaultDateTextStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: Dimen.dateTextSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle defaultDayTextStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: Dimen.dayTextSize,
        fontWeight: FontWeight.w500,
      );
}
