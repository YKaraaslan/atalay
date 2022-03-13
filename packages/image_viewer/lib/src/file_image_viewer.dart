import 'dart:io';

import 'package:flutter/material.dart';

import 'base_view.dart';

class FileImageViewer extends StatelessWidget {
  const FileImageViewer(
      {Key? key, required this.heroAttribute, required this.imagePath})
      : super(key: key);
  final String heroAttribute;
  final File imagePath;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      heroAttribute: heroAttribute,
      child: Image.file(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
