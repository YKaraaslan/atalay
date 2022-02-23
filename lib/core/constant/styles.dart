import 'package:flutter/material.dart';

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