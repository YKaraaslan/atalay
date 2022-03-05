import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

// const pointerValueStyle = TextStyle(
//   fontSize: 18.0,
// );

TextStyle titleStyle (BuildContext context) {
  return TextStyle(
    fontSize: 23,
    color: Theme.of(context).primaryColor,
  );
}

TextStyle loginTitleStyle () {
  return const TextStyle(
    fontSize: 20,
  );
}

TextStyle buttonTextStyle () {
  return const TextStyle(
    fontSize: 18,
  );
}


TextStyle zoomMenuTextStyle () {
  return const TextStyle(
    fontSize: 17,
    color: Colors.white,
  );
}



TextStyle cardTitleStyle () {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.defaultMonthColor,
  fontSize: Dimen.monthTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.defaultDateColor,
  fontSize: Dimen.dateTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.defaultDayColor,
  fontSize: Dimen.dayTextSize,
  fontWeight: FontWeight.w500,
);