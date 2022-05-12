import 'package:flutter/material.dart';

import '../constant/sizes.dart';
import '../constant/styles.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({Key? key, required this.text, required this.fun})
      : super(key: key);

  final String text;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.width_100percent(context),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: fun,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: buttonTextStyle(),
          ),
        ),
      ),
    );
  }
}
