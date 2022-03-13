import 'dart:io';

import 'package:atalay/core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';

class SignUpShowPhoto extends StatelessWidget {
  const SignUpShowPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final File imagePath = ModalRoute.of(context)!.settings.arguments as File;
    return BaseView(
      backgroundColor: Colors.black,
      onPageBuilder: (context, value) => Center(
        child: FileImageViewer(
          heroAttribute: 'photo',
          imagePath: imagePath,
        ),
      ),
    );
  }
}