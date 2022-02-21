import 'package:flutter/material.dart';

import '../constant/styles.dart';

class name extends StatelessWidget {
  const name({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: titleStyle(context),);
  }
}
