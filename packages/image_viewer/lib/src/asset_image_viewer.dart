import 'package:flutter/material.dart';

import 'base_view.dart';

class AssetImageViewer extends StatelessWidget {
  const AssetImageViewer(
      {Key? key, required this.heroAttribute, required this.imagePath})
      : super(key: key);
  final String heroAttribute;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      heroAttribute: heroAttribute,
      child: Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
