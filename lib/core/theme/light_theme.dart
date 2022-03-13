import 'package:flutter/material.dart';

import '../constant/colors.dart';

ThemeData appLightTheme(BuildContext context){
  return ThemeData.light().copyWith(
    primaryColor: AppColors.appColor,
    brightness: Brightness.light,
    canvasColor: Colors.transparent,
  );
}
