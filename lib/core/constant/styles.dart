import 'package:flutter/material.dart';

import 'dimens.dart';

// const pointerValueStyle = TextStyle(
//   fontSize: 18.0,
// );

TextStyle titleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 23,
    color: Theme.of(context).primaryColor,
  );
}

TextStyle loginTitleStyle() {
  return const TextStyle(
    fontSize: 20,
  );
}

TextStyle buttonTextStyle() {
  return const TextStyle(
    fontSize: 18,
  );
}

TextStyle zoomMenuTextStyle() {
  return const TextStyle(
    fontSize: 17,
    color: Colors.white,
  );
}

TextStyle cardTitleStyle() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle commentTitleStyle() {
  return const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87);
}

TextStyle commentSubTitleStyle() {
  return TextStyle(fontSize: 13, color: Colors.grey.shade800);
}

TextStyle commentTimeStyle() {
  return TextStyle(fontSize: 13, color: Colors.grey.shade500);
}

const TextStyle financeTitleStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

 TextStyle defaultMonthTextStyle(context) => TextStyle(
  color: Theme.of(context).textTheme.bodyLarge!.color,
  fontSize: Dimen.monthTextSize,
  fontWeight: FontWeight.w500,
);

 TextStyle defaultDateTextStyle(context) => TextStyle(
  color: Theme.of(context).textTheme.bodyLarge!.color,
  fontSize: Dimen.dateTextSize,
  fontWeight: FontWeight.w500,
);

 TextStyle defaultDayTextStyle(context) => TextStyle(
  color: Theme.of(context).textTheme.bodyLarge!.color,
  fontSize: Dimen.dayTextSize,
  fontWeight: FontWeight.w500,
);
